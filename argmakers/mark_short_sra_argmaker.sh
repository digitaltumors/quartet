acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
short_marking=$6
samtools=$7

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}_rg.bam
	outbase=$outdir/${sra}/${sra}
    flagstat_size=$(wc -c $outdir/${sra}/${sra}_marked_flagstat.txt | cut -f 1 -d ' ')
	mkdir -p $outdir/${sra}
    if [ $flagstat_size -gt 500 ] && [ -f $outdir/${sra}/${sra}_rg.bam ] ; then
        true
    else
        flagstat_size_prev=$(wc -c $inpath/${sra}/${sra}_rg_flagstat.txt | cut -f 1 -d ' ')
        if [ -f $inpath/${sra}/${sra}.bam ] && [ ! -f $outdir/${sra}/${sra}_marked.bam ] && [ $flagstat_size_prev -gt 500 ] ; then
            echo "sh $script $input_file $outbase $accession $short_marking $samtools" >> $argsoutpath
        fi
    fi
	
done < $acc_file