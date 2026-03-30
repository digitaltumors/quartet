#!/bin/sh

reference=/tmp/GCF_000001405.26_GRCh38_genomic.fna

ref_index=$reference.fai
input_file_1=$1
input_file_2=$2
outbase=$3
sra=$4
bbmap=$5
samtools=$6
bwa=$7

output_bam=${outbase}.bam

fastq_1_scratch=/tmp/$sra.fq1.gz
fastq_2_scratch=/tmp/$sra.fq2.gz
fastq_1_sorted_scratch=/tmp/$sra.sorted.fq1.gz
fastq_2_sorted_scratch=/tmp/$sra.sorted.fq2.gz
bam_scratch=/tmp/$sra.bam

cp $input_file_1 $fastq_1_scratch
cp $input_file_2 $fastq_2_scratch 

$bwa mem -Y -K 50000000 -t 32 -Z $reference $fastq_1_scratch $fastq_2_scratch | $samtools view -b -@ 32 > $bam_scratch

cp $bam_scratch $output_bam 

rm $fastq_1_scratch 
rm $fastq_2_scratch

rm $bam_scratch
