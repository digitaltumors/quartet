acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
trim_galore=$6

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do

    accession=$sra
    input_file=$inpath/${sra}/${sra}.bam
    outbase=$outdir/${sra}/${sra}
	
    type="gzip"
    in_file_1=${outbase}_1.fastq.gz
    in_file_2=${outbase}_2.fastq.gz
	out_file_1=${outbase}.fq1_val_1.fq.gz

    outdir_sample=$outdir/${sra}/

	if [ -s $in_file_1 ] && [ -s $in_file_2 ] && [ ! -f $out_file_1 ]; then
		echo "sh $script $in_file_1 $in_file_2 $accession $outdir_sample $trim_galore" >> $argsoutpath
	fi
    
done < $acc_file