input_bam=$1
outdir=$2
sra=$3
lancet2=$4
deepsomatic=$5

mkdir -p $outdir/lancet2
mkdir -p $outdir/deepsomatic

tmp_dir=/tmp/

cp ${input_bam} $tmp_dir
cp ${input_bam}.bai $tmp_dir

singularity run --nv --bind $tmp_dir:/tmp/ $lancet2 bash -c "Lancet2 pipeline -t /tmp/${sra}.bam -n /tmp/NA12878.new.sorted.bam -b /tmp/hg38_exome_regions_refseq.bed -r /tmp/GCF_000001405.26_GRCh38_genomic.fna -T 32 -o /tmp/${sra}.vcf.gz"

mv $tmp_dir/${sra}.vcf.gz $outdir/lancet2/
mv $tmp_dir/${sra}.vcf.gz.tbi $outdir/lancet2/

mkdir $tmp_dir/${sra}_examples

singularity run --nv --bind $tmp_dir:/tmp/ $deepsomatic bash -c "time seq 0 31 | parallel --tmpdir /tmp/ -q --halt 2 --line-buffer /opt/deepvariant/bin/make_examples_somatic --mode calling --ref /tmp/GCF_000001405.26_GRCh38_genomic.fna --reads_tumor /tmp/${sra}.bam --reads_normal /tmp/NA12878.new.sorted.bam --examples \"/tmp/${sra}_examples/make_examples_somatic.tfrecord@32.gz\" --checkpoint \"/opt/models/deepsomatic/wes\" --gvcf \"/tmp/${sra}_examples/gvcf.tfrecord@32.gz\" --vsc_max_fraction_indels_for_non_target_sample 0.5 --vsc_max_fraction_snps_for_non_target_sample 0.5 --vsc_min_fraction_indels 0.05 --vsc_min_fraction_snps 0.029 --task {} --regions /tmp/hg38_exome_regions_refseq.bed"

mv $tmp_dir/${sra}_examples $outdir/deepsomatic/
rm /$tmp_dir/${sra}.bam
rm /$tmp_dir/${sra}.bam.bai