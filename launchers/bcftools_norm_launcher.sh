#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name='bcftools_norm'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 4 --joblog my.log
PARALLEL_PID=$!