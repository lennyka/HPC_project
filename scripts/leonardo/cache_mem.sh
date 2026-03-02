#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --partition=dcgp_usr_prod
#SBATCH -A uTS25_Tornator_0
#SBATCH -t 00:30:00
#SBATCH --job-name=cachegrind_leo
#SBATCH --exclusive
#SBATCH --output=./output/leonardo/cachegrind/slurm_mem_%j.log

module load gcc/12.2.0
module load openmpi/4.1.6--gcc--12.2.0


# -g aggiunge debug symbols per cg_annotate
mpicc -D_XOPEN_SOURCE=700 -o main_val -march=native -O3 -std=c17 -fopenmp -g \
      -Iinclude ./src/stencil_parallel_mem.c

export OMP_NUM_THREADS=1

echo "=== Run 1: small grid 2000x2000 (fits in L3) ==="
valgrind --tool=cachegrind \
         --cache-sim=yes \
         --cachegrind-out-file=./output/leonardo/cachegrind/cachegrind_small.out \
         mpirun -np 1 ./main_val -x 2000 -y 2000 -n 10 -o 0 -e 5 \
         > ./output/leonardo/cachegrind/cachegrind_mem_small.log 2>&1

cg_annotate ./output/leonardo/cachegrind/cachegrind_small.out \
            >> ./output/leonardo/cachegrind/cachegrind_mem_small.log 2>&1

echo "=== Run 2: large grid 5000x5000 (exceeds L3) ==="
valgrind --tool=cachegrind \
         --cache-sim=yes \
         --cachegrind-out-file=./output/leonardo/cachegrind/cachegrind_large.out \
         mpirun -np 1 ./main_val -x 5000 -y 5000 -n 5 -o 0 -e 5 \
         > ./output/leonardo/cachegrind/cachegrind_mem_large.log 2>&1

cg_annotate ./output/leonardo/cachegrind/cachegrind_large.out \
            >> ./output/leonardo/cachegrind/cachegrind_mem_large.log 2>&1

echo "Done. Results in ./output/leonardo/cachegrind/"