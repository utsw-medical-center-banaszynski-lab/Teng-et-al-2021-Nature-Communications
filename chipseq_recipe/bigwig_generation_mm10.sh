#!/bin/tcsh

#SBATCH --job-name=make-bw                            # job name
#SBATCH --partition=super                                # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH --nodes=1                                        # number of nodes requested by user
#SBATCH --time=0-72:00:00                                 # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=serialJob.%j.out                        # standard output file name
#SBATCH --error=serialJob.%j.time                        # standard error output file name
#SBATCH --mail-user=aishwarya.sundaresan@utsouthwestern.edu      # specify an email address
#SBATCH --mail-type=ALL                                  # send email when job status change (start, end, abortion and etc.)


module load samtools
module load picard/1.117
module load bedtools
module load UCSC_userApps
module load macs/1.4.2
module load igvtools/2.3.71

#mkdir bam_files

foreach sample(\
   XP164_K36me3_input_S9\
   XP250_K36me3_input_S10\
   XP369_K36me3_input_S11\
   XP490_K36me3_input_S8\
   XPL183_K36me3_input_S12\
)  

echo $sample


   set CHROM_SIZE = /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa.fai
    #set CHROM_SIZE = /project/apps_database/iGenomes/Homo_sapiens/UCSC/hg19/Sequence/WholeGenomeFasta/genome.fa.fai

    #mkdir ./bw_files/read_depth_nf/mm10/

    bedtools genomecov -ibam /project/GCRB/Banaszynski_lab/shared/Haitao/ChIP-Seq/run38_2018_12_04/AS_analysis/NChIP_pipeline/downsample_out/read_depth_nf/mm10/downsample.sh-1.1.0/$sample.filtered.no.downsampled.bam -bga > ./bw_files/read_depth_nf/mm10/$sample.nodup.bedGraph

    sort -k1,1 -k2,2n ./bw_files/read_depth_nf/mm10/$sample.nodup.bedGraph > ./bw_files/read_depth_nf/mm10/$sample.nodup.sorted.bedGraph

    bedGraphToBigWig ./bw_files/read_depth_nf/mm10/$sample.nodup.sorted.bedGraph $CHROM_SIZE ./bw_files/read_depth_nf/mm10/$sample.nodup.bw
end
