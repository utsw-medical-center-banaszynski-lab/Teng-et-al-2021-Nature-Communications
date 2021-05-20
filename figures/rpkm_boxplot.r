#!/usr/bin/env Rscript

args = commandArgs(trailingOnly = TRUE)
#load required packages
library("IRanges")
library("GenomicRanges")
library("rtracklayer")
library("Rsamtools")
library("GenomicAlignments")
library("GenomicFeatures")

#USAGE:
#Rscript box_plot.r \
#<1. project directory> \
#<2. bam1, WT> \
#<3. bam1 name> \
#<4. bam2, Test> \
#<5. bam2 name> \
#<6. peaks1> \
#<7. peaks1 name> \
#<8. peaks2> \
#<9. peaks2 name> \
#<10. file out name>

dir <- args[1]
setwd(dir)

#read bams
bam1.name <- args[3]
bam1.bam <- readGAlignments(file.path(args[2]))
bam1.gr <- granges(bam1.bam)
bam1 <- bam1.gr
#find library size
library_bam1 <- NROW(bam1)

bam2.name <- args[5]
bam2.bam <- readGAlignments(file.path(args[4]))
bam2.gr <- granges(bam2.bam)
bam2 <- bam2.gr
#find library size
library_bam2 <- NROW(bam2)

#read peaks
peaks1.name <- args[7]
peaks1 <- import(file.path(args[6]), format = "BED")

peaks2.name <- args[9]
peaks2 <- import(file.path(args[8]), format = "BED")

outprefix <- args[10]

#Calculate RPKM, = numReads / ( geneLength/1000 * totalNumReads/1,000,000 )
rpkm_bam1_peaks1 <- countOverlaps(peaks1, bam1) / (width(peaks1)/1000 * library_bam1/1000000)
rpkm_bam2_peaks1 <- countOverlaps(peaks1, bam2) / (width(peaks1)/1000 * library_bam2/1000000)
rpkm_peaks1<- data.frame(rpkm_bam1_peaks1,rpkm_bam2_peaks1)

#write pdf
boxplot_file_peak1 <- paste(outprefix,peaks1.name,"box_plot.pdf", sep = "_")
pdf(file=boxplot_file_peak1)
par(pty = "s")
boxplot(rpkm_peaks1,col=(c("blue","red")), main=peaks1.name, ylab="RPKM",outline=F, notch=T, 
        names=c(bam1.name,bam2.name),
        boxwex = 0.4,cex.axis=1,lwd=4,lty=1,ylim=c(0,12))
dev.off()

out_cox_peaks1.name <- paste(outprefix,peaks1.name,"wilcox_test.txt", sep = "_")
wilcox_peaks1 <- wilcox.test(rpkm_bam1_peaks1,rpkm_bam2_peaks1,conf.int=T)
write.table(wilcox_peaks1$p.value, file=file.path(dir, out_cox_peaks1.name), sep="\t", quote=F, row.names=F, col.names=F)


#Peak2
rpkm_bam1_peaks2 <- countOverlaps(peaks2, bam1) / (width(peaks1)/1000 * library_bam1/1000000)
rpkm_bam2_peaks2 <- countOverlaps(peaks2, bam2) / (width(peaks1)/1000 * library_bam2/1000000)
rpkm_peaks2<- data.frame(rpkm_bam1_peaks2,rpkm_bam2_peaks2)

#write pdf
boxplot_file_peak2 <- paste(outprefix,peaks2.name, "box_plot.pdf", sep = "_")
pdf(file=boxplot_file_peak2)
par(pty = "s")
boxplot(rpkm_peaks2,col=(c("blue","red")), main=peaks2.name, ylab="RPKM",outline=F, notch=T, 
        names=c(bam1.name,bam2.name),
        boxwex = 0.4,cex.axis=1,lwd=4,lty=1,ylim=c(0,12))
dev.off()

out_cox_peaks2.name <- paste(outprefix,peaks2.name,"wilcox_test.txt", sep = "_")
wilcox_peaks2 <- wilcox.test(rpkm_bam1_peaks2,rpkm_bam2_peaks2,conf.int=T)
write.table(wilcox_peaks2$p.value, file=file.path(dir, out_cox_peaks2.name), sep="\t", quote=F, row.names=F, col.names=F)
