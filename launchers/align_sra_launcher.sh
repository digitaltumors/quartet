#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=256G
#SBATCH --time=24:00:00
#SBATCH --job-name='align_bams'
#SBATCH --output="%j.out"

jobs=$1
reference_dir=$2

cp $reference_dir/* /tmp/
cd /tmp/

cat $jobs | parallel -j 1
