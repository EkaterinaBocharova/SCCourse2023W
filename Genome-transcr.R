setwd("/scratch/course/2023w300106/stats")
genome_stats <- read_tsv("genome.stats")
transcr_stats <- read_tsv("transcriptome.stats")

genome_stats$reference <- "genome"
genome_stats

transcr_stats$reference <- "transcriptome"
transcr_stats

mergedStat <- rbind(genome_stats, transcr_stats)
mergedStat %>% dplyr::filter(category == "Uniquely_mapped_reads_number")

mergedStat %>% dplyr::filter(category == "Uniquely_mapped_reads_number") %>% ggplot(aes(x=reference, y=value)) +
  geom_boxplot()

mergedStat %>% dplyr::filter(category == "Uniquely_mapped_reads_Percentage") %>% ggplot(aes(x=reference, y=value)) +
  + geom_boxplot()

# Plots for every category
mergedStat %>% dplyr::filter(grepl("Percentage", category)) %>% ggplot(aes(x=reference, y=value)) + facet_grid(~category) + geom_boxplot()
#grepl - regular expression

mergedStat %>% dplyr::filter(grepl("Percentage", category)) %>% ggplot(aes(x=reference, y=value)) + facet_grid(~category) + geom_boxplot(aes(col=reference)) + theme()

mergedStat %>% dplyr::filter(grepl("Percentage", category)) %>% ggplot(aes(x=reference, y=value)) +
  facet_grid(~category, scales = "free_y") + geom_boxplot(aes(col=reference)) + theme()

mergedStat %>% dplyr::filter(grepl("Percentage", category)) %>% ggplot(aes(x=reference, y=value)) +
  facet_grid(~category, scales = "free_x") + geom_boxplot(aes(col=reference)) + theme()

mergedStat %>% dplyr::filter(grepl("Percentage", category)) %>% ggplot(aes(x=reference, y=value)) +
  facet_grid(~category, scales = "free") + geom_boxplot(aes(col=reference)) + theme()

# Principal component analysis
?prcomp
# transpose the table
t(tpmFil)
pcaRes <- prcomp(t(tpmFil), center = TRUE, scale. = FALSE)
pcaRes$sdev
names(pcaRes)

ggplot(as.data.frame(pcaRes$x), aes(x=PC1, y=PC2)) + geom_point()

ggplot(as.data.frame(pcaRes$x), aes(x=PC1, y=PC2)) + geom_point(aes(col=rownames(pcaRes$x)))

library(ggsci)
library(ggrepel)

ggplot(as.data.frame(pcaRes$x), aes(x=PC1, y=PC2)) +
  geom_point(aes(col=rownames(pcaRes$x))) +
  scale_color_futurama() + theme_bw()

ggplot(as.data.frame(pcaRes$x), aes(x=PC1, y=PC2)) +
  geom_point(aes(col=rownames(pcaRes$x))) + #color the points based on library names
  geom_label_repel(aes(label=rownames(pcaRes$x))) + # add labels to the data points
  scale_color_futurama() + # change the colour palette
  theme_bw() # white background

ggplot(as.data.frame(pcaRes$x), aes(x=PC1, y=PC2)) +
  geom_point(aes(col=rownames(pcaRes$x))) + #color the points based on library names
  geom_label_repel(size = 2, aes(label=rownames(pcaRes$x))) + # add labels to the data points
  scale_color_futurama() + # change the colour palette
  theme_bw() +
  theme(legend.position = "none") # remove the legend



