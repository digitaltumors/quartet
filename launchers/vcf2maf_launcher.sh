#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=32
#SBATCH --job-name='vcf2maf_sra'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 32 --joblog my.log
PARALLEL_PID=$!