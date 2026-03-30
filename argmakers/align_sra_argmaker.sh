acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
bbmap=$5
samtools=$6
bwa=$7

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file_1=$inpath/${sra}/${sra}.fq1_val_1.fq.gz
	input_file_2=$inpath/${sra}/${sra}.fq2_val_2.fq.gz
	outbase=$outdir/${sra}/${sra}
	mkdir -p $outdir/${sra}
	if [ -f $input_file_1 ] && [ -f $input_file_2 ] && [ ! -f $outbase.bam ] ; then
		echo "sh $script $input_file_1 $input_file_2 $outbase $bbmap $samtools $bwa" >> $argsoutpath
	fi
	
done < $acc_file