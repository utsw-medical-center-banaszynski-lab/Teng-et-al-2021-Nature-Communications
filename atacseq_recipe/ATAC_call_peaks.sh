#!/bin/bash



module load python/3.7.x-anaconda
conda activate macs2

bams='Sample1 Sample2'


for bam in $bams

do

macs2 callpeak  -t ${bam}.nodup.downsampled.bam -f BAMPE -n ./peak_calls/${bam}  -g mm --keep-dup all

done

