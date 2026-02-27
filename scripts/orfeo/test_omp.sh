#!/bin/bash
#SBATCH --nodes=1                   # 1 node
#SBATCH --ntasks=1                  # total MPI tasks across nodes
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128           # OpenMP threads per MPI task
#SBATCH --mem=0                     # use all available memory
#SBATCH --partition=EPYC
#SBATCH -t 00:05:00                 # 5 minutes for profiling and test runs
#SBATCH --job-name=HPC_Project

# Set OpenMP variables
export OMP_PLACES=cores
export OMP_PROC_BIND=close
# export OMP_DISPLAY_AFFINITY=TRUE

# Load MPI module if needed
module load openMPI/5.0.5

# Compile the code
mpicc -D_XOPEN_SOURCE=700 -o main -march=native -O3 -std=c17 -fopenmp -Iinclude ./src/stencil_template_parallel.c

for nt in 1 4 16 32 64 128
do
    export OMP_NUM_THREADS=$nt
    echo "Running with $nt threads"
    datetime=$(date +"%Y%m%d_%H%M%s")
    srun --ntasks=1 --cpus-per-task=$nt --cpu-bind=cores ./main -o 0 -e 300 -v 1 > ./output/orfeo/output_${datetime}_1Task_${nt}Threads_.log
done