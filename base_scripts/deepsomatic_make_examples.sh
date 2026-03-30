input_file=$1
outdir=$2
sra=$3
deepsomatic=$4

tmp_bam=/tmp/$sra.bam

tmp_sra_dir=/tmp/${sra}_examples

mkdir -p $tmp_sra_dir
mkdir -p $outdir

cp $input_file $tmp_bam
cp $input_file.bai $tmp_bam.bai

apptainer exec --nv --bind /tmp/:/container/tmp/ $deepsomatic bash -c "time seq 0 31 | parallel -q --halt 2 --line-buffer /opt/deepvariant/bin/make_examples_somatic --mode calling --ref "/tmp//GCF_000001405.26_GRCh38_genomic.fna" --reads_tumor $tmp_bam --reads_normal "/tmp//NA12878.new.sorted.bam" --examples "/tmp/${sra}_examples/make_examples_somatic.tfrecord@32.gz" --checkpoint "/opt/models/deepsomatic/wes" --gvcf "/tmp/${sra}_examples/gvcf.tfrecord@32.gz" --vsc_max_fraction_indels_for_non_target_sample "0.5" --vsc_max_fraction_snps_for_non_target_sample "0.5" --vsc_min_fraction_indels "0.05" --vsc_min_fraction_snps "0.029" --task {}"

rm $tmp_bam

cp -r $tmp_sra_dir $outdir
