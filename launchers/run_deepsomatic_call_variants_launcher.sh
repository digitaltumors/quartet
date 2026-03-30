#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=4:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --job-name='run_deepsomatic_call_variants'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 1 --joblog my.log
PARALLEL_PID=$!
