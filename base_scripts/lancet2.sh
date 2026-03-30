input_file=$1
outdir=$2
sra=$3
lancet2=$4

tmp_bam=/tmp/$sra.bam
outfile=$outdir/${sra}.vcf.gz

mkdir -p $outdir

cp $input_file $tmp_bam
cp $input_file.bai $tmp_bam.bai

apptainer exec --nv --bind /tmp/:/container/tmp/ $lancet2 bash -c "Lancet2 pipeline -t $tmp_bam -n /tmp/NA12878.bam -b /tmp/hg38_exome_regions_refseq.bed -r /tmp/GCF_000001405.26_GRCh38_genomic.fna -T 16 -o /tmp/${sra}.vcf.gz"

rm $tmp_bam
cp /tmp/${sra}.vcf.gz $outfile
