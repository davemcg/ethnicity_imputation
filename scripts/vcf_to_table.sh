#!/bin/bash

module load  plink/1.9.0-beta4.1

merged_vcf=$1
out_prefix=$2

# puts the vcf in a tabular format for R
plink --vcf $merged_vcf --vcf-filter --vcf-require-gt --double-id --recode A-transpose --vcf-half-call m --out $out_prefix --allow-extra-chr

# remove rows with NA
grep -v NA $out_prefix.traw > $out_prefix.noNA.traw
