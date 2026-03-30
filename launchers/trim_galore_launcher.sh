#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=72:00:00
#SBATCH --job-name='trim_galore'
#SBATCH --output="%j.out"

jobs=$1
cat $jobs | parallel -j 1 --joblog my.log