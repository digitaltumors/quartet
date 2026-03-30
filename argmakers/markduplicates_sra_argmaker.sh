acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
java=$6
gatk=$7

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}_sorted.bam
	outbase=$outdir/${sra}/${sra}
    flagstat_size=$(wc -c $outdir/${sra}/${sra}_markdups_flagstat.txt | cut -f 1 -d ' ')
    if [ $flagstat_size -gt 500 ] && [ -f $outdir/${sra}/${sra}_markdups_flagstat.txt ] && [ -f $outdir/${sra}/${sra}_markdups.bam ] ; then
        true
    else
        flagstat_size_prev=$(wc -c $outdir/${sra}/${sra}_sorted_flagstat.txt | cut -f 1 -d ' ')
        if [ -f $outdir/${sra}/${sra}_sorted.bam ] && [ $flagstat_size_prev -gt 500 ] ; then
            echo "sh $script $input_file $outbase $accession $java $gatk" >> $argsoutpath
        fi
    fi
done < $acc_file
