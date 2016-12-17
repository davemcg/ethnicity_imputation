#!/usr/bin/env Rscript

library(data.table)
library(Rtsne)
library(tidyverse)

args <- commandArgs(trailingOnly=True)
plink_raw <- data.frame(fread(args[1]))
ped <- data.frame(fread('~/git/ethnicity_imputation/data/1000g_20130606.ped'))

geno_mat <- as.matrix(plink_raw[,7:ncol(plink_raw)])
geno_mat_clean <- geno_mat[ , colSums(is.na(geno_mat)) == 0]
# Take highest variance
var <- apply(geno_mat_clean,2,var)
geno_var <- geno_mat_clean[,var>0.5]

tsne <- Rtsne(geno_var, perplexity=50, theta=0.0, check_duplicates=FALSE)

plot <- data.frame(tsne$Y)
plot$ID <- plink_raw$IID
plot <- left_join(plot, ped, by=c('ID'='Individual.ID'))
ggplot(plot,aes(x=X1,y=X2,colour=Super.Population,shape=Population)) + geom_point(size=3) + scale_colour_brewer(palette='Set1') + theme_bw() + scale_shape_manual(values=c(1:24,40:45))
