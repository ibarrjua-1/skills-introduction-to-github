#!/bin/bash

# Submit this script with: sbatch <this-filename>
#SBATCH --time=00:05:00   # walltime
#SBATCH --ntasks=4   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem 1GB   # memory per CPU core
#SBATCH -J example_script   # job name

# Notify at the beginning, end of job and on failure.
#SBATCH --mail-user=$USER@caltech.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

## /SBATCH -p general # partition (queue)
## /SBATCH -o slurm.assembly.%N.%j.out # STDOUT
## /SBATCH -e slurm.assembly.%N.%j.err # STDERR

#LOAD MODULES, INSERT CODE, AND RUN PROGRAMS HERE
eval "$(conda shell.bash hook)"

conda activate blast

blastn -query unknown_seqs/sequence-3.fasta -db ../../inclass_exercise1/SILVA_DB/SILVA_DB -out blast4.out -outfmt 6


sleep 100
echo done
