acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/${sra}_rg.bam
	outbase=$outdir/${sra}/${sra}_rg
	mkdir -p $outdir/${sra}
	if [ ! -s $outdir/$sra/${sra}_rg_flagstat.txt ] && [ -f $input_file ]; then
		echo "sh $script $input_file $outbase" >> $argsoutpath
	fi
	
done < $acc_file