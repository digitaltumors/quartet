outdir=$1
sra=$2
deepsomatic=$3

cp -r $outdir/${sra}_examples /tmp/

apptainer exec --nv --bind /tmp/:/container/tmp/ $deepsomatic bash -c "time /opt/deepvariant/bin/call_variants --outfile "/tmp/${sra}_examples/call_variants_output.tfrecord.gz" --examples "/tmp/${sra}_examples/make_examples_somatic.tfrecord@32.gz" --checkpoint "/opt/models/deepsomatic/wes""

mv /tmp/${sra}_examples/call_variants_output-*.tfrecord.gz $outdir/${sra}_examples

rm -rf /tmp/${sra}_examples