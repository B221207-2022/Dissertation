# Uses qqman library to create a Manhattan plot of the dsSNPs pvalues of each trait
library(qqman)

#gets trait list using bash
file_slug <- system("ls /PATH/Results/ttest/ttest* | sed \'s/.*ttest_//\' | sed \'s/_.*.txt//\' | sort | uniq", intern=TRUE)
print(file_slug)

for (trait in file_slug){
  print(trait)
  autosome_name <- paste("/PATH/Results/ttest/ttest_",trait,"_autosome.txt",sep="")
  Xchromosome_name <- paste("/PATH/Results/ttest/ttest_",trait,"_Xchromosome.txt",sep="")

  #load autosome data
  autosome <- read.table(autosome_name,sep=" ",header=T)
  head(autosome)
  
  #load Xchrom data
  Xchromosome <- read.table(Xchromosome_name,sep=" ",header=T)
  head(Xchromosome)
  
  #combine into 1 df
  all_chr = rbind(autosome, Xchromosome)
  head(all_chr)
  
  #change X chrom to be labeled as 23 
  all_chr$CHR[all_chr$CHR == "X"] <- 23
  
  #change class to numeric for chromosome num
  all_chr$CHR <- as.numeric(as.character(all_chr$CHR))
  str(all_chr)
  
  #create manhattan plot and save as png
  plot_name <- paste("/PATH/Results/Manhattan/manhattan_plot_",trait,".png",sep="")
  png(plot_name,width = 1400, height = 1000)
  par(mar = c(7, 7, 7, 7))
  manhattan(all_chr, bp="POS", p="TstatP", ylim = c(0, 8), cex=2.1, cex.lab=2.7, cex.axis=1.4, chrlabs = c(1:22,"X"))
  dev.off()
}
