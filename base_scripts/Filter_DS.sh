basedir=$1
bcftools=$2

for file in $basedir/* ; do
	sra=$(basename $file | cut -d '.' -f 1)
	if [ ! -s $basedir/${sra}/deepsomatic/${sra}.filt.vcf ] && [ -s $basedir/${sra}/deepsomatic/${sra}.vcf ]; then
		$bcftools view -i 'FILTER="PASS"' $basedir/${sra}/deepsomatic/${sra}.vcf > $basedir/${sra}/deepsomatic/${sra}.filt.vcf
	fi
done
