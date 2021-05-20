#!/bin/bash
#SBATCH --job-name=align-run50-HG19                              # job name
#SBATCH --partition=super                                 # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH --nodes=1                                         # number of nodes requested by user
#SBATCH --time=0-72:00:00                                 # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=run50_align.%j.out                         # standard output file name
#SBATCH --error=run50_align.%j.err                         # standard error output file name
#SBATCH --mail-user=aishwarya.sundaresan@utsouthwestern.edu           # specify an email address
#SBATCH --mail-type=FAIL,END                                   # send email when job status change (start, end, abortion and etc.)

#sh align-bowtie-pe.sh -f $1 -s $2 -r 'mm10' -o $3
    module load samtools/1.6
    module load bedtools/2.29.0
    module load python/2.7.x-anaconda
    module load picard/2.10.3
bams='Cut_Tag_BG4_MABE_WT26_LB_KAPA_S2'

for bam in $bams

do
echo $bam

        #Mark duplicates
        java -Xmx4G -jar $PICARD/picard.jar MarkDuplicates INPUT=/project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/align_out/${bam}.sorted.bam OUTPUT=/project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/nodups_out/${bam}.nodups.bam METRICS_FILE=/project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/nodups_out/${bam}.duplicate_metrics.txt VALIDATION_STRINGENCY=LENIENT ASSUME_SORTED=true REMOVE_SEQUENCING_DUPLICATES=true
        
        #Index the nodup bam
        samtools index /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/nodups_out/${bam}.nodups.bam /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/nodups_out/${bam}.nodups.bai

        #Generate mapping statistics
        samtools flagstat /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/nodups_out/${bam}.nodups.bam > /project/GCRB/Banaszynski_lab/shared/Yu-Ching/BG4_Cut_and_Tag/run66_2020_09_24/WT26_reanalysis/nodups_out/${bam}.nodups_stats.txt

done
