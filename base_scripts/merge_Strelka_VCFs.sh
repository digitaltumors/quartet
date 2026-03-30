basedir=$1
java=$2
picard=$3

for sample in $basedir/* ; do
	if [ -s $sample/strelka2/results/variants/somatic.snvs.vcf.gz ] && [ ! -s $sample/strelka2/results/variants/somatic.all.vcf.gz ] ; then
		$java -jar $picard MergeVcfs -I $sample/strelka2/results/variants/somatic.snvs.vcf.gz -I $sample/strelka2/results/variants/somatic.indels.vcf.gz -O $sample/strelka2/results/variants/somatic.all.vcf.gz
	fi
done