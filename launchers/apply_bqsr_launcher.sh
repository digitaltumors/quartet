#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=20
#SBATCH --job-name='apply_bqsr'
#SBATCH --output="%j.out"

jobs=$1
reference_dir=$2

cp $reference_dir/* /tmp/

cat $jobs | parallel -j 16 --joblog my.log
PARALLEL_PID=$!
