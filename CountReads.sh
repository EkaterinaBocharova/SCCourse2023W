#!/bin/bash

#SBATCH --job-name=CountReadRairs
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=4G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex10/CountReadRairs.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex10/CountReadRairs.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load subread
module list

### SETTING UP DIRECTORIES
mkdir /scratch/course/2023w300106/katya/ex10
cd ex10

### ACTUAL COMMAND WE WILL BE USING
featureCounts -Q 20 -p --countReadPairs -C -T 16 -s 2 \
	      -a /scratch/course/2023w300106/jmontenegro/ex2/annotation/tmp.gtf \
	      -o CountReadRairs.tsv  /scratch/course/2023w300106/BAMS/*.f.bam
