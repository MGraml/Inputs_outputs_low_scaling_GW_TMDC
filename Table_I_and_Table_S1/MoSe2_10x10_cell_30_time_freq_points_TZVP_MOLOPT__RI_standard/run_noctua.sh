#!/bin/bash
#SBATCH -t 06:10:00
#SBATCH --exclusive
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=8
#SBATCH -N 80
#SBATCH -J "local_bandgap"

export OMP_NUM_THREADS=4
export OMP_PLACES=cores
export OMP_PROC_BIND=true

module reset
module load chem/CP2K/2023.1-foss-2022b-gcc-openmpi-openblas
srun  /pc2/groups/hpc-prf-eprop2d/eprop2d1_Jan/02_compile_CP2K/03_regularization_minimax/cp2k/exe/local/cp2k.psmp    *.inp &> cp2k.out
