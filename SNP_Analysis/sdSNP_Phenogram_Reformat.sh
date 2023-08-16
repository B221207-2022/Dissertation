#!/bin/bash

#cut -f1,2,3,4 -d " " Suggestive_sdSNP.txt > Phenogram_Format_Suggestive_sdSNP.txt

awk '{print $2 "\t" $3 "\t" $4 "\t" $1}' Suggestive_sdSNP.txt > Phenogram_Format_Suggestive_sdSNP.txt

sed -i 's/Trait/phenotype/' Phenogram_Format_Suggestive_sdSNP.txt
sed -i 's/CHR/chrom/' Phenogram_Format_Suggestive_sdSNP.txt
sed -i 's/POS/pos/' Phenogram_Format_Suggestive_sdSNP.txt
sed -i 's/LuCa/Lung_Cancer/' Phenogram_Format_Suggestive_sdSNP.txt
sed -i 's/AI/Age_Started_Smoking/' Phenogram_Format_Suggestive_sdSNP.txt
sed -i 's/CPD/Cigarettes_Per_Day/' Phenogram_Format_Suggestive_sdSNP.txt
sed -i 's/EVERSMK/Ever_Smoked/' Phenogram_Format_Suggestive_sdSNP.txt
sed -i 's/FORMER/Fomer_Smoker/' Phenogram_Format_Suggestive_sdSNP.txt
