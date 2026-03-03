# Cluster Architecture

Tests were run on two HPC clusters available through the course: **Leonardo DCGP** at CINECA and **Orfeo** at Area Science Park (Trieste).

---

## Leonardo DCGP

Leonardo is a Tier-0 EuroHPC supercomputer hosted at CINECA. The DCGP (Data Centric General Purpose) partition is used for CPU-intensive workloads.

### Node Topology

| Feature | Specification |
|---------|---------------|
| CPU Model | Intel Xeon Platinum 8480+ |
| Microarchitecture | Sapphire Rapids (4th Gen Xeon, Ice Lake) |
| Sockets per node | 2 |
| Cores per socket | 56 |
| Total cores per node | 112 |
| Base / Turbo clock | 2.0 GHz / 3.8 GHz |
| ISA | AVX-512, AMX |

### Memory Architecture

| Feature | Specification |
|---------|---------------|
| Memory type | DDR5-4800 |
| Channels per socket | 8 |
| Bandwidth per socket | ~307 GB/s |
| Capacity per node | 512 GB (256 GB per socket) |
| NUMA domains | 2 (one per socket) |

Each node has two NUMA domains. A thread on socket 0 accessing memory on socket 1 must cross the UPI (Ultra Path Interconnect), incurring higher latency and lower effective bandwidth than local access.

### Cache Hierarchy

| Level | Capacity |
|-------|----------|
| L1 Data | 32 KB per core (private) |
| L1 Instruction | 48 KB per core (private) |
| L2 | 2 MB per core (private) |
| L3 (LLC) | 105 MB per socket (shared) |

The large L3 (105 MB per socket) plays a key role in strong scaling: as the number of ranks increases and each patch shrinks, the local working set eventually fits entirely in L3, eliminating DRAM accesses and producing the superlinear speedup observed in the strong scaling results.

### Interconnect

InfiniBand NDR200 (200 Gbps) for inter-node MPI communication.

### SLURM Configuration Used

```bash
#SBATCH --partition dcgp_usr_prod
#SBATCH -A uTS25_Tornator_0
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=14       # 8 × 14 = 112 cores/node
```

---

## Orfeo EPYC

Orfeo is the HPC cluster at Area Science Park in Trieste, used for thread scaling experiments.

### Node Topology

| Feature | Specification |
|---------|---------------|
| CPU Model | AMD EPYC 7H12 |
| Microarchitecture | Zen 2 |
| Sockets per node | 2 |
| Cores per socket | 64 |
| Total cores per node | 128 |
| Base / Boost clock | 2.6 GHz / 3.3 GHz |
| ISA | AVX2 |

### Memory Architecture

| Feature | Specification |
|---------|---------------|
| Memory type | DDR4-3200 |
| NUMA domains | 2 (one per socket) |
| Capacity per node | 256 GB |

EPYC Zen 2 has a strong NUMA topology: the two sockets are connected via Infinity Fabric. Remote memory accesses are noticeably slower than local ones, making NUMA-aware initialization more important on Orfeo than on Leonardo.

### Cache Hierarchy

| Level | Capacity |
|-------|----------|
| L1 Data | 32 KB per core (private) |
| L2 | 512 KB per core (private) |
| L3 | 16 MB per 8-core CCX (shared within CCX) |

The EPYC L3 is organized in CCX (Core CompleX) groups of 8 cores sharing 16 MB. A 128-core node has 16 CCX groups. This fragmented L3 topology means that threads on different CCX groups do not share cache, unlike Leonardo's monolithic 105 MB socket-level L3.

### SLURM Configuration Used

```bash
#SBATCH --partition=EPYC
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
```

---

## Architecture Comparison

| Feature | Leonardo DCGP | Orfeo EPYC |
|---------|--------------|------------|
| CPU | Intel Xeon 8480+ | AMD EPYC 7H12 |
| Cores/node | 112 | 128 |
| ISA | AVX-512 | AVX2 |
| L3 per socket | 105 MB (monolithic) | 16 MB × 8 CCX (fragmented) |
| Memory BW/socket | ~307 GB/s (DDR5) | ~200 GB/s (DDR4) |
| NUMA domains | 2 | 2 |
| Interconnect | InfiniBand NDR200 | — |

The higher memory bandwidth of Leonardo (DDR5 vs DDR4) explains why thread scaling achieves better absolute times on Leonardo. The fragmented L3 on EPYC means that at high thread counts, data sharing between threads on different CCX groups incurs extra latency, which is visible in the thread scaling plateau observed between 16 and 32 threads on Orfeo before the second socket is engaged.
