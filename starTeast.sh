#!/bin/bash

#SBATCH --job-name=starTest
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex5/star.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex5/star.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load star
module list

### SETTING UP DIRECTORIES
# cd into my own directory
cd /scratch/course/2023w300106/katya
mkdir ex5
cd ex5

### RUNNING THE COMMAND
# we test the reads if they are mapped to the genome, the output is sorted BAM file
STAR --runThreadN 16 \
--genomeDir /scratch/course/2023w300106/katya/ncbi_dataset/data/GCF_932526225.1/jaNemVect1.1_STAR \
--readFilesIn /scratch/course/2023w300106/katya/SRR24348401/SRR24348401_1.fastq /scratch/course/2023w300106/katya/SRR24348401/SRR24348401_2.fastq \
--outSAMtype BAM SortedByCoordinate \
--twopassMode Basic \
--outSAMstrandField intronMotif \
--outFileNamePrefix SRR24348401
