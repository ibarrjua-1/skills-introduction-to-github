#!/bin/bash

# Submit this script with: sbatch <this-filename>
#SBATCH --time=01:00:00              # Walltimei
#SBATCH --partition=gpu
#SBATCH --gres=gpu:p100:1           # You need to request one GPU to be able to run AlphaFold properly
#SBATCH --ntasks=1                   # Number of tasks
#SBATCH --cpus-per-task=16           # Number of CPU cores per task
#SBATCH --nodes=1                    # Number of nodes
#SBATCH --mem=190GB                   # Memory
#SBATCH -J NAME.e%j            # Job name

# Email notifications
#SBATCH --mail-user=$USER@caltech.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
eval "$(micromamba shell hook --shell bash)"
micromamba activate ENVIROMENT

#code 
echo done 
