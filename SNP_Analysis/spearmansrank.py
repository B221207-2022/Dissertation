#calculates spearmans rank for ttest
import pandas as pd
import glob
import scipy.stats
import re
import numpy

path= r'/PATH/Dataset/*BBJ*_Clean*'
file_list = glob.glob(path)
print(file_list)

output_file = open("/PATH/Results/spearmansrank.txt","w")
output_file.write("Trait Correlation P\n")

file_slug_list = []
for item in file_list:
	file_test = re.findall("(.+\w_.+\w_BBJ)_.+\w_Clean.txt", item)
	file_slug_list.append(file_test[0])
file_slug_list = set(file_slug_list)

for file in file_slug_list:
    print(file)

    df = pd.read_csv(file+"_autosome_Clean.txt", sep="\t", dtype={"BETA.x": float, "BETA.y": float})
    dfX = pd.read_csv(file+"_Xchromosome_Clean.txt", sep="\t", dtype={"BETA.x": float, "BETA.y": float})
    
    print(df.head())
   # print(df.dtypes)

    x_array = numpy.append(df["BETA.x"],dfX["BETA.x"] )
    y_array = numpy.append(df["BETA.y"],dfX["BETA.y"] )

    corr_results = scipy.stats.spearmanr(x_array, y_array)
    print(corr_results)
    trait = re.findall("_(.+)_BBJ", file)
    
    output_file.write(trait[0] + " " + str(corr_results[0]) + " " + str(corr_results[1]) + "\n")
    
output_file.close()
