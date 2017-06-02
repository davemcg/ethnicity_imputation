# ethnicity_imputation
Workflow to impute ethnicity from NGS (exome/WGS) on 1000 genomes data

The short answer is: use peddy (http://peddy.readthedocs.io). peddy is fabulous, easy, and lightning fast. It also checks for gender mixup, sequencing issues, and other awesome things. 

So, why not peddy? Well, it only imputes to 'Super Population,' e.g. east asia, european, south asia, etc. If you want to attempt to match a sample to a population (1000G has 26: http://www.internationalgenome.org/category/population/), then you will have to do some more work. 

---------------------------
Workflow:

1. Get 1000Genomes VCF
2. Merge your sample VCF with 1000G VCF
3. Filter to keep high quality positions
4. Dimensionality reduction (PCA, MDS, t-sne)

Details:
1. Get 1000Genomes VCF
  * the first problem is that 1000G provides their sample-specific genotypes only as VCF files split by chromosomes. This could be considered a plus since you have instant parallelization for the merge step (II.). However I found that the merge process didn't work well with the separate files, since my sample's VCF has all chromosomes and the merged vcf had lots of blank positions for the 'missing' chromosomes.
  * I could split by sample VCF by chromsome, but then I'd have to handle 20+ files. I'm not doing this too often, so I'm more interested in keeping this simple and slow instead of fast and complicated. 
  * create a all chromosomes VCF with BCFtools concat (http://www.htslib.org/doc/bcftools.html)
  * scripts/concat_1000G.sh
  * output vcf from above here:
  * /data/mcgaugheyd/genomes/1000G_phase2_GRCh37/ALL.chromosomes.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
2. Merge your sample VCF with 1000g VCF
  * if you start with a multi-sample VCF, use vcf_sample_stripper.sh to extrat one sample
  * scripts/bcftools_merge.sh
3. Remove missing genotypes and reformat to tabular format for R
  * scripts/vcf_to_table.R
4. Dimensionality reduction (PCA, MDS, t-sne)
  * read data into R, ID high variance positions, and run PCA, MDS, and/or t-sne
  * scripts/plot.R
