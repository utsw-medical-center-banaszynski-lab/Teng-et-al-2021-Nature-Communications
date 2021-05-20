#!/bin/bash

module load deeptools

#compute Matrix scale regions 
computeMatrix scale-regions -R ATRX_WT_G4_peaks.bed ATRX_WT_not_G4_peaks.bed -S Sample1.bw Sample2.bw Input.bw --regionBodyLength 1300 --beforeRegionStartLength 2000 --afterRegionStartLength 2000 --skipZeros --outFileName ATRX_enrichment_WT26G4.gz --outFileSortedRegions ATRX_enrichment_WT26G4.bed


#plot profile
plotProfile -m ATRX_enrichment_WT26G4.gz -out ATRX_enrichment_WT26G4_profile.pdf --numPlotsPerRow 2 --plotFileFormat pdf --samplesLabel Sample1 Sample2 Input --regionsLabel WT26_G4_peaks WT26_not_G4_peaks --startLabel Peak_start --endLabel Peak_end --perGroup --plotTitle 'ATRX ChIP under WT26 G4 peaks' --colors blue red black

