#!/bin/bash

module load plink/1.9

merged_vcf=$1
out_prefix=$2

# puts the vcf in a tabular format for R
plink --vcf $merged-vcf --vcf-filter --vcf-require-gt --double-id --recode A --out $out_prefix
