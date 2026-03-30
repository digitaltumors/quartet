#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=128G
#SBATCH --time=72:00:00
#SBATCH --job-name='bam2fastq'
#SBATCH --output="%j.out"

jobs=$1

cat $jobs | parallel -j 1