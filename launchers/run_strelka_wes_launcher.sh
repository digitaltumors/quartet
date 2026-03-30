#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=120:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=32
#SBATCH --job-name='run_strelka'
#SBATCH --output="%j.out"

jobs=$1
reference=$2
contemporary_normal=$3

cp $reference /tmp/ 
cp $reference.fai /tmp/
cp $contemporary_normal* /tmp/

jobs=$1
cat $jobs | parallel -j 8 --joblog my.log
PARALLEL_PID=$!
