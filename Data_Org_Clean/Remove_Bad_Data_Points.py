#removes entries with missing data (indicated by . in SE column)
#checks allele order for Smoking traits (Disease came standarised)

import pandas as pd
import glob
import re
import numpy as np
from scipy import stats


file_list = glob.glob("*BBJ*")

for file in file_list:
    print(file)
    file_type = re.findall("(.+\w)_.+\w_BBJ_.+\w.txt", file)[0]
    print(file_type)
    if file_type == "Smoking":
        df = pd.read_csv(file, sep=" ",dtype={"BETA.x": float, "BETA.y": float})
        for index, row in df.iterrows():
            if row["A1"] != row["A1.y"]: #checks condition if the alleles are flipped
                df.at[index,"BETA.y"] = -df.at[index,"BETA.y"]
                
        
    else:
        df = pd.read_csv(file, sep="\t", dtype={"BETA.x": float, "BETA.y": float})
    
    trait = re.findall("_(.+)_BBJ", file)[0]
    chrom_type = re.findall("_BBJ_(.+).txt", file)[0]
    
    print(df.head())

    ##remove the rows with no standard error
    df = df.drop(df[df["SE.x"] == "."].index)
    df = df.drop(df[df["SE.y"] == "."].index)
  

    new_file_name = file_type+"_"+trait+"_BBJ_"+chrom_type+"_Clean.txt"
    
    df.to_csv(new_file_name, sep="\t", index=False)
    
