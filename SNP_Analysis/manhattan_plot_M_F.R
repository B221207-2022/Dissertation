# Uses qqman library to create a Manhattan plot of the dsSNPs pvalues of each trait
library(qqman)
library(unix)
rlimit_all()


#gets trait list using bash
traits <- system("ls /PATH/Dataset/*BBJ* | sed \'s/.*Smoking_//\' | sed \'s/.*Disease_//\' | sed \'s/_BBJ_.*_Clean.txt//\' | sort | uniq", intern=TRUE)
print(traits)

for (trait in traits){
  print(trait)
  get_file_command <- paste("ls /PATH/Dataset/*BBJ* | grep ",trait,sep="")
  files <- system(get_file_command, intern=TRUE)
  print(files)

  
  #load autosome data
  autosome <- read.table(files[1],sep="",header=T)
  head(autosome)
  
  #load Xchrom data
  Xchromosome <- read.table(files[2],sep="",header=T)
  head(Xchromosome)
  
  #combine into 1 df
  all_chr = rbind(subset(autosome, select=c("SNP","CHR","POS","P.x","P.y")), subset(Xchromosome, select=c("SNP","CHR","POS","P.x","P.y")))
  head(all_chr)
 
 
  #change X chrom to be labeled as 23 
  all_chr$CHR[all_chr$CHR == "X"] <- 23
  
  #change class to numeric for chromosome num
  all_chr$CHR <- as.numeric(as.character(all_chr$CHR))
  #str(all_chr)
  
  #create manhattan plot and save as png
  for (sex in list("F","M")){
    if(sex == "F") {
      plot_name <- paste("/PATH/Results/Manhattan/sex_specfic_F_manhattan_plot_",trait,".png",sep="")
      p_col <- "P.x"
      colour <- "#cc0066"
    } else{
      plot_name <- paste("/PATH/Results/Manhattan/sex_specfic_M_manhattan_plot_",trait,".png",sep="")
      p_col <- "P.y"
      colour <- "#0066cc"
    }
    png(plot_name,width = 1400, height = 1000)
    par(mar = c(7, 7, 7, 7))
    manhattan(all_chr, bp="POS", p=p_col, col = c("black", colour), cex=2.1, cex.lab=2.7, cex.axis=1.4, chrlabs = c(1:22,"X"))
    dev.off()
  }
}
