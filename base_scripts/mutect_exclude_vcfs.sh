basedir=$1
java=$2
gatk=$3
reference=$4

for sra_dir in $basedir/* ; do
	sra=$(basename $sra_dir)
	inp_file=$basedir/$sra/mutect2/$sra.vcf.filt.gz
	out_file=$basedir/$sra/mutect2/$sra.exclude.vcf.filt.gz
	if [ -f $inp_file ] && [ ! -s $out_file ]; then
		bcftools view --exclude 'FILTER~"weak_evidence"||FILTER~"map_qual"||FILTER~"strand_bias"||FILTER~"slippage"||FILTER~"clustered_events"||FILTER~"base_qual"' $inp_file >> $out_file
	fi
done
