#Creates file with all ssSNPs
import pandas as pd
import glob
import re
import numpy as np
from scipy import stats

# file with all ssSNP less than 0.5x10-8 in 1 sex


path= r'/PATH/Dataset/*BBJ*_Clean*'
file_list = glob.glob(path)
print(file_list)


 
output_file = open("/PATH/Results/All_ssSNP.txt","w") 
output_file.write("Trait SNP CHR POS A1 A2 BETA.x SE.x P.x BETA.y SE.y P.y\n")

for file in file_list:
    print(file)
    
    df = pd.read_csv(file, sep="\t", dtype={"BETA.x": float, "BETA.y": float})
    
    trait = re.findall("_(.+)_BBJ", file)[0]
    chrom_type = re.findall("_BBJ_(.+)_Clean.txt", file)[0]
    
    print(df.head())
    
    for index, row in df.iterrows():
            #print(row)
            if ((row["P.x"] < 0.00000005) & (row["P.y"] > 0.00000005)):
                #print(row)
                output_file.write(trait+" "+str(row["SNP"])+" "+str(row["CHR"])+ " "+str(row["POS"])+" "+row["A1"]+" "+row["A2"]+" "+str(row["BETA.x"])+" "+str(row["SE.x"])+" "+str(row["P.x"])+" "+str(row["BETA.y"])+" "+str(row["SE.y"])+" "+str(row["P.y"])+"\n")
            
            elif ((row["P.x"] > 0.00000005) & (row["P.y"] < 0.00000005)):
                output_file.write(trait+" "+str(row["SNP"])+" "+str(row["CHR"])+ " "+str(row["POS"])+" "+row["A1"]+" "+row["A2"]+" "+str(row["BETA.x"])+" "+str(row["SE.x"])+" "+str(row["P.x"])+" "+str(row["BETA.y"])+" "+str(row["SE.y"])+" "+str(row["P.y"])+"\n")
   
 
