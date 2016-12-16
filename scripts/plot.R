#!/usr/bin/env Rscript

library(data.table)
library(Rtsne)
library(tidyverse)

args <- commandArgs(trailingOnly=True)
plink_raw <- data.frame(fread(args[1]))
ped <- data.frame(fread('~/git/ethnicity_imputation/data/1000g_20130606.ped'))

geno_mat <- as.matrix(plink_raw[,7:ncol(plink_raw)])

tsne <- Rtsne(geno_mat, perplexity=10, theta=0.0, check_duplicates=FALSE)

plot <- data.frame(tsne$Y)

plot$ID <- plink_raw$IID

plot <- left_join(plot, ped, by=c('ID'='Individual.ID'))

ggplot(all,aes(x=X1,y=X2,colour=Population)) + geom_point() + scale_colour_brewer(palette='Set1') + theme_bw()
