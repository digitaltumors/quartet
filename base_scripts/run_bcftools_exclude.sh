inp_file=$1
outbase=$2
sra=$3
bcftools=$4

$bcftools view --exclude FILTER~"weak_evidence"||FILTER~"map_qual"||FILTER~"strand_bias"||FILTER~"slippage"||FILTER~"clustered_events"||FILTER~"base_qual"