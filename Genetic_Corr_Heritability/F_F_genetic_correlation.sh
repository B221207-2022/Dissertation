#!/bin/bash
#$ -cwd
#$ -l h_rt=100:00:00
#$ -l h_vmem=32G
#$ -pe sharedmem 2
#$ -N FvF_genetic_cor
#$ -o /PATH/ldsc
#$ -e /PATH/ldsc

source /exports/applications/apps/SL7/anaconda/5.3.1/etc/profile.d/conda.sh

conda activate ldsc

cd /PATH/ldsc/ldsc

declare -a F_Array=("Smoking_AI_F" "Smoking_CPD_F" "Smoking_EVERSMK_F" "Smoking_FORMER_F" "Disease_LuCa_F" "Disease_COPD_F" "Disease_Asthma_F" "Disease_Pollinosis_F")
declare -a F_Array2=("Smoking_CPD_F" "Smoking_EVERSMK_F" "Smoking_FORMER_F" "Disease_LuCa_F" "Disease_COPD_F" "Disease_Asthma_F" "Disease_Pollinosis_F")

for file in "${F_Array[@]}"; do

  for file2 in "${F_Array2[@]}"; do
    echo -e  "$file" "$file2" "\n"

    ./ldsc.py --rg ${file}.sumstats.gz,${file2}.sumstats.gz --ref-ld-chr baselineLD/baselineLD. --w-ld-chr baselineLD/1000G_Phase3_EAS_weights_hm3_no_MHC/weights.EAS.hm3_noMHC. --out FvF_${file}_${file2}

  done
  
  F_Array2=("${F_Array2[@]:1}") #removes the first element

done






