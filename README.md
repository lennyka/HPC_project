# Parallel 5-Point Stencil Heat Equation Solver

A hybrid **MPI + OpenMP** implementation of a 2D heat diffusion solver, developed as part of the High Performance Computing course at the Università di Trieste. The solver uses a 5-point stencil scheme with domain decomposition across MPI ranks and OpenMP thread parallelism within each rank.

$$T_{i,j}^{t+1} = \frac{T_{i,j}^{t}}{2} + \frac{T_{i-1,j}^{t} + T_{i+1,j}^{t} + T_{i,j-1}^{t} + T_{i,j+1}^{t}}{8}$$

---

## Documentation

- **[Parallelization Strategy](docs/Parallelization.md):** Domain decomposition, MPI non-blocking communication, overlap, and OpenMP integration.
- **[Compilation Guide](docs/Compilation.md):** Compiler flags, AVX2 vectorization, and optimization choices.
- **[Architecture](docs/Architecture.md):** Hardware specifications of Leonardo DCGP and Orfeo EPYC clusters.
- **[Scaling Analysis](docs/Scaling.md):** Thread scaling, strong scaling, and weak scaling results with graphs.

---

## The Problem

The simulation models heat diffusion on a 2D plate of size $S_x \times S_y$. At each time step, every interior point is updated according to the 5-point stencil formula above: half the current value stays, and the other half diffuses equally to the four cardinal neighbors. Heat sources inject energy at fixed points on the plate at regular intervals.

The computational domain is embedded in a $(S_x+2) \times (S_y+2)$ frame. The outer ring of ghost cells holds halo data received from neighboring MPI ranks (or zeros at physical boundaries).

---

## Build

```bash
mpicc -fopenmp -O3 -march=native -std=c17 -Iinclude src/stencil_template_parallel.c -o main
```

For debug builds (e.g. for Valgrind/cachegrind):

```bash
mpicc -fopenmp -O3 -march=native -std=c17 -g -fno-omit-frame-pointer -Iinclude src/stencil_template_parallel.c -o main
```

---

## Run

```bash
export OMP_NUM_THREADS=14
export OMP_PLACES=cores
export OMP_PROC_BIND=close
mpirun -np 8 ./main -x 30000 -y 30000 -n 1000 -e 300
```

### Command-line Options

| Flag | Description | Default |
|------|-------------|---------|
| `-x` | Grid size in x | 10000 |
| `-y` | Grid size in y | 10000 |
| `-n` | Number of iterations | 1000 |
| `-e` | Number of heat sources | 4 |
| `-E` | Energy per source | 1.0 |
| `-p` | Periodic boundary conditions (0/1) | 0 |
| `-o` | Output energy statistics (0/1/2) | 0 |
| `-v` | Verbose mode | 0 |

### Output Format

Each rank prints per-phase timing. Rank 0 also prints the averaged comp/comms breakdown:

```
Rank 0 :: inject time is 0.006, fill buffer time is 0.000, communication time is 0.007,
          wait time is 0.009, copy halo time is 0.000, update planes time is 2.29
---------Rank: 0     Elapsed time: 2.31---------
total injected energy is 300000, system energy is 299989
Comp time, Comms time
2.293296, 0.010529
```

---

## Cluster Configuration

Tests were run on two clusters:

| Cluster | CPU | Cores/node | Threads tested |
|---------|-----|------------|----------------|
| Orfeo EPYC | AMD EPYC 7H12 | 128 | 1 – 128 |
| Leonardo DCGP | Intel Xeon Platinum 8480+ | 112 | 1 – 112 |

MPI scaling tests on Leonardo: **8 tasks/node × 14 threads/task = 112 cores/node**.
