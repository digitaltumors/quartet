#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name='run_deepsomatic_process_variants'
#SBATCH --output="%j.out"

jobs=$1
reference=$2

cp $reference /tmp/ 
cp $reference.fai /tmp/

cat $jobs | parallel -j 1 --joblog my.log
PARALLEL_PID=$!
