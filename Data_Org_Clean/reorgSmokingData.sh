 #!/bin/bash

#create arrays with trait names and chromsome options
traits=( $(ls | grep "2018" | sed 's/.*_2018_//' | sed 's/_BBJ_.*//' | sort | uniq ))
chrs=( $(ls | grep "2018" | sed 's/.*_BBJ_//' | sed 's/_Pcorrected.*//' | sort | uniq))

#double loop through arrays to access both chromosome files for each trait
for trait in "${traits[@]}"; do
   for chr in "${chrs[@]}"; do
	   F_filename="Female_2018_"$trait"_BBJ_"$chr"_Pcorrected.txt"
		M_filename="Male_2018_"$trait"_BBJ_"$chr"_Pcorrected.txt"
		Combine_filename="Smoking_"$trait"_BBJ_"$chr".txt"
		echo $F_filename
		echo $M_filename
		echo $Combine_filename

		#joins the F and M data based on SNP Id after sorting them
		join -j 1 -o 1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10,2.4,2.5,2.6,2.7,2.8,2.9,2.10 <(sort -k1 $F_filename) <(sort -k1 $M_filename) > $Combine_filename

		#removes the header line
		tail -n +2 $Combine_filename > tmp.txt && mv tmp.txt $Combine_filename

		#adds a new file header
		sed -i '' '1s/^/SNP CHR POS A1 A2 A1Frq\.x Rsq\.x BETA\.x SE\.x P\.x A1\.y A2\.y A1Frq\.y Rsq\.y BETA\.y SE\.y P\.y\'$'\n/' $Combine_filename


	done
done




