# SCCourse2023W

First of all, we downloaded the RNA-Seq reads (accession number SRR24348401) from the GeneBank database, the genome with annotations and the transcriptome of Nematostella vectensis from ENA. The fasterq-dump tool was used to extract data in FASTQ-format from SRA-accessions:
fasterq-dump SRR24348401 -O SRR24348401

Then we create a reference genome index in STAR (boost the lookup and alignment process):
STAR —-runMode genomeGenerate —-runThreadN 8 —-genomeDir jaNemVect1.1_STAR --genomeFastaFiles GCF_932526225.1_jaNemVect1.1_genomic.fna --genomeSAindexNbases 13

After that, the scripts were run as followed:

1. We mapped the reads to Nematostella genome by STAR to test if they are correct: starTeast.sh
2. We used Trimmomatic to remove adapter sequences and low quality bases (reads) from our reads (to improve mapping efficiency and accuracy): trimmomatic.sh
3. Then we checked the quality of the reads by FastQC tool.
4. Again, we used the aligner STAR to align the trimmed reads (only paired) to the indexed genome: Trim_Star.sh
5. The sortedbycoordinateBAM file was filtered as it had contained poorly mapping reads and artefacts to have only informative aligments: FilterBAM.sh
6. For identifying functional elements (gene annotation) in the genome sequence we used the genome and annotation files and also the filtered BAM file: StringTie.sh
7. To predict gene models in chromosome 1 we used Augustus: Augustus.sh
8. To summarise gene counts we applied featureCounts tool with count matrix as an output: CountReads.sh
9. To visualise the result from featureCounts (normalising, filtering, reshaping, plotting, filtering using tidyverse and principal component analysis to identify biological replicates) we used R in RSudio: Rplots-bocharova.R
10. Then we mapped the trimmed reads to Nematostella transcriptome (HAD001) using the same parameters as for mapping to the genome: star_transcr.sh
11. We compared efficiency of mapping to the genome and to the transcriptome by statistics and PCA: Genome-transcr.R
12. We used gffread to extract protein sequences from genome, blastp to align prooteins to uniref, add GO term annotation and find concerved motifs, then we applied interproscan and eggnog-mapper to add GO term annotation and fing concerved motifs: Interproscan.sh and emapper.sh
13. To obtain count matrix for single cell data we used cellranger software. Used the indexed transcriptome and fastq files of the data: cellranger.sh
