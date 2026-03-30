#!/bin/sh

tmp_dir=/tmp/
input_bam=$1
outbase=$2
sra=$3
samtools=$4

tmp_input_bam=$tmp_dir/${sra}.bam
tmp_input_bai=$tmp_dir/${sra}.bam.bai
output_bai=${outbase}.bam.bai

cp $input_bam $tmp_input_bam

$samtools index $tmp_input_bam -o $tmp_input_bai

rm $tmp_input_bam
mv $tmp_input_bai $output_bai