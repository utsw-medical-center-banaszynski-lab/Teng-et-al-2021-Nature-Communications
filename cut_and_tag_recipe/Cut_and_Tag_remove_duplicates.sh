#!/bin/bash

    module load samtools/1.6
    module load bedtools/2.29.0
    module load python/2.7.x-anaconda
    module load picard/2.10.3

bams='Sample1 Sample2'

for bam in $bams

do
echo $bam

        #Mark duplicates
        java -Xmx4G -jar $PICARD/picard.jar MarkDuplicates INPUT=${bam}.sorted.bam OUTPUT=${bam}.nodups.bam METRICS_FILE=${bam}.duplicate_metrics.txt VALIDATION_STRINGENCY=LENIENT ASSUME_SORTED=true REMOVE_SEQUENCING_DUPLICATES=true
        
        #Index the nodup bam
        samtools index ${bam}.nodups.bam ${bam}.nodups.bai

        #Generate mapping statistics
        samtools flagstat ${bam}.nodups.bam > ${bam}.nodups_stats.txt

done
