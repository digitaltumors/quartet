#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=32
#SBATCH --job-name='run_flagstat'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 32 --joblog my.log