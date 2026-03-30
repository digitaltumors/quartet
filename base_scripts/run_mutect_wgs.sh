#!/bin/sh

tmp_dir=/tmp/
input_bam=$1
outbase=$2
sra=$3
pon=$4
germline_resource=$5
intervals=$6
java=$7
gatk=$8

tmp_input_bam=$tmp_dir/${sra}.bam
tmp_germline_resource=$tmp_dir/af-only-gnomad-renamed.hg38.vcf.gz
tmp_pon=$tmp_dir/1000g_pon_renamed.hg38.vcf.gz
tmp_output_vcf=$tmp_dir/${sra}.vcf.gz
tmp_output_vcf_stats=$tmp_dir/${sra}.vcf.gz.stats
tmp_output_f1r2=$tmp_dir/${sra}_f1r2.tar.gz

reference=$tmp_dir/GCF_000001405.26_GRCh38_genomic.fna
normal=/tmp/NA12878.bam

cp $input_bam $tmp_input_bam
cp $input_bam.bai $tmp_input_bam.bai

output_vcf=${outbase}.vcf.gz
output_f1r2=${outbase}_f1r2.tar.gz
output_vcf_stats=${outbase}.vcf.gz.stats

$java -jar $gatk Mutect2 -R $reference -I $tmp_input_bam -I $normal -normal NA12878 --intervals $intervals --genotype-germline-sites True --genotype-pon-sites True --germline-resource $tmp_germline_resource --native-pair-hmm-threads 4 --f1r2-tar-gz $tmp_output_f1r2 --panel-of-normals $tmp_pon -O $tmp_output_vcf

cp $tmp_output_vcf $output_vcf
cp $tmp_output_f1r2 $output_f1r2
cp $tmp_output_vcf_stats $output_vcf_stats 
