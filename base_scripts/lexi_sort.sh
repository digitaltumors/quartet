#!/bin/sh

input_rg_bam=$1
outbase=$2
sra=$3
samtools=$4

tmp_dir=/tmp/

tmp_sorted_bam=$tmp_dir/${sra}_lexi_sorted.bam
output_bam=${outbase}_lexi_sorted.bam
$samtools sort -n -@ 12 -o $tmp_sorted_bam $input_rg_bam
mv $tmp_sorted_bam $output_bam