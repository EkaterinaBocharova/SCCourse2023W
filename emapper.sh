#!/bin/bash

#SBATCH --job-name=emapper
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=24:00:00
#SBATCH --partition=basic
#SBATCH --output=/scratch/course/2023w300106/katya/ex13/emapper.log
#SBATCH --error=/scratch/course/2023w300106/katya/ex13/emapper.err
#SBATCH --mail-type=END
#SBATCH --mail-user=a12307340@unet.univie.ac.at

### ENVIRONMENT
module load conda
conda activate eggnog-mapper-2.1.12

### SETTING UP DIRECTORIES
cd /scratch/course/2023w300106/katya
mkdir ex13
cd ex13

### COMMAND LINE
emapper.py -i /scratch/course/2023w300106/katya/jaNemVec.transdecoder/proteinTransdecoder.fasta \
--cpu 16 --itype proteins --data_dir /scratch/mirror/eggnog-mapper/2.1.12 \
-m diamond --pident 60 --query_cover 60 --subject_cover 70 --tax_scope 'eukaryota_broad' --resume \
--output jaNemVec1_emapper --output_dir /lisc/scratch/course/2023w300106/katya/ex13 \
--temp_dir ${TMPDIR}



