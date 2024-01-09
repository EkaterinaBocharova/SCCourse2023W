#!/bin/bash

#SBATCH --job-name=trimmomatic
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=10:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex5/trimmomatic.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex5/trimmomatic.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load trimmomatic/0.39
module list

### SETTING UP DIRECTORIES
mkdir /scratch/course/2023w300106/katya/SRR24348401/trim
cd trim

### ACTUAL COMMAND WE WILL BE USING
trimmomatic PE -threads 8 \
-trimlog trimmomatic.log \
-summary trimmomatic.summary.txt \
/scratch/course/2023w300106/katya/SRR24348401/SRR24348401_1.fastq \
/scratch/course/2023w300106/katya/SRR24348401/SRR24348401_2.fastq \
/scratch/course/2023w300106/katya/SRR24348401/trim/SRR24348401_R1.qc.fastq \
/scratch/course/2023w300106/katya/SRR24348401/trim/SRR24348401_S1.qc.fastq \
/scratch/course/2023w300106/katya/SRR24348401/trim/SRR24348401_R2.qc.fastq \
/scratch/course/2023w300106/katya/SRR24348401/trim/SRR24348401_S2.qc.fastq \
ILLUMINACLIP:/scratch/course/2023w300106/katya/ex5/adapters.fa:2:30:10 \
SLIDINGWINDOW:6:15 \
MINLEN:75

