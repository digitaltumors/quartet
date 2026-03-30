#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=8:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=32
#SBATCH --job-name='add_read_groups'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 4 --joblog my.log
PARALLEL_PID=$!
