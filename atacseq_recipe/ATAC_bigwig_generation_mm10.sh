#!/bin/tcsh


module load samtools
module load picard/1.117
module load bedtools
module load UCSC_userApps
module load igvtools/2.3.71

mkdir bw_files

foreach sample(\
        Sample1\
        Sample2\
       )  

echo $sample


     set CHROM_SIZE = /project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa.fai
    

    bedtools genomecov -ibam $sample.nodup.downsampled.bam -bga > $sample.nodup.bedGraph

    sort -k1,1 -k2,2n $sample.nodup.bedGraph > $sample.nodup.sorted.bedGraph

    bedGraphToBigWig $sample.nodup.sorted.bedGraph $CHROM_SIZE $sample.nodup.bw

end
