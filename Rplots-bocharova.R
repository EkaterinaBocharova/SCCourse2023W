getwd() #working directory
setwd("/scratch/course/2023w300106/katya/ex10") #change the directory

vector1 <- 5 #numeric, one-dimetional
vector1 <- "class" #string
vector1 <- c(1,2,3,4,5,6,7,8,9,10)
mean(vector1)
median(vector1)
max(vector1)
min(vector1)
vector1 ^ 2
boxplot(vector1)
accel <- vector1 ^ 2

plot(vector1, accel)
plot(vector1, vector1 ^ 4)

summary <- read.table("CountReadRairs.tsv.summary", sep = "\t", comment.char = "#", header = TRUE)
summary
names(summary)
names(summary)<-gsub("X.scratch.course.2023w300106.BAMS.", "", names(summary)) # replace the names

"../katya/" #see the directions

library(tidyverse)

summary <- read_tsv("CountReadRairs.tsv.summary", comment = "#")
names(summary)<-gsub("/scratch/course/2023w300106/BAMS/", "", names(summary))

summary[1,]
summary[1,1]
summary[1,2:12]
summary[,4]
mean(unlist(summary[1,2:12]))

colSums(summary[,2:12]) #results of each column of the 1 row
summary1 <- summary[,2:12]/colSums(summary[,2:12]) * 1000000 # normalisation


library(edgeR)
scaledCPM <- cpm(summary[,2:12]) # normalisation

boxplot(scaledCPM[1,])
boxplot(scaledCPM[12,]) #noise or non-annotated genes
boxplot(scaledCPM[14,]) #aligned to the opposite strand

sessionInfo() #to know the packages uploaded

rownames(scaledCPM) <- unlist(summary[,1]) #to add names of the rows

library(reshape2)
scaledCPMMelt <- melt(scaledCPM) #generated table in 3 columns
dim(scaledCPMMelt) #metrics

ggplot(scaledCPMMelt, aes(x=Var1, y=value)) + geom_boxplot() 
ggplot(scaledCPMMelt, aes(x=Var1, y=value)) + geom_boxplot() + coord_flip()
ggplot(scaledCPMMelt, aes(y=Var1, x=value)) + geom_boxplot() 

scalesCPMMelt <- melt(scaledCPM[rowSums(scaledCPM)>0, ]) #we take a row if the sum of the row is more than 0

ggplot(scalesCPMMelt, aes(x=Var1, y=value)) + geom_boxplot()
ggplot(scalesCPMMelt, aes(x=Var1, y=value)) + geom_violin()
ggplot(scalesCPMMelt, aes(x=Var1, y=value, col=Var1)) + geom_jitter()
ggplot(scalesCPMMelt, aes(x=Var1, y=value, col=Var1)) + geom_boxplot()
ggplot(scalesCPMMelt, aes(x=Var1, y=value, col=Var1)) + geom_boxplot() + scale_colour_viridis_d()
ggplot(scalesCPMMelt, aes(x=Var1, y=value, col=Var1)) + geom_boxplot() + theme_bw() + scale_colour_viridis_d() + theme(axis.text.x = element_text(angle = 90)) + labs(x="", y="Number of reads(CPM)", col="Category")
ggplot(scalesCPMMelt, aes(x=Var1, y=value, col=Var2)) + geom_boxplot() + theme_bw() + geom_jitter()
ggplot(scalesCPMMelt, aes(x=Var1, y=value, col=Var2)) + geom_boxplot() + theme_bw() + geom_jitter(width=0.1)
ggplot(scalesCPMMelt, aes(x=Var1, y=value)) + theme_bw() + geom_boxplot(aes(col=Var1)) + geom_jitter(width=0.1, aes(col=Var2))


#libraries
library(edgeR)
library(reshape2)
library(tidyverse)

#loading data and normalizing
counts <- read.table("CountReadRairs.tsv", sep="\t", header = TRUE, row.names=1, ?)

counts <- read_tsv("CountReadRairs.tsv", comment = "#")
counts <- counts[, c(1,6:17)] #selection of needed columns

rpk <- counts[, 3:13] / unlist(counts[,2]) * 1000 #reads per kilobase

length(rpk)
names(rpk)

names(rpk)<-gsub("/scratch/course/2023w300106/BAMS/", "", names(rpk))

