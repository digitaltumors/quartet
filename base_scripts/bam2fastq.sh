#!/bin/sh

bam=$1
fq1=$2
fq2=$3
sra=$4
samtools=$6
reference=$5

scratch_folder=/tmp/

bam_scratch=/tmp/$sra.bam
sorted_bam_scratch=/tmp/$sra.sorted.bam
fq1_scratch=/tmp/$sra.fq1_tmp.fastq.gz
fq2_scratch=/tmp/$sra.fq2_tmp.fastq.gz

cp $bam $bam_scratch

$samtools sort -n -@ 32 $bam_scratch -o $sorted_bam_scratch

rm $bam_scratch &

$samtools fastq --reference $reference -@ 32 -c 6 $sorted_bam_scratch -1 $fq1_scratch -2 $fq2_scratch

rm $sorted_bam_scratch &
cp $fq1_scratch $fq1
rm $fq1_scratch &
cp $fq2_scratch $fq2
rm $fq2_scratch