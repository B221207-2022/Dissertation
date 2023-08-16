#change file format for GC
cp /PATH/Dataset/Disease_Pollinosis_BBJ_autosome_Clean.txt Disease_Pollinosis_BBJ_all.txt

tail -n +2 /PATH/Dataset/Disease_Pollinosis_BBJ_Xchromosome_Clean.txt  >> Disease_Pollinosis_BBJ_all.txt

#awk '$9 != "." { print }' Smoking_EVERSMK_BBJ_all.txt > Smoking_EVERSMK_BBJ_all_removeSE.txt

cut -d $'\t' -f 1,4,5,7,8,9 Disease_Pollinosis_BBJ_all.txt > Disease_Pollinosis_BBJ_F.txt 
cut -d $'\t' -f 1,4,5,13,14,15 Disease_Pollinosis_BBJ_all.txt > Disease_Pollinosis_BBJ_M.txt 
