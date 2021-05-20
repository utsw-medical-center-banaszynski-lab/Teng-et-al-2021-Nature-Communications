
module load bedtools/2.29.0

#ATRX_WT peaks
#convert bed to fasta
fastaFromBed -fi ./mm10_ucsc_reference/mm10.fa -bed ATRX_WT_peaks.bed -name+ -fo ATRX_WT_peaks.fasta

#G4 prediction
fastaRegexFinder_G4_loop_size_12.py --fasta ATRX_WT_peaks.fasta > ATRX_WT_peaks_G4_prediction.txt

#convert PQS to bed
cut -f1,7 ATRX_WT_peaks_G4_prediction.txt | awk -F'::' '{print $2}' > ATRX_WT_peaks_G4_prediction.bed


#ATRX_KO peaks
#convert bed to fasta
fastaFromBed -fi ./mm10_ucsc_reference/mm10.fa -bed ATRX_KO_peaks.bed -name+ -fo ATRX_KO_peaks.fasta

#G4 prediction
fastaRegexFinder_G4_loop_size_12.py --fasta ATRX_KO_peaks.fasta > ATRX_KO_peaks_G4_prediction.txt


#convert PQS to bed
cut -f1,7 ATRX_KO_peaks_G4_prediction.txt | awk -F'::' '{print $2}' > ATRX_KO_peaks_G4_prediction.bed

