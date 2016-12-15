# ethnicity_imputation
Workflow to impute ethnicity from NGS (exome/WGS) on 1000 genomes data

The short answer is: use peddy (http://peddy.readthedocs.io). peddy is fabulous, easy, and lightning fast. It also checks for gender mixup, sequencing issues, and other awesome things. 

So, why not peddy. Well, it only imputes to 'Super Population,' e.g. east asia, european, south asia, etc. If you want to attempt to match a sample to a population (1000G has 26: http://www.internationalgenome.org/category/population/), then you will have to do some more work. 

---------------------------
Workflow:

I. Get 1000G vcf

II. Merge your sample VCF with 1000G vcf

III. Filter to keep high quality positions

IV. Dimensionality reduction (PCA, MDS, t-sne)

Details:

I. Get 1000G vcf
- the first problem is that 1000G provides their sample-specific genotypes only as vcf files split by chromosomes. This could be considered a plus since you have instant parallelization for the merge step (II.). However I found that the merge process didn't work well with the separate files, since my sample's vcf has all chromosomes and the merged vcf had lots of blank positions for the 'missing' chromosomes.
- I could split by sample VCF by chromsome, but then I'd have to handle 20+ files. I'm not doing this too often, so I'm more interested in keeping this simple and slow instead of fast and complicated. 
- create a all chromosomes VCF with BCFtools concat (http://www.htslib.org/doc/bcftools.html)

II. 
