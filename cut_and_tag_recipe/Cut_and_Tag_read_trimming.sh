#!/bin/bash

module load trimgalore/0.6.4
module load fastqc/0.11.8
module load cutadapt/2.5


fastqs='Sample1 Sample2'

for fastq in $fastqs

do

echo $fastq

trim_galore --paired --fastqc -o ./trimmed_fastq ${fastq}_R1_001.fastq.gz ${fastq}_R2_001.fastq.gz

done
