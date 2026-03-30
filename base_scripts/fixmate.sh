#!/bin/sh

input_bam=$1
outbase=$2
sra=$3
samtools=$4

tmp_dir=/tmp/

tmp_marked_bam=$tmp_dir/${sra}_marked.bam
tmp_fixmate_bam=$tmp_dir/${sra}_fixmate.bam
output_bam=${outbase}_fixmate.bam

cp $input_bam $tmp_marked_bam

$samtools fixmate -m -@ 12 $tmp_marked_bam $tmp_fixmate_bam

rm $tmp_marked_bam &
mv $tmp_fixmate_bam $output_bam

