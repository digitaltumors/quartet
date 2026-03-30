#!/bin/sh
input_vcf=$1
outbase=$2
sra=$3
caller=$4
reference=$5
samtools=$6
vcf2maf=$7
vep=$8
bcftools=$9

$bcftools view $input_vcf -Ov -o ${outbase}/$sra.$caller.vcf

perl $vcf2maf --input-vcf ${outbase}/$sra.$caller.vcf --output-maf ${outbase}/${sra}.$caller.maf --tumor-id $sra --samtools-exec=$samtools --ref-fasta $reference --vep-path=$vep --ncbi-build=GRCh38 --buffer-size 4000 --retain-info GT,GQ,SDP,DP,RD,AD