tpm <- cpm(rpk) # transcripts per million

tpm[1:5,1:5]

summary(tpm)

#how many reads per gene?

colSums(tpm)

rownames(tpm) <- counts$Geneid
rownames(tpm) <- unlist(counts[,1]) 

melNorm <- melt(tpm)

ggplot(melNorm) + geom_boxplot(aes(x=Var2, y=value, col=Var2))

# filtering
tpmFil <- tpm[rowSums(tpm)>0,] # remove all the genes, which are not expressed

# reshaping
meltpmFil <- melt(tpmFil)

# plotting
ggplot(meltpmFil) + geom_boxplot(aes(x=Var2, y=value, col=Var2))
ggplot(meltpmFil) + #take data to plot from meltpmFil table
  geom_boxplot(aes(x=Var2, y=value, col=Var2)) + # plot a boxplot using library as X and read counts as Y
  scale_y_log10() #log-transform the data for plotting

ggplot(meltpmFil) +
  geom_violin(aes(x=Var2, y=value, col=Var2)) +
  scale_y_log10()

ggplot(meltpmFil) +
  geom_boxplot(aes(x=Var2, y=value, col=Var2)) +
  scale_y_continuous(tran="log1p")

ggplot(meltpmFil, aes(x=Var2, y=value, col=Var2)) + 
  geom_violin() +
  geom_boxplot(width=0.1) + 
  scale_y_log10()

ggplot(meltpmFil, aes(x=Var2, y=value, col=Var2)) + 
  geom_violin() +
  geom_boxplot(width=0.1) + 
  scale_y_log10() +
  theme_bw() +
  labs(y="Read counts per gene (TMP)", x="", col = "Library") +
  theme(axis.text.x = element_blank())

ggplot(meltpmFil, aes(x=Var2, y=value, col=Var2)) + #aestatics Var2 - categorized variable in x, y-numeric value, col - coloured categories
  geom_violin() +
  geom_boxplot(width=0.1) + 
  scale_y_log10() +
  theme_bw() +
  labs(y="Read counts per gene (TMP)", x="", col = "library")

#Filtering using tidyverse

head(meltpmFil)
meltpmFil %>% group_by(Var2) %>% arrange(desc(value), .by_group = TRUE)
meltpmFil %>% group_by(Var2) %>% arrange(desc(value), .by_group = TRUE) %>% dplyr ::filter(row_number()<=5) #group by library, sort by value and filter the first 5 rows

meltpmFil %>% group_by(Var2) %>% arrange(desc(value), .by_group = TRUE) %>% dplyr::filter(row_number()<=5) %>% ungroup() %>% group_by(Var1) %>% summarise(count=n()) %>% arrange(desc(count)) # how many libraries have these top-5 most expressed genes

meltpmFil %>% dplyr::filter(value>=1) %>% dim()

meltpmFil %>% dplyr::filter(value>=1) %>% group_by(Var1) %>% summarise(count=n())

meltpmFil %>% dplyr::filter(value>=1) %>% group_by(Var1) %>% summarise(count=n()) %>% ggplot(aes(x=count)) +
  geom_histogram()

meltpmFil %>% dplyr::filter(value>=1) %>% group_by(Var1) %>% summarise(count=n()) %>% ggplot(aes(y=count)) +
  geom_boxplot() # genes, which have significant expression

meltpmFil %>% dplyr::filter(value>=1) %>% group_by(Var1) %>% summarise(count=n()) %>% ggplot(aes(y=count, x=1)) +
  geom_violin()

meltpmFil %>% dplyr::filter(value>=1) %>% ggplot(aes(x=value,col=Var2)) +
  geom_density() + scale_y_log10() + scale_x_log10()

meltpmFil %>% dplyr::filter(value>=1) %>% ggplot(aes(x=value,col=Var2)) +
  geom_density() + scale_y_log10() + scale_x_log10() + labs(y='log of friequency', x='log of gene expression')

meltpmFil %>% dplyr::filter(value>=1) %>% #filter tpm valuee greater than 1, why? bc
  ggplot(aes(y=value,col=Var2)) + # plotting and setting aestthetics
  geom_violin(aes(x=Var2)) + # we chose violin plot
  scale_y_log10() + # we scale the y axis to soften the long distance
  geom_boxplot(width=0.15, aes(x=Var2)) # we draw a boxplot for reference 






