#!/bin/bash
##SBATCH --job-name=G4_prediction
##SBATCH --partition=super
##SBATCH --nodes=1
##SBATCH --time=0-24:00:00
##SBATCH --output=Gquad_prediction.%j.out
##SBATCH --error=Gquad_prediction.%j.time
##SBATCH --mail-user=aishwarya.sundaresan@utsouthwestern.edu
##SBATCH --mail-type=END,FAIL

module load bedtools

#for chr in `seq 1 19` X Y
#do
 # wget -O - -q http://hgdownload.cse.ucsc.edu/goldenPath/mm10/chromosomes/chr$chr.fa.gz | gunzip -c >> /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa

#done



#/work/GCRB/s157114/softwares/fastaRegexFinder.py --fasta /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/gquad/ATRX_peaks.fasta > ATRX_peaks_G4_prediction.txt


for i in `seq 1 100`
do
echo $i

/work/GCRB/s157114/softwares/fastaRegexFinder_G4_loop_size_12.py --fasta /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/gquad/G4_predict/loop_size_12/WT26_only_shuffle_100/fasta/shuffled_peaks_WT26_only$i.fasta > shuffled_peaks_WT26_only_{$i}_G4_prediction.txt

done
