#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=00:10:00              # Walltime
#SBATCH --ntasks=1                   # Number of tasks
#SBATCH --cpus-per-task=12           # Number of CPU cores per task
#SBATCH --nodes=1                    # Number of nodes
#SBATCH --mem=20GB                   # Memory
#SBATCH -J metaspades.e%j            # Job name
#SBATCH --array=1-21                 # Array range (update based on number of FASTA files)

# Email notifications
#SBATCH --mail-user=jibarraa@caltech.edu
#SBATCH --mail-type=BEGIN,END,FAIL

# Optional output/error files
# SBATCH -p general
# SBATCH -o slurm.assembly.%A_%a.out
# SBATCH -e slurm.assembly.%A_%a.err

# Load required modules
module load mafft
module load hmmer

# Define the directory containing .fasta files
fasta_dir="/groups/enviromics/sal/nadia/hmms"  # Update with the correct path

# Create an array of .fasta files
fasta_files=(${fasta_dir}/*.fasta)

# Get the specific file for this array task
fasta_file="${fasta_files[$((SLURM_ARRAY_TASK_ID - 1))]}"  # Safe zero-based indexing

# Sanity check
echo "Processing: ${fasta_file}"

# Define output paths
aligned_file="${fasta_file}.aln"
hmm_file="${fasta_file}.hmm"

# Run MAFFT alignment
mafft "${fasta_file}" > "${aligned_file}"

# Build HMM profile
hmmbuild "${hmm_file}" "${aligned_file}"
