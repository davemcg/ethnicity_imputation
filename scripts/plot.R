#!/usr/bin/env Rscript

library(data.table)
library(Rtsne)
library(tidyverse)

args <- commandArgs(trailingOnly=True)
plink_raw <- data.frame(fread(args[1]))
ped <- data.frame(fread('~/git/ethnicity_imputation/data/1000g_20130606.ped'))

geno_mat <- t(as.matrix(plink_raw[,7:ncol(plink_raw)]))

# Take highest variance
var <- apply(geno_mat_clean,2,var)
geno_var <- geno_mat_clean[,var>0.5]

tsne <- Rtsne(geno_var, perplexity=50, theta=0.0, check_duplicates=FALSE)


plot <- data.frame(tsne$Y)
samples <- colnames(plink_raw)[7:ncol(plink_raw)]
samples1 <- sapply(samples, function(x) strsplit(x, '_')[[1]][1])

plot$ID <- samples1
plot <- left_join(plot, ped, by=c('ID'='Individual.ID'))
# hand edit the 'Super Population' and 'Population' fields with the unknown sample info 
ggplot(plot,aes(x=X1,y=X2,colour=Super.Population,shape=Population)) + geom_point(size=3) + scale_colour_brewer(palette='Set1') + theme_bw() + scale_shape_manual(values=c(1:24,40:45))
