#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=32
#SBATCH --job-name='markdups'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 16 --joblog my.log
PARALLEL_PID=$!
