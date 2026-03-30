basedir=$1
reference=$2
jobs_file=$3
java=$4
gatk=$5

for sra_dir in $basedir/* ; do
	sra=$(basename $sra_dir)
	echo $sra
	inp_file=$basedir/$sra/$sra.vcf.gz
	tmp_file=$basedir/$sra/$sra.vcf.tmp.gz
	out_file=$basedir/$sra/$sra.vcf.filt.gz

	if [ ! -f $out_file ] && [ -f $inp_file ]; then
		echo "$java -jar $gatk IndexFeatureFile -I $inp_file ; $java -jar $gatk FilterMutectCalls --min-allele-fraction 0.15 -V $inp_file -R $reference -O $out_file" >> $jobs_file
	fi
done
