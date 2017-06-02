# ethnicity_imputation
Workflow to impute ethnicity from NGS (exome/WGS) on 1000 genomes data

The short answer is: use peddy (http://peddy.readthedocs.io). peddy is fabulous, easy, and lightning fast. It also checks for gender mixup, sequencing issues, and other awesome things. 

So, why not peddy? Well, it only imputes to 'Super Population,' e.g. east asia, european, south asia, etc. If you want to attempt to match a sample to a population (1000G has 26: http://www.internationalgenome.org/category/population/), then you will have to do some more work. 

---------------------------
Workflow Overview (biowulf2):

1. Get 1000Genomes VCF
    * 1000G only gives sample-specific  genotypes as VCF split by chr
    * Need to merge into a single VCF
2. Merge your sample VCF with 1000G VCF
3. Filter to keep high quality positions
4. Dimensionality reduction (PCA, MDS, t-sne)

Example Use:
1. Get 1000Genomes VCF (only need to do once)
    * scripts/concat_1000G.sh
    * output vcf from above here:
        * /data/mcgaugheyd/genomes/1000G_phase2_GRCh37/ALL.chromosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
2. Merge your sample VCF with 1000g VCF
    * if you start with a multi-sample VCF, use [vcf_sample_stripper.sh](https://github.com/davemcg/biowulf2-bin/blob/master/vcf_sample_stripper.sh) to extract one sample
        * ~/git/ethnicity_imputation/vcf_sample_stripper.sh /data/mcgaugheyd/projects/nei/brooks/master_vcf/OGVFB_biesecker.exomes.bwa.b37.GATK3.5.2017-03-02.hardFilterSNP-INDEL.VEP.GRCh37.vcf.gz 1501 1501.vcf.gz
    * ~/git/ethnicity_imputation/scripts/bcftools_merge.sh 1501.vcf.gz /data/mcgaugheyd/genomes/1000G_phase2_GRCh37/ALL.chromosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 1501.g1k.vcf.gz
3. Remove missing genotypes and reformat to tabular format for R
    * ~/git/ethnicity_imputation/scripts/vcf_to_table.sh 1501.g1k.vcf.gz 1501.g1k
4. Dimensionality reduction (PCA, MDS, t-sne)
    * read data into R, ID high variance positions, and run PCA, MDS, and/or t-sne
    * ~/git/ethnicity_imputation/scripts/plot.R
