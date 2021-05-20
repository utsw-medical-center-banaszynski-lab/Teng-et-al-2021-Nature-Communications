#!/bin/bash
#SBATCH --job-name=align-run50-HG19                              # job name
#SBATCH --partition=super                                 # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH --nodes=1                                         # number of nodes requested by user
#SBATCH --time=0-72:00:00                                 # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=run50_align.%j.out                         # standard output file name
#SBATCH --error=run50_align.%j.err                         # standard error output file name
#SBATCH --mail-user=aishwarya.sundaresan@utsouthwestern.edu           # specify an email address
#SBATCH --mail-type=FAIL,END                                   # send email when job status change (start, end, abortion and etc.)

module load trimgalore/0.6.4
module load fastqc/0.11.8
module load cutadapt/2.5

#fastqs='Cut_Tag_BG4_MABE_WT26_LB_KAPA_S2 Cut_Tag_BG4_MABE_KO144_S3 Cut_Tag_BG4_AB00174_KO144_S4'
fastqs='Cut_Tag_BG4_MABE_WT26_LB_KAPA_S2'

for fastq in $fastqs

do

echo $fastq

trim_galore --paired --fastqc -o /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/timmed_fastq /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/fastq_files/${fastq}_R1_001.fastq.gz /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/fastq_files/${fastq}_R2_001.fastq.gz

done
