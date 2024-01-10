#!/bin/bash

#SBATCH --job-name=Augustus-Chr1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=24:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex9/Augustus.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex9/Augustus.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load conda
module list
conda activate augustus-3.5.0

### SETTING UP DIRECTORIES
# cd into my own directory
cd /scratch/course/2023w300106/katya
mkdir ex9
cd ex9

### EXECUTION
augustus --strand=both --genemodel=complete --gff3=on --outfile=nemVec_augustus.gff --species=nematostella_vectensis \
/scratch/course/2023w300106/katya/ncbi_dataset/data/GCF_932526225.1/chr1.fasta

