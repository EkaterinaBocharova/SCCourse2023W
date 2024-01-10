#!/bin/bash

#SBATCH --job-name=STRINGTIE
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=2G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex8/stringtie.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex8/stringtie.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load stringtie
module list

### SETTING UP DIRECTORIES
# cd into my own directory
cd /scratch/course/2023w300106/katya
mkdir ex8
cd ex8

#STRINGTIE COMMAND LINE
stringtie /scratch/course/2023w300106/BAMS/SRR24348401.f.bam -l NemVecV1 -o NemVecAnnotation.gtf -p 6 -u
