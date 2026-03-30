acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
reference=$6
bcftools=$7

declare -a callers=('strelka2' 'deepsomatic' 'mutect2' 'lancet2')

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	for caller in "${callers[@]}" ; do
	
		if [ $caller = 'strelka2' ] ; then
			input_file=$inpath/${sra}/strelka2/${sra}.filt.vcf
		elif [ $caller = 'lancet2' ] ; then
			input_file=$inpath/${sra}/$caller/${sra}.scored.rehead.vcf.gz
		elif [ $caller = 'deepsomatic' ] ; then
			input_file=$inpath/${sra}/$caller/${sra}.filt.vcf
		else
			input_file=$inpath/${sra}/$caller/${sra}.exclude.vcf.filt.gz
		fi
		
		outbase=$outdir/${sra}/$caller/
		if [ -f $input_file ]; then
			sh $script $input_file $outbase $accession $reference $bcftools
		fi
	done
	
	
done < $acc_file
