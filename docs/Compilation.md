# Compilation Guide

---

## Compiler

The project uses `mpicc`, an MPI wrapper around GCC that automatically adds the correct include paths and links the MPI libraries. OpenMP support is enabled with `-fopenmp`.

On Leonardo, load the required modules before compiling:

```bash
module load gcc/12.2.0
module load openmpi/4.1.6--gcc--12.2.0
```

On Orfeo:

```bash
module load openMPI/5.0.5
```

---

## Compilation Command

```bash
mpicc -fopenmp -O3 -march=native -std=c17 -Iinclude src/stencil_template_parallel.c -o main
```

**Important:** `-march=native` detects the CPU of the node where you compile. Always compile on a compute node, not the login node, to avoid generating instructions unsupported on compute nodes.

On Leonardo, request an interactive session first:

```bash
srun --account=uTS25_Tornator_0 \
     --partition=dcgp_usr_prod \
     --nodes=1 --ntasks=1 --cpus-per-task=16 \
     --time=00:30:00 --pty bash -i
```

---

## Flag Analysis

### `-O3` — Optimization Level

The highest standard GCC optimization level. Enables loop vectorization (converts scalar loops to SIMD instructions), function inlining, and instruction reordering. Required for the compiler to auto-vectorize the stencil loops.

### `-march=native` — Architecture Tuning

Enables all instruction set extensions available on the current CPU. On Leonardo DCGP (Ice Lake), this includes AVX-512. On Orfeo EPYC (Zen 2), this includes AVX2.

This flag is necessary but not sufficient for vectorization — the code also includes manual AVX2 intrinsics in `update_inner_points` to guarantee 4-double SIMD width regardless of compiler heuristics.

### `-fopenmp` — OpenMP Support

Enables processing of `#pragma omp` directives. Without this flag the directives are silently ignored and the code runs single-threaded.

### `-std=c17` — C Standard

Ensures consistent behavior for variable-length array rules, `restrict` qualifiers, and `_Generic` expressions used in the codebase.

---

## Vectorization

The inner stencil loop in `update_inner_points` uses manual AVX2 intrinsics from `<immintrin.h>`:

```c
#include <immintrin.h>

// processes 4 doubles per iteration (256-bit AVX2 register)
__m256d center = _mm256_loadu_pd(&old[IDX(i, j)]);
__m256d result = _mm256_add_pd(
    _mm256_mul_pd(center, _mm256_set1_pd(0.5)),
    _mm256_mul_pd(..., _mm256_set1_pd(0.125)));
_mm256_storeu_pd(&new[IDX(i, j)], result);
```

`_mm256_loadu_pd` (unaligned load) is used throughout because the neighbor accesses `IDX(i-1,j)` and `IDX(i+1,j)` are offset by 8 bytes relative to `center` and cannot be 32-byte aligned simultaneously. On modern Intel/AMD processors the penalty for unaligned loads is negligible when the access does not cross a cache line boundary, which is the common case for sequential row traversal.

To verify that the compiler also auto-vectorizes the remaining loops, add `-fopt-info-vec-optimized` during compilation:

```bash
mpicc -fopenmp -O3 -march=native -std=c17 -fopt-info-vec-optimized \
    -Iinclude src/stencil_template_parallel.c -o main
```

Expected output includes lines such as:
```
stencil_template_parallel.c:NNN: optimized: loop vectorized using 32 byte vectors
```

This confirms AVX2 (32-byte = 4 doubles) auto-vectorization for the loops that do not use manual intrinsics.

---

## Memory Alignment

The implementation uses standard `malloc` for plane allocation. `malloc` guarantees 16-byte alignment on x86, which is sufficient for `_mm256_loadu_pd` (unaligned load). Explicit 32- or 64-byte alignment via `posix_memalign` was not added because:

1. The neighbor accesses in the stencil (`left`, `right`) are inherently offset and cannot all be aligned simultaneously.
2. On Ice Lake and Zen 2, the hardware handles unaligned AVX2 loads with no throughput penalty in the common sequential access pattern.

This is a deliberate simplicity trade-off: the code avoids the complexity of stride padding while achieving the same practical throughput.

---

## Debug Build

For Valgrind / cachegrind analysis, compile with debug symbols and without frame-pointer omission:

```bash
mpicc -fopenmp -O3 -march=native -std=c17 -g -fno-omit-frame-pointer \
    -Iinclude src/stencil_template_parallel.c -o main_debug
```

Keep the grid small for cachegrind runs (e.g. `-x 512 -y 512 -n 100`) since Valgrind slows execution by 10–100×.
