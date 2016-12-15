#!/usr/bin/env Rscript

import(data.table)
import(Rtsne)
import(tidyverse)

args <- commandArgs(trailingOnly=True)
plink_raw <- data.frame(fread(args[1]))

