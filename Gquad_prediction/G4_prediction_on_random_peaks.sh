#!/bin/bash

for i in `seq 1 100`
do
echo $i

fastaRegexFinder_G4_loop_size_12.py --fasta ./fasta/shuffled_peaks_ATRX_WT$i.fasta > shuffled_peaks_ATRX_WT_{$i}_G4_prediction.txt

done
