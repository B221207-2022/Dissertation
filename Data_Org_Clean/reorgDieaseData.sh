 #!/bin/bash

#create arrays with trait names and chromsome options
traits=( $(ls | grep "sex_stratified" | sed 's/.chr.*//' | sort | uniq))

#double loop through arrays to access both chromosome files for each trait
for trait in "${traits[@]}"; do
    echo $trait
    files=( $(ls | grep $trait".*"))
	filename="Disease_"$trait"_BBJ_autosome.txt"
	filenameX="Disease_"$trait"_BBJ_Xchromosome.txt"
	#rm -f $filename #clears if it already exists if ran multible times 
	
	#adds file header 
	echo "SNP	CHR	POS	A1	A2	MAC.x	BETA.x	SE.x	P.x	AF.Cases.x	AF.Controls.x	MAC.y	BETA.y	SE.y	P.y	AF.Cases.y	AF.Controls.y	Rsq	metabeta	metase	metap	Qpvalue" >> $filename
	echo "SNP	CHR	POS	A1	A2	MAC.x	BETA.x	SE.x	P.x	AF.Cases.x	AF.Controls.x	MAC.y	BETA.y	SE.y	P.y	AF.Cases.y	AF.Controls.y	Rsq.x	Rsq.y	metabeta	metase	metap	Qpvalue" >> $filenameX
    for file in "${files[@]}"; do
	  
		echo "Filename: "$file

		filetype=( $(echo $file | sed 's/_sex_stratified.txt//' | sed 's/.*\.//'))
		if [ $filetype = "chrx" ]
		then
			#removes the header line
			tail -n +2 $file >> $filenameX
		else
			#removes the header line
			tail -n +2 $file >> $filename	
		fi



	done
done