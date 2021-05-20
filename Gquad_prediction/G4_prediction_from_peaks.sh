
module load bedtools/2.29.0

#WT26 only peaks
#convert bed to fasta
fastaFromBed -fi /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa -bed WT26_only_peaks.bed -name+ -fo WT26_only_peaks.fasta

#G4 prediction
/work/GCRB/s157114/softwares/fastaRegexFinder_G4_loop_size_12.py --fasta WT26_only_peaks.fasta > WT26_only_peaks_G4_prediction.txt

#get number of G4 per peak
cut -f1 WT26_only_peaks_G4_prediction.txt| cut -d':' -f1 | sort | uniq -c > G4_and_peaks.txt

#convert PQS to bed
cut -f1,7 WT26_only_peaks_G4_prediction.txt | awk -F'::' '{print $2}' > WT26_only_peaks_G4_prediction.bed


#KO only peaks
fastaFromBed -fi /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa -bed KO1-44_only_peaks.bed -name+ -fo KO1-44_only_peaks.fasta

/work/GCRB/s157114/softwares/fastaRegexFinder_G4_loop_size_12.py --fasta KO1-44_only_peaks.fasta > KO1-44_only_peaks_G4_prediction.txt



#CP3 peaks
#convert bed to fasta
fastaFromBed -fi /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa -bed CP3_peaks_peaks.bed -name+ -fo CP3_peaks.fasta

#G4 prediction
/work/GCRB/s157114/softwares/fastaRegexFinder_G4_loop_size_12.py --fasta CP3_peaks.fasta > CP3_peaks_G4_prediction.txt

#get number of G4 per peak
cut -f1 CP3_peaks_G4_prediction.txt | cut -d':' -f1 | sort | uniq -c > CP3_peaks_G4_and_peaks.txt

#convert PQS to bed
cut -f1,7 CP3_peaks_G4_prediction.txt | awk -F'::' '{print $2}' > CP3_peaks_G4_prediction.bed




#overlap peaks
fastaFromBed -fi /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa -bed overlap_peaks.bed -name+ -fo overlap_peaks.fasta

/work/GCRB/s157114/softwares/fastaRegexFinder_G4_loop_size_12.py --fasta overlap_peaks.fasta > overlap_peaks_G4_prediction.txt

#ATRX peaks
fastaFromBed -fi /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa -bed ATRX_peaks.bed -name+ -fo ATRX_peaks.fasta
/work/GCRB/s157114/softwares/fastaRegexFinder_G4_loop_size_12.py --fasta ATRX_peaks.fasta > ATRX_peaks_G4_prediction.txt
