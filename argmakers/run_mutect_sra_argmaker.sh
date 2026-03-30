acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
pon=$6
germline_resource=$7
intervals=$8
java=$9
gatk=$10

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}.bam
	outbase=$outdir/${sra}/${sra}
	mkdir -p $outdir/${sra}
	if [ -f $input_file ]; then
		echo "sh $script $input_file $outbase $accession $pon $germline_resource $intervals $java $gatk" >> $argsoutpath
	fi
	
done < $acc_file
