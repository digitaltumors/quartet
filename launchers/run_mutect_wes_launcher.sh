#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=24:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=32
#SBATCH --job-name='run_mutect'
#SBATCH --output="%j.out"

jobs=$1
reference=$2
gnomad=$3
1000g=$4
contemporary_normal=$5


cp $reference /tmp/ 
cp $reference.fai /tmp/
cp $gnomad* /tmp/
cp ${1000g}* /tmp/
cp $contemporary_normal* /tmp/

cat $jobs | parallel -j 8 --joblog my.log
PARALLEL_PID=$!
