#!/bin/bash
#$ -cwd
#$ -l h_rt=100:00:00
#$ -l h_vmem=32G
#$ -pe sharedmem 2
#$ -N heritability
#$ -o /PATH/ldsc
#$ -e /PATH/ldsc

source /exports/applications/apps/SL7/anaconda/5.3.1/etc/profile.d/conda.sh

conda activate ldsc

cd /PATH/ldsc/ldsc

declare -a F_Array=("Smoking_AI_F" "Smoking_AI_M" "Smoking_CPD_F" "Smoking_CPD_M" "Smoking_EVERSMK_F" "Smoking_EVERSMK_M" "Smoking_FORMER_F" "Smoking_FORMER_M" "Disease_LuCa_F" "Disease_LuCa_M"  "Disease_COPD_F" "Disease_COPD_M" "Disease_Asthma_F" "Disease_Asthma_M"  "Disease_Pollinosis_F" "Disease_Pollinosis_M")

for file in "${F_Array[@]}"; do

    echo -e  "$file" "\n"

    ./ldsc.py --h2 ${file}.sumstats.gz --ref-ld-chr baselineLD/baselineLD. --w-ld-chr baselineLD/1000G_Phase3_EAS_weights_hm3_no_MHC/weights.EAS.hm3_noMHC. --out heritability_${file}

done






