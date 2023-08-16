#Creates correlation heatmaps
#Based off of ldsc corrplot rg (https://github.com/mkanai/ldsc-corrplot-rg)
#Experienced lots of bugs with the NA values where it would not load correct even through
#   the library is built to handle NA values
#Additionally, it was also unable to calculate the matrices for the MvM and MvF so those
#   had to be copied from their respective files 
#Also because I had many small p-values, I had to change the size of the square to be
#   related to the absolute value of the genetic correlation so the color would show up
#Because of this each genetic correlation heatmap needed its own variation to get past
#   the bugs that pertained to it.
#Thus I copied and adapted the code as needed.
#I would not recommend this library in the future 

library(corrplot)
library(reshape2)

#Adjust P-value
data <- read.table("FvFcoor.txt",sep="\t",header=T)
head(data)

drops <- c("X") #removes extra column
data <- data[ , !(names(data) %in% drops)]
data["q"] <- p.adjust(data$p, method = "fdr", n = 120)

tail(data)
write.table(data, "FvFcoor_qval.txt", sep="\t", row.names=FALSE, quote=FALSE)



# load data
rg = read.table("FvFcoor_qval.txt", T, sep='\t', as.is = T)
trait_all = read.table("traitlist.txt", T, sep = '\t', as.is = T, quote = '', fileEncoding='utf-8', comment.char="")

TRAIT_CATEGORY1 = c('Disease', 'Smoking')
TRAIT_CATEGORY2 = c('Disease', 'Smoking')

traitlist1 = subset(trait_all, CATEGORY %in% TRAIT_CATEGORY1)
traitlist2 = subset(trait_all, CATEGORY %in% TRAIT_CATEGORY2)

# duplicate lines
tmp = rg
tmp$p1 = rg$p2
tmp$p2 = rg$p1
tmp$p1_category = rg$p2_category
tmp$p2_category = rg$p1_category
rg = rbind(rg, tmp)


corrplot_nsquare = function(rg, trait1, trait2, traits_use = NULL, order = "original", landscape=FALSE) {
  if (landscape & length(trait1) > length(trait2)) {
    tmp = trait1
    trait1 = trait2
    trait2 = tmp
  }
  if (!is.null(traits_use)) {
    rg = subset(rg, p1 %in% traits_use & p2 %in% traits_use)
  }
  x2 = dcast(rg, p1 ~ p2, value.var = "rg")
  mat2 = as.matrix(x2[, 2:ncol(x2)])
  rownames(mat2) = x2$p1
  
  mat2[mat2 > 1] = 1
  mat2[mat2 < -1] = -1
  mat2[is.na(mat2)] = 0
  
  x2 = dcast(rg, p1 ~ p2, value.var = "q")
  qmat2 = as.matrix(x2[, 2:ncol(x2)])
  rownames(qmat2) = x2$p1
  qmat2[is.na(qmat2)] = 1
  
  if (nrow(mat2) == ncol(mat2)) {
    diag(mat2) = 1
    diag(qmat2) = -1
  }
  
  trait1 = match(trait1, rownames(mat2))
  trait2 = match(trait2, colnames(mat2))
  mat2 = mat2[trait1, trait2]
  qmat2 = qmat2[trait1, trait2]
  
  #print(mat2)
  #print(qmat2)
  #print("test")
  
  corrplot(mat2, method = "square", order = order,
           p.mat = qmat2, sig.level = 0.05, sig = "pch",
           pch = "*", pch.cex = 3, full_col=FALSE,
           na.label = "square", na.label.col = "grey90", 
           tl.col = "black", tl.cex = 1.4, type = 'upper')
  # return(list(mat = mat2, qmat = qmat2))
}

png("corrplot_rg_disease.png", width = 9, height = 9, units = 'in', res = 300, family = "Helvetica")
corrplot_nsquare(rg, traitlist1$TRAIT, traitlist2$TRAIT, landscape=TRUE)
dev.off()



#MvM adjust p-value
data <- read.table("MvM.txt",sep="\t",header=T)
head(data)

#drops <- c("X")
#data <- data[ , !(names(data) %in% drops)]

data["q"] <- p.adjust(data$p, method = "fdr", n = 120)

tail(data)

write.table(data, "MvM_qval.txt", sep="\t", row.names=FALSE, quote=FALSE)


# load data
rg = read.table("MvM_qval_NA.txt", T, sep='\t', as.is = T)
head(rg)
trait_all = read.table("traitlist.txt", T, sep = '\t', as.is = T, quote = '', fileEncoding='utf-8', comment.char="")

