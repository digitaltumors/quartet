basedir=$1
bcftools=$2

for file in $basedir/* ; do
	sra=$(basename $file | cut -d '.' -f 1)
	$bcftools view -e 'FILTER ~ "LowEVS" || FILTER ~ "LowDepth"' $basedir/${sra}/strelka2/results/variants/somatic.all.vcf.gz > $basedir/${sra}/strelka2/${sra}.filt.vcf
done