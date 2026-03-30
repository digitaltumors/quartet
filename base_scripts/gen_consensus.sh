snv_dir=$1
bedtools=$2

for file in $snv_dir/*/lancet2/*.norm.vcf.gz ; do
	sra=$(basename $file | cut -d '.' -f 1)
	mkdir -p $snv_dir/$sra/trio
	mkdir -p $snv_dir/$sra/quartet
	if [ -s $snv_dir/${sra}/lancet2/${sra}.norm.vcf.gz ] && [ -s $snv_dir/${sra}/deepsomatic/${sra}.norm.vcf.gz ] && [ -s $snv_dir/${sra}/mutect2/${sra}.norm.vcf.gz ] && [ -s $snv_dir/${sra}/strelka2/${sra}.norm.vcf.gz ] && [ ! -f $snv_dir/${sra}/quartet/${sra}.quartet.vcf ] ; then
	
		$bedtools intersect -header -a $snv_dir/${sra}/mutect2/${sra}.norm.vcf.gz -b $snv_dir/${sra}/mutect2/${sra}.norm.vcf.gz -f 1 -r > $snv_dir/${sra}/trio/${sra}.mutect.strelka.vcf.gz
		
		$bedtools intersect -header -f 1 -r -a $snv_dir/${sra}/trio/${sra}.mutect.strelka.vcf.gz -b $file > $snv_dir/${sra}/trio/${sra}.trio.vcf
		
		$bedtools intersect -header -f 1 -r -a $snv_dir/${sra}/trio/${sra}.trio.vcf -b $snv_dir/${sra}/deepsomatic/${sra}.norm.vcf.gz > $snv_dir/${sra}/quartet/${sra}.quartet.vcf
	fi
done