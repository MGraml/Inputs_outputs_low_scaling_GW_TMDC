#!/bin/bash -l
# Job Name and Files (also --job-name)
#SBATCH -J 420

#Output and error (also --output, --error):
#SBATCH -o ./%x.%j.out
#SBATCH -e ./%x.%j.err

# Change here the job size and time limit:
#SBATCH --time=24:00:00
#SBATCH --nodes=26
#SBATCH --ntasks-per-core=1
#SBATCH --ntasks-per-node=18
#SBATCH --partition=multinode
#SBATCH --no-requeue

#Setup of execution environment
#SBATCH --export=NONE

unset SLURM_EXPORT_ENV 

module load slurm_setup
module load intel
module load mkl
module load intelmpi

source /home/atuin/b165da/b165da10/01_CP2K_compilations/09_toolchain_with_MKL_without_libtorch/cp2k/tools/toolchain/install/setup

export OMP_NUM_THREADS=4

exec="/home/atuin/b165da/b165da10/01_CP2K_compilations/04_develop_printing_LDOS_and_local_gap/cp2k/exe/local/cp2k.psmp"

mpiexec -n $SLURM_NTASKS $exec *.inp >& cp2k.out

