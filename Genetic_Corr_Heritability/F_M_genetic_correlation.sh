#!/bin/bash
#$ -cwd
#$ -l h_rt=100:00:00
#$ -l h_vmem=32G
#$ -pe sharedmem 2
#$ -N FvM_rev_genetic_cor
#$ -o /PATH/ldsc
#$ -e /PATH/ldsc

source /exports/applications/apps/SL7/anaconda/5.3.1/etc/profile.d/conda.sh

conda activate ldsc

cd /PATH/ldsc/ldsc

declare -a F_Array=("Disease_Pollinosis_F" "Disease_Asthma_F" "Disease_COPD_F" "Disease_LuCa_F" "Smoking_FORMER_F" "Smoking_EVERSMK_F" "Smoking_CPD_F" "Smoking_AI_F")
declare -a M_Array2=("Disease_Pollinosis_M" "Disease_Asthma_M" "Disease_COPD_M" "Disease_LuCa_M" "Smoking_FORMER_M" "Smoking_EVERSMK_M" "Smoking_CPD_M" "Smoking_AI_M")


for file in "${F_Array[@]}"; do

  for file2 in "${M_Array2[@]}"; do
    echo -e  "$file" "$file2" "\n"

    ./ldsc.py --rg ${file}.sumstats.gz,${file2}.sumstats.gz --ref-ld-chr baselineLD/baselineLD. --w-ld-chr baselineLD/1000G_Phase3_EAS_weights_hm3_no_MHC/weights.EAS.hm3_noMHC. --out FvMrev_${file}_${file2}

  done
  
  M_Array2=("${M_Array2[@]:1}") #removes the first element

done






