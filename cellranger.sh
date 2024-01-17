#!/bin/bash

#SBATCH --job-name=cellranger
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20G
#SBATCH --time=24:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex16/cellranger.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex16/cellranger.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load cellranger
module list

### SETTING UP DIRECTORIES
cd /scratch/course/2023w300106/katya
mkdir ex16
cd ex16

cellranger count --id 12hr --transcriptome /lisc/scratch/course/2023w300106/katya/ex15/NemVec \
--fastqs /scratch/course/2023w300106/12hr1/run1,/scratch/course/2023w300106/12hr1/run2,/scratch/course/2023w300106/12hr1/run3 \
--sample 89085 --nosecondary --localcores 16