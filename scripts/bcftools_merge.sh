#!/bin/bash
module load samtools/1.3.1

# vcf must be bgzip and tabix indexed
single_sample_vcf=$1
# end name in "vcf.gz"
output_vcf_name=$2

bcftools merge $single_sample_vcf ALL.chromosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -R $single_sample_vcf | \
	bgzip > $output_vcf_name

tabix -p vcf $output_vcf_name

# make sure vcf is sorted properly
vcf-sort -c $output_vcf_name.gz | bgzip > $output_vcf_name.tmp
mv $output_vcf_name.tmp $output_vcf_name
tabix -p vcf $output_vcf_name.tmp
