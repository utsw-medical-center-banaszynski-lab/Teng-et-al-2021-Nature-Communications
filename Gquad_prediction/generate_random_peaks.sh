#!/bin/bash
##SBATCH --job-name=Bed_to_Fasta
##SBATCH --partition=super
##SBATCH --nodes=1
##SBATCH --time=0-24:00:00
##SBATCH --output=BED_TO_FASTA.%j.out
##SBATCH --error=BED_TO_FASTA.%j.time
##SBATCH --mail-user=aishwarya.sundaresan@utsouthwestern.edu
##SBATCH --mail-type=FAIL,END

module load bedtools

#for chr in `seq 1 19` X Y
#do
 # wget -O - -q http://hgdownload.cse.ucsc.edu/goldenPath/mm10/chromosomes/chr$chr.fa.gz | gunzip -c >> /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa

#done

#curl -s "http://hgdownload.cse.ucsc.edu/goldenPath/mm10/database/chromInfo.txt.gz" | gunzip -c | cut -f 1,2 > mm10.chrom.sizes

#fastaFromBed -fi /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa -bed /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/finalized_peaks/overlap_peaks/ATRX_peaks.bed -fo /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/gquad/ATRX_peaks.fasta

for i in `seq 1 100`
 do
echo $i
#generate random intervals of ATRX peak file
bedtools shuffle -i /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/gquad/G4_predict/loop_size_12/WT26_only_shuffle_100/WT26_only_peaks.bed -g /work/GCRB/s157114/softwares/chrom_sizes/mm10.chrom.sizes > shuffled_peaks_WT26_only$i.bed

#convert the random peak file to fasta
fastaFromBed -fi /work/GCRB/s157114/softwares/mm10_ucsc_reference/mm10.fa -bed /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/gquad/G4_predict/loop_size_12/WT26_only_shuffle_100/shuffled_peaks_WT26_only$i.bed -name+ -fo /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/gquad/G4_predict/loop_size_12/WT26_only_shuffle_100/fasta/shuffled_peaks_WT26_only$i.fasta

done

