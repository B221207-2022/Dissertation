# Formats Data for Phenogram ssSNP
# Add annotation if its a male or female ssSNP

#load data
data <- read.table("All_ssSNP.txt",sep="",header=T)
head(data)

#adds col with a 1 if its signifant in F, 0 if its sig in Male
data <- transform(data, phenotype= ifelse(P.x<P.y, paste(Trait,"_Female",sep="") , paste(Trait,"_Male",sep="")))

names(data)[names(data) == "POS"] <- "pos"
names(data)[names(data) == "CHR"] <- "chr"


data <- data.frame(lapply(data, function(x) { gsub("EVERSMK", "Ever_Smoked", x) }))
data <- data.frame(lapply(data, function(x) { gsub("AI", "Age_Started_Smoking", x) }))
data <- data.frame(lapply(data, function(x) { gsub("FORMER", "Former_Smoker", x) }))
data <- data.frame(lapply(data, function(x) { gsub("CPD", "Cigarettes_Per_Day", x) }))
data <- data.frame(lapply(data, function(x) { gsub("LuCa", "Lung_Cancer", x) }))


head(data)

write.table(data[,c("SNP","chr","pos","phenotype")], file="Phenogram_Sex_Labels_ssSNP.tsv",sep="\t",row.names=FALSE,quote=FALSE)

