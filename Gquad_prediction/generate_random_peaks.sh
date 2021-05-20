#!/bin/bash

module load bedtools

for i in `seq 1 100`
 do
 echo $i

#generate random intervals of ATRX peak file
bedtools shuffle -i ATRX_WT_peaks.bed -g mm10.chrom.sizes > shuffled_peaks_ATRX_WT$i.bed

#convert the random peak file to fasta
fastaFromBed -fi ./mm10_ucsc_reference/mm10.fa -bed shuffled_peaks_ATRX_WT$i.bed -name+ -fo ./fasta/shuffled_peaks_ATRX_WT$i.fasta

done

