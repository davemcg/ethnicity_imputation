#!/bin/bash
module load samtools/1.3.1
module load vcftools/0.1.14

# vcf must be bgzip and tabix indexed
single_sample_vcf=$1
#/data/mcgaugheyd/genomes/1000G_phase2_GRCh37/ALL.chromosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
g1k_vcf=$2
# end name in "vcf.gz"
output_vcf_name=$3

bcftools merge $single_sample_vcf $g1k_vcf -R $single_sample_vcf | \
	bgzip > /scratch/mcgaugheyd/$output_vcf_name

tabix -p vcf /scratch/mcgaugheyd/$output_vcf_name

# only keep AC count > 9
bcftools view /scratch/mcgaugheyd/$output_vcf_name -c 10 | bgzip > $output_vcf_name

# make sure vcf is sorted properly
vcf-sort -c $output_vcf_name | bgzip > $output_vcf_name.tmp
mv $output_vcf_name.tmp $output_vcf_name
tabix -p vcf $output_vcf_name
