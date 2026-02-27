#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=0
#SBATCH --partition=EPYC
#SBATCH -t 00:30:00                 # 30 minuti, abbondanti
#SBATCH --job-name=OMP_scaling
#SBATCH --output=./output/orfeo/slurm_%j.log

export OMP_PLACES=cores
export OMP_PROC_BIND=close

module load openMPI/5.0.5

mkdir -p ./output/orfeo

mpicc -D_XOPEN_SOURCE=700 -o main -march=native -O3 -std=c17 -fopenmp \
      -Iinclude ./src/stencil_template_parallel.c

for nt in 1 2 4 8 16 32 64 128
do
    export OMP_NUM_THREADS=$nt
    echo "=== Running with $nt OMP threads ==="
    datetime=$(date +"%Y%m%d_%H%M%S")
    srun --ntasks=1 \
         --cpus-per-task=$nt \
         --cpu-bind=cores \
         ./main -x 10000 -y 10000 -n 100 -o 0 -e 10 \
         > ./output/orfeo/omp_${datetime}_${nt}threads.log 2>&1
    echo "Done: $nt threads"
done