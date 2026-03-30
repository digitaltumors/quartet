#!/bin/sh

input_bam=$1
outbase=$2
samtools=$3

output_file=${outbase}_flagstat.txt
$samtools flagstat $input_bam > $output_file