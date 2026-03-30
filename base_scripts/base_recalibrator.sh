#!/bin/sh

input_bam=$1
outbase=$2
sra=$3
reference=$4
dbsnp=$5
java=$6
gatk=$7

tmp_dir=/tmp/
tmp_input=$tmp_dir/${sra}_markdups.bam
tmp_output_table=$tmp_dir/${sra}_recal_data.table
output_table=${outbase}_recal_data.table
$java -jar $gatk BaseRecalibrator -I $input_bam --known-sites /cellar/users/dhalmos/resources/dbsnp/00-All-renamed.vcf.gz -R $reference -O $output_table
