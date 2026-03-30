basedir=$1
filter_variants=$2

for file in $basedir/* ; do 
	sra=$(basename $file | cut -d '.' -f 1);
	if [ ! -s $basedir/${sra}/lancet2/${sra}.scored.rehead.vcf.gz ] ; then
		echo "20" > $basedir/${sra}/lancet2/${sra}.rehead.txt
		echo $sra >> $basedir/${sra}/lancet2/${sra}.rehead.txt
		bcftools reheader -s $basedir/${sra}/lancet2/${sra}.rehead.txt $basedir/${sra}/lancet2/${sra}.vcf.gz > $basedir/${sra}/lancet2/${sra}.rehead.vcf.gz
		python $filter_variants  $basedir/${sra}/lancet2/${sra}.rehead.vcf.gz > $basedir/${sra}/lancet2/$sra.scored.rehead.vcf.gz
	fi
done

