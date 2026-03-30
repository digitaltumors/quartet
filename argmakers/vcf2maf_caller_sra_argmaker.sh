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

declare -a callers=('strelka2' 'deepsomatic' 'mutect2' 'lancet2')

if [ -f "$argsoutpath" ] ; then
    rm "$argsoutpath"
fi

while IFS="" read -r sra || [ -n "$sra" ]; do

	for caller in "${callers[@]}" ; do
		accession=$sra
		input_file=$inpath/${sra}/${caller}/${sra}.wes.norm.vcf.gz
		outbase=$outdir/${sra}/${caller}/
		if [ -f $input_file ] && [ ! -s $inpath/${sra}/${caller}/${sra}.${caller}.maf ]; then
			rm $outdir/${sra}/${caller}/${sra}.${caller}.vep.vcf
			echo "sh $script $input_file $outbase $accession $caller $reference $samtools $vcf2maf $vep $bcftools" >> $argsoutpath
		fi
	done
	
done < $acc_file
