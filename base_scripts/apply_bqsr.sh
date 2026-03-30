#!/bin/sh

input_bam=$1
outbase=$2
sra=$3
reference=$4
java=$5
gatk=$6

tmp_dir=/tmp/

input_table=${outbase}_recal_data.table
tmp_input_bam=$tmp_dir/${sra}_markdups.bam
tmp_output_bam=$tmp_dir/${sra}_BQSR.bam
output_bam=${outbase}.bam

$java -jar $gatk ApplyBQSR -I $input_bam -R $reference --bqsr-recal-file $input_table  -O $tmp_output_bam

mv $tmp_output_bam $output_bam
