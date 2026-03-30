acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
samtools=$6
strelkaconfig=$7

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}.bam
	outbase=$outdir/${sra}/
	mkdir -p $outdir/${sra}
	if [ -f $input_file ]; then
		echo "sh $script $input_file $outbase $accession $samtools $strelkaconfig" >> $argsoutpath
	fi
	
done < $acc_file
