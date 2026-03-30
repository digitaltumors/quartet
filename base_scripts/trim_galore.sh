#!/bin/sh

fq1=$1
fq2=$2
sra=$3
outdir=$4
trim_galore=$5
scratch_dir=/tmp/

fq1_pre_scratch=$scratch_dir/$sra.fq1.fastq.gz
fq2_pre_scratch=$scratch_dir/$sra.fq2.fastq.gz

fq1_post_scratch=$scratch_dir/$sra.fq1_val_1.fq.gz
fq2_post_scratch=$scratch_dir/$sra.fq2_val_2.fq.gz
trim_report_1=$scratch_dir/$sra.fq1.fastq.gz_trimming_report.txt
trim_report_2=$scratch_dir/$sra.fq2.fastq.gz_trimming_report.txt

echo $scratch_dir $fq1_pre_scratch

cp $fq1 $fq1_pre_scratch
cp $fq2 $fq2_pre_scratch

$trim_galore --paired --gzip --quality 20 --phred33 --cores 8 --output_dir=$scratch_dir $fq1_pre_scratch $fq2_pre_scratch

rm $fq1_pre_scratch
rm $fq2_pre_scratch

cp $fq1_post_scratch $outdir 
cp $fq2_post_scratch $outdir 
cp $trim_report_1 $outdir 
cp $trim_report_1 $outdir 

rm $fq1_post_scratch
rm $fq2_post_scratch
