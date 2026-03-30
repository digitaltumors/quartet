inp_file=$1
outbase=$2
sra=$3
reference=$4
bcftools=$5

outfile=$outbase/$sra.norm.vcf.gz

$bcftools norm -m- -w 10000 -f $reference -O z -o $outfile $inp_file