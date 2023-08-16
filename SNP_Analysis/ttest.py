import pandas as pd
import glob
import re
import numpy as np
from scipy import stats


path= r'/PATH/Dataset/*BBJ*_Clean*'
file_list = glob.glob(path)
print(file_list)

rank_dict = {}
with open("/PATH/Results/spearmansrank.txt","r") as rank_file:
     next(rank_file)
     for line in rank_file:
          arr = line.split()
          rank_dict[arr[0]] = arr[1]

print(rank_dict)


for file in file_list:
    print(file)
    
    df = pd.read_csv(file, sep="\t", dtype={"BETA.x": float, "BETA.y": float})
    
    trait = re.findall("_(.+)_BBJ", file)[0]
    chrom_type = re.findall("_BBJ_(.+)_Clean.txt", file)[0]
    
    print(df.head())

   
    df["Tstat"] = (df["BETA.y"]-df["BETA.x"]) / (np.sqrt(df["SE.y"]**2 + df["SE.x"]**2 - (2*float(rank_dict[trait])*df["SE.x"]*df["SE.y"])))
    df["TstatP"] = 2*stats.norm.sf(df["Tstat"].abs())
    print(df.head())
    
    df.to_csv("/PATH/Results/ttest/ttest_"+trait+"_"+chrom_type+".txt",sep=" ",columns=["SNP","CHR","POS","A1","A2","BETA.x","BETA.y","Tstat","TstatP"])


