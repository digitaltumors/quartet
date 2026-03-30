#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=8:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=20
#SBATCH --job-name='index_bam_before_mutect'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 16 --joblog my.log
PARALLEL_PID=$!
