

#compute Matrix scale regions 
computeMatrix scale-regions -R /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/RPKM_from_peaks/Gquad/G4_predict/loop_size_12/WT26_G4_peaks.bed /project/GCRB/Banaszynski_lab/shared/Yu-Ching/run30_23_combined_call_peaks/Analysis/RPKM_from_peaks/Gquad/G4_predict/loop_size_12/WT26_not_G4_peaks.bed -S /project/GCRB/Banaszynski_lab/shared/Yu-Ching/Publication/Gibbons_ESC_ChIP_Atrx/AS_analysis/bw_files/Chipseq1.nodup.bw /project/GCRB/Banaszynski_lab/shared/Yu-Ching/Publication/Gibbons_ESC_ChIP_Atrx/AS_analysis/bw_files/Chipseq2.nodup.bw /project/GCRB/Banaszynski_lab/shared/Yu-Ching/Publication/Gibbons_ESC_ChIP_Atrx/AS_analysis/bw_files/Input.nodup.bw --regionBodyLength 1300 --beforeRegionStartLength 2000 --afterRegionStartLength 2000 --skipZeros --outFileName GibbonsATRX_enrichment_WT26G4.gz --outFileSortedRegions GibbonsATRX_enrichment_WT26G4.bed


#plot profile
plotProfile -m GibbonsATRX_enrichment_WT26G4.gz -out GibbonsATRX_enrichment_WT26G4_profile.pdf --numPlotsPerRow 2 --plotFileFormat pdf --samplesLabel ATRX_ChIP_rep1 ATRX_ChIP_rep2 Input --regionsLabel WT26_G4_peaks WT26_not_G4_peaks --startLabel Peak_start --endLabel Peak_end --perGroup --plotTitle 'ATRX ChIP under WT26 G4 peaks' --colors blue red black


#plot heatmap
plotHeatmap -m GibbonsATRX_enrichment_WT26G4.gz -out GibbonsATRX_enrichment_WT26G4_heatmap.pdf --heatmapHeight 20 --samplesLabel ATRX_ChIP_rep1 ATRX_ChIP_rep2 Input --regionsLabel WT26_G4_peaks WT26_not_G4_peaks --boxAroundHeatmaps no --whatToShow 'heatmap and colorbar' --dpi 500 --perGroup --interpolationMethod nearest --startLabel Peak_start --endLabel Peak_end --heatmapWidth 10 --heatmapWidth 10 --plotTitle 'ATRX ChIP under WT26 G4 peaks' --colorList blue,white,red



