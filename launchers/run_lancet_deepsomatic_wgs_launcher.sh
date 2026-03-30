#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=128G
#SBATCH --time=72:00:00
#SBATCH --job-name='run_lancet_deepsomatic'
#SBATCH --output="%j.out"


tmp_dir=/tmp/

jobs=$1
reference=$2
exome_regions=$3
contemporary_normal=$4

cp $reference /tmp/ 
cp $reference.fai /tmp/
cp $exome_regions $tmp_dir
cp $contemporary_normal* $tmp_dir

cat $jobs | parallel -j 1