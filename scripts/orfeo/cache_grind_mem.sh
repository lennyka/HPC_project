#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --partition=EPYC
#SBATCH -t 00:30:00
#SBATCH --job-name=cachegrind
#SBATCH --output=./output/orfeo/cachegrind/slurm_mem_%j.log

module load openMPI/5.0.5

mkdir -p ./output/orfeo/cachegrind

# -g aggiunge debug symbols per cg_annotate
mpicc -D_XOPEN_SOURCE=700 -o main_val -march=native -O3 -std=c17 -fopenmp -g \
      -Iinclude ./src/stencil_parallel_mem.c

export OMP_NUM_THREADS=1

echo "=== Run 1: small grid 2000x2000 (L1/L2 fits in cache) ==="
valgrind --tool=cachegrind \
         --cache-sim=yes \
         --cachegrind-out-file=./output/orfeo/cachegrind/cachegrind_small.out \
         mpirun -np 1 ./main_val -x 2000 -y 2000 -n 10 -o 0 -e 5 \
         > ./output/orfeo/cachegrind/cachegrind_mem_small.log 2>&1

cg_annotate ./output/orfeo/cachegrind/cachegrind_small.out \
            >> ./output/orfeo/cachegrind/cachegrind_mem_small.log 2>&1

echo "=== Run 2: large grid 5000x5000 (exceeds L3 cache) ==="
valgrind --tool=cachegrind \
         --cache-sim=yes \
         --cachegrind-out-file=./output/orfeo/cachegrind/cachegrind_large.out \
         mpirun -np 1 ./main_val -x 5000 -y 5000 -n 5 -o 0 -e 5 \
         > ./output/orfeo/cachegrind/cachegrind_mem_large.log 2>&1

cg_annotate ./output/orfeo/cachegrind/cachegrind_large.out \
            >> ./output/orfeo/cachegrind/cachegrind_mem_large.log 2>&1

echo "Done. Results in ./output/orfeo/cachegrind/"