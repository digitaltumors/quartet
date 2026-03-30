#!/bin/sh

input_bam=$1
outbase=$2
sra=$3
short_marking=$4
samtools=$5

tmp_dir=/tmp/

tmp_sorted_rg_bam=$tmp_dir/${sra}_sorted_rg.bam
tmp_marked_bam=$tmp_dir/${sra}_marked.bam
output_bam=${outbase}_marked.bam
stats_file=$tmp_dir/${sra}_marked.bam.summary.stats.txt
output_stats_file=${outbase}_marked.bam.summary.stats.txt
cp $input_bam $tmp_sorted_rg_bam
$short_marking -I $tmp_sorted_rg_bam -A1 30 -A2 30 -o $tmp_marked_bam | $samtools view -@ 1 -b > $tmp_marked_bam
rm $tmp_sorted_rg_bam &
mv $stats_file $output_stats_file &
mv $tmp_marked_bam $output_bam