TRAIT_CATEGORY1 = c('Disease', 'Smoking')
TRAIT_CATEGORY2 = c('Disease', 'Smoking')

traitlist1 = subset(trait_all, CATEGORY %in% TRAIT_CATEGORY1)
traitlist2 = subset(trait_all, CATEGORY %in% TRAIT_CATEGORY2)

# duplicate lines
tmp = rg
tmp$p1 = rg$p2
tmp$p2 = rg$p1
tmp$p1_category = rg$p2_category
tmp$p2_category = rg$p1_category
rg = rbind(rg, tmp)



corrplot_nsquare = function(rg, trait1, trait2, traits_use = NULL, order = "original", landscape=FALSE) {
  if (landscape & length(trait1) > length(trait2)) {
    tmp = trait1
    trait1 = trait2
    trait2 = tmp
  }
  if (!is.null(traits_use)) {
    rg = subset(rg, p1 %in% traits_use & p2 %in% traits_use)
  }
  x2 = dcast(rg, p1 ~ p2, value.var = "rg")
  mat2 = as.matrix(x2[, 2:ncol(x2)])
  rownames(mat2) = x2$p1
  
  mat2[mat2 > 1] = 1
  mat2[mat2 < -1] = -1
  mat2[is.na(mat2)] = 0
  
  x2 = dcast(rg, p1 ~ p2, value.var = "q")
  qmat2 = as.matrix(x2[, 2:ncol(x2)])
  rownames(qmat2) = x2$p1
  qmat2[is.na(qmat2)] = 1
  
  if (nrow(mat2) == ncol(mat2)) {
    diag(mat2) = 1
    diag(qmat2) = -1
  }
  
  trait1 = match(trait1, rownames(mat2))
  trait2 = match(trait2, colnames(mat2))
  mat2 = mat2[trait1, trait2]
  qmat2 = qmat2[trait1, trait2]
  
  mat2 = matrix(
    c(1,0.4336,-0.1683,0.1404,0.0277,-0.0299,0.1174,NA,0.4336,1,-0.2976,-0.0403,-0.4944,0.0767,0.5194,NA,-0.1683,-0.2976,1,-0.279,NA,-0.375,0.4061,NA,0.1404,-0.0403,-0.279,1,0.6658,0.1331,-0.0973,NA,0.0277,-0.4944,NA,0.6658,1,0.4202,0.0476,NA,-0.0299,0.0767,-0.375,0.1331,0.4202,1,-0.0944,NA,0.1174,0.5194,0.4061,-0.0973,0.0476,-0.0944,1,NA,NA,NA,NA,NA,NA,NA,NA,NA),
    nrow = 8,  
    ncol = 8,        
    byrow = TRUE         
  )
  rownames(mat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  colnames(mat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  print(mat2)
  
  qmat2 = matrix(
    c(1,1,1,1,1,1,1,NA,1,1,1,1,1,1,1,NA,1,1,1,1,1,1,1,NA,1,1,1,1,1,1,1,NA,1,1,1,1,1,1,1,NA,1,1,1,1,1,1,1,NA,1,1,1,1,1,1,1,NA,NA,NA,NA,NA,NA,NA,NA,NA),
    nrow = 8,  
    ncol = 8,        
    byrow = TRUE         
  )
  rownames(qmat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  colnames(qmat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  print(qmat2) 
  
  print(mat2)
  print(qmat2)
  print("test")
  
  corrplot(mat2, method = "square", order = order,
           p.mat = qmat2, sig.level = 0.05, sig = "pch",
           pch = "*", pch.cex = 3, full_col=FALSE,
           na.label = "square", na.label.col = "grey90", 
           tl.col = "black", tl.cex = 1.4, type = 'upper')
  # return(list(mat = mat2, qmat = qmat2))
}


png("MvM.png", width = 9, height = 9, units = 'in', res = 300, family = "Helvetica")
corrplot_nsquare(rg, traitlist1$TRAIT, traitlist2$TRAIT, landscape=TRUE)
dev.off()




#Adjust p-values
data <- read.table("FvM.txt",sep="\t",header=T)
head(data)
data["q"] <- p.adjust(data$p, method = "fdr", n = 120)
tail(data)
write.table(data, "FvMcoor_qval.txt", sep="\t", row.names=FALSE, quote=FALSE)


# load data
rg = read.table("FvMcoor_qval.txt", T, sep='\t', as.is = T)
trait_all = read.table("traitlist_sex.txt", T, sep = '\t', as.is = T, quote = '', fileEncoding='utf-8', comment.char="")

head(rg)

TRAIT_CATEGORY1 = c('Female')
TRAIT_CATEGORY2 = c('Male')

traitlist1 = subset(trait_all, CATEGORY %in% TRAIT_CATEGORY1)
traitlist2 = subset(trait_all, CATEGORY %in% TRAIT_CATEGORY2)
traitlist1
traitlist2

# duplicate lines
tmp = rg
tmp$p1 = rg$p2
tmp$p2 = rg$p1
tmp$p1_category = rg$p2_category
tmp$p2_category = rg$p1_category
rg = rbind(rg, tmp)

rg

corrplot_nsquare2 = function(rg, trait1, trait2, traits_use = NULL, order = "original", landscape=FALSE) {
  if (landscape & length(trait1) > length(trait2)) {
    tmp = trait1
    trait1 = trait2
    trait2 = tmp
  }
  if (!is.null(traits_use)) {
    rg = subset(rg, p1 %in% traits_use & p2 %in% traits_use)
  }
  x2 = dcast(rg, p1 ~ p2, value.var = "rg")
  mat2 = as.matrix(x2[, 2:ncol(x2)])
  rownames(mat2) = x2$p1
  
  mat2[mat2 > 1] = 1
  mat2[mat2 < -1] = -1
  mat2[is.na(mat2)] = 0
  
  
  
  x2 = dcast(rg, p1 ~ p2, value.var = "q")
  qmat2 = as.matrix(x2[, 2:ncol(x2)])
  rownames(qmat2) = x2$p1
  qmat2[is.na(qmat2)] = 1
  
  
  if (nrow(mat2) == ncol(mat2)) {
    diag(mat2) = 1
    diag(qmat2) = -1
  }
  
  trait1 = match(trait1, rownames(mat2))
  trait2 = match(trait2, colnames(mat2))
  mat2 = mat2[trait1, trait2]
  qmat2 = qmat2[trait1, trait2]
  
  print(trait1)
  print(trait2)
  print(mat2)
  print(qmat2)
  
  mat2 = matrix(
    c(0.5766,0.6299,-0.7248,0.0489,NA,0.216,0.124,NA,-0.4291,0.1001,-0.1019,-0.2027,-0.9309,-0.2254,-0.0612,NA,0.2552,-0.3484,0.6537,0.4893,-0.0753,-0.3846,-0.2713,NA,0.2529,0.2527,0.6157,0.8304,0.0276,-0.1236,-0.0869,NA,NA,NA,NA,NA,NA,NA,NA,NA,0.1345,0.2152,0.1454,0.1492,NA,NA,-0.3948,NA,0.1091,0.3403,-0.3205,-0.0561,-0.0774,-0.101,0.7369,NA,0.0991,-0.1092,0.6597,0.1366,-0.0825,0.0843,-0.2057,NA),
    nrow = 8,  
    ncol = 8,        
    byrow = TRUE         
  )
  rownames(mat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  colnames(mat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  print(mat2)
  
  qmat2 = matrix(
    c(1,1,1,1,NA,1,1,NA,1,1,1,1,1,1,1,NA,1,1,1,0.868,1,1,1,NA,1,1,1,0.00567,1,1,1,NA,NA,NA,NA,NA,NA,NA,NA,NA,1,1,1,1,NA,NA,1,NA,1,1,1,1,1,1,2.33E-23,NA,1,1,1,1,1,1,1,NA),
    nrow = 8,  
    ncol = 8,        
    byrow = TRUE         
  )
  rownames(qmat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  colnames(qmat2) = c("Pollinosis","Lung_Cancer","COPD","Asthma","Age_Started_Smoking","Cigarettes_Per_Day","Ever_Smoked","Former_Smoker")
  print(qmat2) 
  
  
  
  corrplot(mat2, method = "square", order = order,
           p.mat = qmat2, sig.level = 0.05, sig = "pch",
           pch = "*", pch.cex = 3, full_col=FALSE,
           na.label = "square", na.label.col = "grey90", 
           tl.col = "black", tl.cex = 1.4)
  # return(list(mat = mat2, qmat = qmat2))
}


png("FvM_new.png", width = 9, height = 9, units = 'in', res = 300, family = "Helvetica")
corrplot_nsquare2(rg, traitlist1$TRAIT, traitlist2$TRAIT, landscape=TRUE)
dev.off()
