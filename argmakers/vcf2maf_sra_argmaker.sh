acc_file=$1
inpath=$2
outdir=$3
argsoutpath=$4
script=$5
reference=$6
samtools=$7
vcf2maf=$8
vep=$9
bcftools=${10}

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do
	accession=$sra
	input_file=$inpath/${sra}/quartet/${sra}.quartet.vcf
	outbase=$outdir/${sra}/quartet/
	if [ -f $input_file ] && [ ! -s $inpath/${sra}/quartet/${sra}.quartet.maf ]; then
		rm $outdir/${sra}/quartet/${sra}.quartet.vep.vcf
		echo "sh $script $input_file $outbase $accession quartet $reference $samtools $vcf2maf $vep $bcftools" >> $argsoutpath
	fi
	
done < $acc_file
