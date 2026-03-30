acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
deepsomatic=$6

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}.bam
	outbase=$outdir/${sra}/deepsomatic/
	if [ -f $outdir/${sra}/deepsomatic/${sra}_examples/call_variants_output-00000-of-00016.tfrecord.gz ]; then
		echo "sh $script $outbase $accession $deepsomatic" >> $argsoutpath
	fi
	
done < $acc_file
