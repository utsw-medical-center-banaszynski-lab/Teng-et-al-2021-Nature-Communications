#!/bin/bash

    module load bowtie2/2.3.2
    module load samtools/1.6
    module load bedtools/2.29.0
    module load iGenomes/2013-03-25

fastqs='Sample1 Sample2'

for fastq in $fastqs
do
echo $fastq
        

bowtie2 --local --very-sensitive --no-mixed --no-discordant --phred33 -I 10 -X 700 -x /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome -1 ${fastq}_R1_001_val_1.fq.gz -2 ${fastq}_R2_001_val_2.fq.gz -S ${fastq}.sam

        # Convert sam to bam
        samtools view -bh -S ${fastq}.sam > ${fastq}.unsorted.bam

        # Sort bam
        samtools sort ${fastq}.unsorted.bam -o ${fastq}.sorted.bam

done
