#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=8:00:00
#SBATCH --job-name='coord_sort_sra_bams'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 8 --joblog my.log
PARALLEL_PID=$!
