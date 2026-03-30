input_bam=$1
outdir=$2
sra=$3
samtools=$4
strelkaconfig=$5

tmp_dir=/tmp/
tmp_normal_bam=$tmp_dir/NA12878.bam
tmp_reference=$tmp_dir/GCF_000001405.26_GRCh38_genomic.fna
tmp_outdir=$tmp_dir/${sra}/strelka2/
tmp_bam=/tmp/${sra}_temp.bam

cp $input_bam $tmp_dir/${sra}.bam

$samtools view -@ 8 -b $tmp_dir/${sra}.bam > /tmp/${sra}_temp.bam
$samtools index -@ 8 $tmp_dir/${sra}_temp.bam

python $strelkaconfig --normalBam $tmp_normal_bam --tumorBam /tmp/${sra}_temp.bam --referenceFasta $tmp_reference --runDir=$tmp_outdir

python $tmp_outdir/runWorkflow.py -m local -j 8 -g 16

cp -r $tmp_outdir $outdir
rm $tmp_bam
rm $tmp_bam.bai
rm $tmp_dir/${sra}.bam
rm -rf $tmp_outdir