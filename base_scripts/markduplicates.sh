#!/bin/

bam=$1
outbase=$2
sra=$3
java=$4
gatk=$5

tmp_dir=/tmp/
tmp_output_bam=$tmp_dir/${sra}_markdups.bam
output_bam=${outbase}_markdups.bam
output_metrics=${outbase}_markdups.metrics.txt

$java -Xmx4096m -jar $gatk MarkDuplicates --TMP_DIR $tmp_dir -I $bam -O $tmp_output_bam -M $output_metrics

cp $tmp_output_bam $output_bam
rm $tmp_output_bam