outdir=$1
sra=$2
deepsomatic=$3

cp -r $outdir/${sra}_examples /tmp/

outfile=$outdir/${sra}.vcf

apptainer exec --nv --bind /tmp/:/container/tmp/ $deepsomatic bash -c "time /opt/deepvariant/bin/postprocess_variants -j 1 --num_partitions 1 --ref "/tmp//GCF_000001405.26_GRCh38_genomic.fna" --infile "/tmp/${sra}_examples/call_variants_output@16.tfrecord.gz" --outfile "$outdir/$sra.vcf" --process_somatic=true"

for file in /tmp/*.gz ; do
	if [ -s $file ] ; then
		mv $file $outfile
	else
		rm $file
	fi
done

rm -rf /tmp/${sra}_examples

