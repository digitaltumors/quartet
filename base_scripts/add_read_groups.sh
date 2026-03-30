#!/bin/sh
input_bam=$1
outbase=$2
sra=$3
samtools=$4
tmp_dir=/tmp/
tmp_rg_bam=$tmp_dir/${sra}_rg.bam
out_rg_bam=${outbase}_rg.bam
$samtools addreplacerg -@ 10 -r 'ID:4' -r 'LB:lib1' -r 'PL:ILLUMINA' -r 'PU:unit1' -r 'SM:20' -o $tmp_rg_bam $input_bam
mv $tmp_rg_bam $out_rg_bam