my_vcf = open("Master_rsID_list.tsv", "w")

my_vcf.write("chrom\tpos\tA1\tA2\tsID\n")


for i in range(1,889):
	with open("SNP_Annotation_Files/gen_coords_"+str(i)+".txt","r") as f:
		print("gen_coords_"+str(i)+".txt")
		next(f)
		for line in f:
			line_arr = line.split()
			id_split = line_arr[0].split(":")
			alleles = id_split[2].split("/")
			if line_arr[1] == "None":
				pos_id=line_arr[0]
			else:
				pos_id=line_arr[1]
			my_vcf.write(line_arr[2]+"\t"+line_arr[3]+"\t"+alleles[0]+"\t"+alleles[1]+"\t"+pos_id+"\n")