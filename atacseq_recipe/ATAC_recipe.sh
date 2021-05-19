#!/bin/tcsh


set INDEX=/project/apps_database/iGenomes/Mus_musculus/UCSC/mm10/Sequence/BWAIndex/genome.fa
set NUM_THREADS=30
set MISMATCH_PENALTY=8
set FILE=./fastq_files


module load BWA/0.7.5
module load samtools
module load picard/2.10.3
module load bedtools
module load UCSC_userApps

mkdir bam_files

foreach sample(\
           Sample1\
           Sample2\
           )

echo $sample

    foreach lane (L001 L002 L003 L004)

echo $lane

    bwa mem\
       -t $NUM_THREADS\
       -B $MISMATCH_PENALTY\
       -M\
       $INDEX\
       $FILE/$sample\_$lane\_R1\_001.fastq.gz\
       $FILE/$sample\_$lane\_R2\_001.fastq.gz\
       | samtools view -q10 -bS -o - -\
       | samtools sort - -o $sample.$lane.bam
    end

    samtools merge ./bam_files/$sample.bam\
	$sample.L001.bam\
	$sample.L002.bam\
	$sample.L003.bam\
	$sample.L004.bam

    samtools sort -m 8000000000 ./bam_files/$sample.bam
    rm $sample.L001.bam $sample.L002.bam $sample.L003.bam $sample.L004.bam

    set MARK_DUP = /cm/shared/apps/picard/1.117/MarkDuplicates.jar

    mkdir nodup_files

    java -Xmx128g -jar $MARK_DUP\
    INPUT=./bam_files/$sample.bam\
    OUTPUT=./nodup_files/$sample.nodup.bam\
    METRICS_FILE=./nodup_files/metrics.$sample.txt\
    REMOVE_DUPLICATES=true\
    ASSUME_SORTED=true\
    TMP_DIR=temp_dir.$sample

    samtools index ./nodup_files/$sample.nodup.bam

end

