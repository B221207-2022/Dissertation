#splits file with all SNPs needing annotation into subsets for SNPnexus
#   to handle that do not hit the query limits
#Converts data to VCF format
# Orignally an API method was tried but they had a max query limit per
#   day versus the number of data entries for SNP nexus

my_vcf = open("Disease_BBJ.vcf", "w")
my_vcf.write("##fileformat=VCFv4.1\n")
my_vcf.write("##fileDate=20121001\n")
my_vcf.write("#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO\n")

count = 1
file_num = 1
with open("Disease_BBJ.txt","r") as f:
    next(f)
    for line in f:
        if count % 10000 == 0 or count == 1:
            print(count, " ", file_num)
            my_vcf = open("Disease_BBJ"+str(file_num)+".vcf", "w")
            my_vcf.write("##fileformat=VCFv4.1\n")
            my_vcf.write("##fileDate=20121001\n")
            my_vcf.write("#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO\n")
            file_num+=1
        # print(line.split())
        line_arr = line.split()
        id_split = line_arr[0].split("_")
        my_vcf.write("chr"+id_split[0]+"\t"+id_split[1]+"\t.\t"+line_arr[1]+"\t"+line_arr[2]+"\t.\t.\t.\n")
        count+=1



