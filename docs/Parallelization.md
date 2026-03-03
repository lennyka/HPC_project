# Parallelization Strategy

This document describes the parallel design choices made to transform the serial 5-point stencil solver into a hybrid MPI+OpenMP implementation.

---

## Table of Contents

1. [Data Dependency Analysis](#data-dependency-analysis)
2. [Domain Decomposition](#domain-decomposition)
3. [Halo Communication](#halo-communication)
4. [Communication-Computation Overlap](#communication-computation-overlap)
5. [OpenMP Thread Parallelism](#openmp-thread-parallelism)
6. [NUMA-Aware Initialization (Touch-by-All)](#numa-aware-initialization-touch-by-all)
7. [Timing and Synchronization](#timing-and-synchronization)
8. [Memory Layout and Buffer Design](#memory-layout-and-buffer-design)

---

## Data Dependency Analysis

The core update formula is:

$$T_{i,j}^{t+1} = \frac{T_{i,j}^{t}}{2} + \frac{T_{i-1,j}^{t} + T_{i+1,j}^{t} + T_{i,j-1}^{t} + T_{i,j+1}^{t}}{8}$$

The value of cell $(i,j)$ at time $t+1$ depends only on values from time $t$. There are no write-after-write or read-after-write dependencies within the same iteration — every grid point can be computed independently. This makes the stencil update embarrassingly parallel.

Two separate buffers (`OLD` and `NEW`) are maintained and swapped each iteration, eliminating any possibility of race conditions between threads or ranks.

The only inter-process dependency is **spatial**: cells at the boundary of a rank's patch need one row or column of data from a neighboring rank. This data must be exchanged once per iteration before the boundary update can proceed.

---

## Domain Decomposition

The global grid $S_x \times S_y$ is partitioned into a 2D grid of MPI ranks. The decomposition algorithm computes the aspect ratio of the global grid and selects the layout that minimizes the surface-to-volume ratio of each patch, reducing halo data per unit of computation compared to a 1D strip decomposition.

```c
double formfactor = ((*S)[_x_] >= (*S)[_y_]
    ? (double)(*S)[_x_] / (*S)[_y_]
    : (double)(*S)[_y_] / (*S)[_x_]);
int dimensions = 2 - (Ntasks <= ((int)formfactor + 1));
```

For a square grid with many ranks, this always selects 2D. For highly rectangular grids with few ranks, it falls back to 1D strips.

Each rank computes its own patch size accounting for remainder cells, so any grid size and any number of tasks is handled correctly:

```c
uint s = (*S)[_x_] / Grid[_x_];
uint r = (*S)[_x_] % Grid[_x_];
mysize[_x_] = s + (X < r);   // first r ranks get one extra column
```

No rank is ever more than one cell heavier than another, avoiding synchronization bottlenecks.

---

## Halo Communication

Each rank's local patch is embedded in a $(S_x+2) \times (S_y+2)$ frame. The outer ring holds ghost cells populated by neighbors each iteration.

### N/S: zero-copy pointer approach

The grid is stored in row-major order, so rows are contiguous in memory. North and South halos are entire rows — the send and receive buffers are just pointers directly into `plane->data`, requiring no copy:

```c
buffers[SEND][NORTH] = &plane->data[IDX(1, 1)];       // first interior row
buffers[RECV][NORTH] = &plane->data[IDX(1, 0)];       // ghost row above
buffers[SEND][SOUTH] = &plane->data[IDX(1, ysize)];   // last interior row
buffers[RECV][SOUTH] = &plane->data[IDX(1, ysize+1)]; // ghost row below
```

### E/W: explicit pack/unpack

Columns are not contiguous — elements are spaced `fxsize` doubles apart. East and West halos must be packed into a flat buffer before sending and unpacked after receiving:

```c
for (uint i = 0; i < ysize; i++)
    buffers[SEND][EAST][i] = plane->data[IDX(xsize, i + 1)];
```

Only E/W buffers are heap-allocated in `memory_allocate`. N/S pointers are set at the start of each iteration in `fill_buffers`, requiring no dynamic allocation.

### Non-blocking calls

All communications use `MPI_Isend` / `MPI_Irecv`, which post the messages without blocking. A private communicator duplicate is used for all calls to isolate the application's messages from any library using `MPI_COMM_WORLD`:

```c
MPI_Comm_dup(MPI_COMM_WORLD, &myCOMM_WORLD);
```

---

## Communication-Computation Overlap

The iteration loop is structured to hide network latency behind useful computation:

```c
// 1. Pack E/W send buffers
fill_buffers(&planes[current], neighbours, N, buffers, periodic);

// 2. Post all 8 non-blocking messages
halo_communications(&planes[current], neighbours, buffers, &myCOMM_WORLD, reqs);

// 3. Compute interior points — MPI messages travel in the background
update_inner_points(&planes[current], &planes[!current]);

// 4. Wait for halo data — often already arrived
MPI_Waitall(8, reqs, MPI_STATUSES_IGNORE);

// 5. Unpack E/W receive buffers
copy_halo(&planes[current], neighbours, N, buffers, periodic);

// 6. Compute boundary points that depend on halo data
update_boundary_points(&planes[current], &planes[!current], periodic, N);
```

`update_inner_points` computes all interior rows (j = 2 to ysize-1), which do not depend on any halo data. By the time `MPI_Waitall` is called, the messages have typically already arrived. The `wait_time` field in the output directly measures the unhidden latency — it remains below 10 ms across all node counts tested on Leonardo.

---

## OpenMP Thread Parallelism

The MPI thread level is declared as `MPI_THREAD_FUNNELED`:

```c
MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &level_obtained);
```

This declares that only the master thread will ever call MPI functions. It is the minimum level required for a hybrid program and avoids the synchronization overhead that `MPI_THREAD_MULTIPLE` would impose on the MPI library internals.

The stencil update in `update_inner_points` is parallelized over rows with AVX2 manual intrinsics in the inner loop:

```c
#pragma omp parallel for
for (uint j = 2; j < ysize; j++)
{
    uint i = 2;
    for (; i < xsize - 1; i += 4)   // AVX2: 4 doubles per iteration
    {
        __m256d center = _mm256_loadu_pd(&old[IDX(i,   j)]);
        __m256d left   = _mm256_loadu_pd(&old[IDX(i-1, j)]);
        __m256d right  = _mm256_loadu_pd(&old[IDX(i+1, j)]);
        __m256d up     = _mm256_loadu_pd(&old[IDX(i,   j-1)]);
        __m256d down   = _mm256_loadu_pd(&old[IDX(i,   j+1)]);
        __m256d result = _mm256_add_pd(
            _mm256_mul_pd(center, _mm256_set1_pd(0.5)),
            _mm256_mul_pd(_mm256_add_pd(_mm256_add_pd(left, right),
                                        _mm256_add_pd(up, down)),
                          _mm256_set1_pd(0.125)));
        _mm256_storeu_pd(&new[IDX(i, j)], result);
    }
    for (; i <= xsize - 1; i++)   // scalar tail
        new[IDX(i, j)] = stencil_computation(old, fxsize, i, j);
}
```

`schedule(static)` in boundary and initialization loops ensures each thread always processes the same rows across iterations, keeping data warm in private L1/L2 cache.

---

## NUMA-Aware Initialization (Touch-by-All)

On NUMA architectures, the OS maps a memory page to the physical memory bank of the thread that first writes to it. If initialization is done by a single thread (e.g. `memset`), all pages land on that thread's socket, forcing all other threads to suffer remote memory latency for the entire run.

The initialization loop mirrors the 2D row-major access pattern and `schedule(static)` of the compute loop:

```c
// Touch-by-all: thread k initialises exactly the rows it will later compute
#pragma omp parallel for schedule(static)
for (uint j = 0; j < ysize + 2; j++)
    for (uint i = 0; i < xsize + 2; i++)
        planes_ptr[OLD].data[j * (xsize + 2) + i] = 0.0;
```

This is called **touch-by-all** rather than plain touch-first: the thread that initializes a page is the same one that will access it throughout the entire run. The OS page placement therefore matches the computational access pattern exactly.

---

## Timing and Synchronization

```c
MPI_Barrier(myCOMM_WORLD);
double t0 = MPI_Wtime();
```

Without the barrier, faster ranks would start the timer before slower ones have finished initialization, producing artificially skewed elapsed times. The barrier ensures all ranks begin timing from the same moment.

Per-phase timers are accumulated across all iterations and averaged across ranks:

| Field | Measures |
|-------|----------|
| `inject_time` | Energy injection per step |
| `fill_buff_time` | Packing E/W send buffers |
| `comm_time` | `MPI_Isend`/`MPI_Irecv` posting |
| `wait_time` | `MPI_Waitall` — unhidden latency |
| `copy_halo_time` | Unpacking E/W receive buffers |
| `update_time` | Stencil computation (inner + boundary) |

The ratio `wait_time / comm_time` directly measures how much of the communication latency was successfully hidden by the overlap strategy.

---

## Memory Layout and Buffer Design

```
plane->data layout (row-major, with halo frame):

  [ghost N row         ]   j = 0
  [interior rows       ]   j = 1 .. ysize
  [ghost S row         ]   j = ysize+1

  columns: i=0 (ghost W),  i=1..xsize (interior),  i=xsize+1 (ghost E)
```

Index macro: `IDX(i, j) = j * (xsize + 2) + i`

Only E/W buffers are allocated on the heap. N/S buffers are interior pointers into `plane->data` — freeing them would corrupt the plane data. `memory_release` therefore only frees E/W:

```c
if (buffers_ptr[SEND][EAST] != NULL) free(buffers_ptr[SEND][EAST]);
if (buffers_ptr[RECV][EAST] != NULL) free(buffers_ptr[RECV][EAST]);
if (buffers_ptr[SEND][WEST] != NULL) free(buffers_ptr[SEND][WEST]);
if (buffers_ptr[RECV][WEST] != NULL) free(buffers_ptr[RECV][WEST]);
// N/S: never freed — they point inside plane->data
```
