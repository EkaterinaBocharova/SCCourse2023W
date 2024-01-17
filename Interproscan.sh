#!/bin/bash

#SBATCH --job-name=Interproscan
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=24:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex12/interproscan.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex12/interproscan.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load interproscan
module list

### SETTING UP DIRECTORIES
# cd into my own directory
cd /scratch/course/2023w300106/katya
mkdir ex12
cd ex12

#STRINGTIE COMMAND LINE
interproscan.sh -b /scratch/course/2023w300106/katya/ex12/NemVec.function -cpu 16 -etra \
-f TSV,GFF3 -goterms -i /scratch/course/2023w300106/katya/jaNemVec.transdecoder/proteinTransdecoder.fasta \
-iprlookup -pa -t p