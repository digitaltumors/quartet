acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
reference=$6
dbsnp=$7
java=$8
gatk=$9

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}_markdups.bam
	outbase=$outdir/${sra}/${sra}
	mkdir -p $outdir/${sra}
    flagstat_size=$(wc -c $outdir/${sra}/${sra}_flagstat.txt | cut -f 1 -d ' ')
    if [ $flagstat_size -gt 500 ] && [ -f $outdir/${sra}/${sra}_flagstat.txt ] && [ -f $outdir/${sra}/${sra}.bam ] ; then
        true
    else
        flagstat_size_prev=$(wc -c $outdir/${sra}/${sra}_markdups_flagstat.txt | cut -f 1 -d ' ')
		if [ -f $input_file ] && [ ! -f $outdir/${sra}/${sra}_recal_data.table ]  ; then
            echo "sh $script $input_file $outbase $accession $reference $dbsnp $java $gatk" >> $argsoutpath
        fi
    fi
done < $acc_file