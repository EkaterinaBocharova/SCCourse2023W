#!/bin/bash

#SBATCH --job-name=star_transcr
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex11/star.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex11/star.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load star
module list

### SETTING UP DIRECTORIES
# cd into my own directory
cd /scratch/course/2023w300106/katya
mkdir ex11
cd ex11

### RUNNING THE COMMAND
STAR --runThreadN 16 --genomeDir /scratch/course/2023w300106/katya/HAD001_STAR --readFilesIn /scratch/course/2023w300106/katya/SRR24348401/trim/SRR24348401_R1.qc.fastq /scratch/course/2023w300106/katya/SRR24348401/trim/SRR24348401_R2.qc.fastq --twopassMode Basic --outFileNamePrefix SRR24348401_HAD001_ --outSAMtype BAM SortedByCoordinate
