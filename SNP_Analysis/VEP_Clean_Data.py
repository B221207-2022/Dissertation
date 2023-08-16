#removed non relavent SNPs (alleles do not match study) from 
# VEP files and sorts them
import pandas as pd

VEP_file = "VEP_ssSNP_COPD_LuCa.txt"

SNP_id = {}
with open('../SNP_annotation/Master_rsID_list_id_posid.tsv') as f:
    lines = f.readlines()
    for line in lines:
        SNP_id[line.split()[4]] = line.split()[3]


df = pd.read_csv(VEP_file, sep="\t")

print(df)

index_count = 0
for index, row in df.iterrows():
    print(row['#Uploaded_variation'], row['Allele'])
    print(SNP_id[row['#Uploaded_variation']])
    if SNP_id[row['#Uploaded_variation']] != row['Allele']:
        df = df.drop(df.index[index_count])
    # print(df.index[index_count])
    else:
        index_count+=1
    
print(df)

df = df.sort_values("SYMBOL")

print(df)

df.to_csv(str('Cleaned_'+VEP_file), columns=['SYMBOL', 'Consequence', 'BIOTYPE', 'INTRON', 'Allele', 'Feature_type','#Uploaded_variation'], index=False, sep="\t")