basedir=$1
bcftools=$2

for file in $basedir/SRR* ; do
	sra=$(basename $file | cut -d '.' -f 1)
	if [ ! -s $basedir/${sra}/lancet2/${sra}.filt.vcf.gz ] && [ -s $basedir/${sra}/lancet2/${sra}.scored.rehead.vcf.gz ]; then
		$bcftools view -i 'FILTER="PASS"' $basedir/${sra}/lancet2/${sra}.scored.rehead.vcf.gz > $basedir/${sra}/lancet2/${sra}.filt.vcf.gz
	fi
done
