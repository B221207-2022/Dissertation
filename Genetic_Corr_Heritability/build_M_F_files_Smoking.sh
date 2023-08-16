#change file format for GC
cp /PATH/Dataset/Smoking_EVERSMK_BBJ_autosome_Clean.txt Smoking_EVERSMK_BBJ_all.txt

tail -n +2 /PATH/Dataset/Smoking_EVERSMK_BBJ_Xchromosome_Clean.txt  >> Smoking_EVERSMK_BBJ_all.txt

cut -d " " -f 1,4,5,8,9,10 Smoking_EVERSMK_BBJ_all.txt > Smoking_EVERSMK_BBJ_F.txt 
cut -d " " -f 1,11,12,15,16,17 Smoking_EVERSMK_BBJ_all.txt > Smoking_EVERSMK_BBJ_M.txt 
