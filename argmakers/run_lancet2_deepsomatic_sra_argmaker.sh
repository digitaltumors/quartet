acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
lancet2=$6
deepsomatic=$7

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}.bam
	outbase=$outdir/${sra}
	mkdir -p $outdir/${sra}/deepsomatic
	mkdir -p $outdir/${sra}/lancet2
	echo $input_file
	if [ -f $input_file ] ; then
		echo "sh $script $input_file $outbase $accession $lancet2 $deepsomatic" >> $argsoutpath
	fi
	
done < $acc_file
