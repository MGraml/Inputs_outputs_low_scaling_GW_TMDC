#!/bin/bash
# Job Name and Files (also --job-name)
#SBATCH -J MoS2

#Output and error (also --output, --error):
#SBATCH -o ./%x.%j.out
#SBATCH -e ./%x.%j.err

#Initial working directory (also --chdir):
#SBATCH -D ./

# Change here the job size and time limit:
#SBATCH --time=25:55:00
#SBATCH --nodes=34
#SBATCH --ntasks-per-core=1
#SBATCH --ntasks-per-node=24
#SBATCH --partition=fat
#SBATCH --no-requeue

#Setup of execution environment
#SBATCH --export=NONE
#SBATCH --get-user-env
#SBATCH --account=pn72pa

module load slurm_setup
export OMP_NUM_THREADS=2
ulimit -s unlimited
export OMP_STACKSIZE=2000m
exec="/hppfs/work/pn72pa/di76zil/23_compilation/50_as_49_further_rpa_gw_im_time_util/cp2k/exe/supermuc_jw_intel19_2022_04_11/cp2k.psmp"

mpiexec -n $SLURM_NTASKS $exec *.inp >& cp2k.out
