#Add chrom_pos to rsID file that match my data
#Also accounts for the different positioning of indels

my_vcf = open("Master_rsID_list_id_posid.tsv", "w")
my_vcf.write("chrom\tpos\tA1\tA2\trsID\tchrom_pos\n")

with open("Master_rsID_list.tsv","r") as f:
    next(f)
    for line in f:
        line_arr = line.split()
        if len(line_arr[2]) > 1 or len(line_arr[3]) > 1:
            
            line_arr[1] = int(line_arr[1])-1
            
        pos_id=str(line_arr[0])+"_"+str(line_arr[1])+"_"+line_arr[2]+"_"+line_arr[3]
        my_vcf.write(str(line_arr[0])+"\t"+str(line_arr[1])+"\t"+line_arr[2]+"\t"+line_arr[3]+"\t"+line_arr[4]+"\t"+pos_id+"\n")
       