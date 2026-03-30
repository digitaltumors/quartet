basedir=$1
java=$2
gatk=$3
reference=$4

for sra_dir in $basedir/* ; do
	sra=$(basename $sra_dir)
	inp_file=$basedir/$sra/mutect2/$sra.vcf.gz
	tmp_file=$basedir/$sra/mutect2/$sra.vcf.tmp.gz
	out_file=$basedir/$sra/mutect2/$sra.vcf.filt.gz

	if [ ! -s $out_file ] && [ -s $inp_file ]; then
		$java -jar $gatk IndexFeatureFile -I $inp_file
		$java -jar $gatk FilterMutectCalls --min-allele-fraction 0.15 -V $inp_file -R $reference -O $out_file 
	fi
done
