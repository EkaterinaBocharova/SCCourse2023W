#!/bin/bash

#SBATCH --job-name=FILTERBAM
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex7/FILTERBAM.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex7/FILTERBAM.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load samtools
module list

### SETTING UP DIRECTORIES
# cd into my own directory
cd /scratch/course/2023w300106/katya
mkdir ex7
cd ex7

#FILTERING BAM FILE
samtools view -b -o /scratch/course/2023w300106/BAMS/SRR24348401.f.bam \
-q 20 -f 0x2 -F 0x4 -@ 8 \
/scratch/course/2023w300106/katya/ex6/SRR24348401Aligned.sortedByCoord.out.bam
