#!/bin/bash
#SBATCH --job-name=align-run50-HG19                              # job name
#SBATCH --partition=super                                 # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH --nodes=1                                         # number of nodes requested by user
#SBATCH --time=0-72:00:00                                 # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=run50_align.%j.out                         # standard output file name
#SBATCH --error=run50_align.%j.err                         # standard error output file name
#SBATCH --mail-user=aishwarya.sundaresan@utsouthwestern.edu           # specify an email address
#SBATCH --mail-type=FAIL,END                                   # send email when job status change (start, end, abortion and etc.)

    module load bowtie2/2.3.2
    module load samtools/1.6
    module load bedtools/2.29.0
    module load iGenomes/2013-03-25
#sh align-bowtie-pe.sh -f $1 -s $2 -r 'mm10' -o $3

#fastqs='Cut_Tag_BG4_MABE_WT26_LB_KAPA_S2 Cut_Tag_BG4_MABE_KO144_S3 Cut_Tag_BG4_AB00174_KO144_S4'
fastqs='Cut_Tag_BG4_MABE_WT26_LB_KAPA_S2'

for fastq in $fastqs
do
echo $fastq
        

bowtie2 --local --very-sensitive --no-mixed --no-discordant --phred33 -I 10 -X 700 -x /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome -1 /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/timmed_fastq/${fastq}_R1_001_val_1.fq.gz -2 /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/timmed_fastq/${fastq}_R2_001_val_2.fq.gz -S /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/align_out/${fastq}.sam

        # Convert sam to bam
        samtools view -bh -S /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/align_out/${fastq}.sam > /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/align_out/${fastq}.unsorted.bam

        # Sort bam
        samtools sort /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/align_out/${fastq}.unsorted.bam -o /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/align_out/${fastq}.sorted.bam

done
