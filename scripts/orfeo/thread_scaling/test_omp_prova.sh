#!/bin/bash
#SBATCH --nodes=1                   # 1 node
#SBATCH --ntasks=1                  # total MPI tasks across nodes
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128           # OpenMP threads per MPI task
#SBATCH --mem=0                     # use all available memory
#SBATCH --partition=EPYC
#SBATCH -t 00:20:00                 # 5 minutes for profiling and test runs
#SBATCH --job-name=HPC_Project

# Set OpenMP variables
export OMP_PLACES=cores
export OMP_PROC_BIND=close
# export OMP_DISPLAY_AFFINITY=TRUE

# Load MPI module if needed
module load openMPI/5.0.5

mkdir -p ./output/orfeo/scaling/baseline

# Compile the code
mpicc -D_XOPEN_SOURCE=700 -o main -march=native -O3 -std=c17 -fopenmp -Iinclude ./src/stencil_template_parallel.c

for nt in 1 2 4 8 16 32 64 128
do
    export OMP_NUM_THREADS=$nt
    echo "Running with $nt threads"
    datetime=$(date +"%Y%m%d_%H%M%s")
    srun --ntasks=1 --cpus-per-task=$nt --cpu-bind=cores ./main -x 10000 -y 10000 -n 100 -o 0 -e 10 > ./output/orfeo/prova/baseline/output_${datetime}_1Task_${nt}Threads_.log 2>&1
done