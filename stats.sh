#!/bin/bash 


# La variable $# es equiv a argc
if [ $# != 1 ]; then
        echo "Uso: $0 <directorio busqueda>"
        exit
fi

searchDir=$1

# Verifica que searchDir es realmente un directorio
if [ ! -e $searchDir ]; then
        echo "Directorio $1 no existe"
        exit
fi

printf "Directorio busqueda: %s\n" $1


######## Ejercicio 1 ##################################################################################################
OUTFILE="metrics.txt"
File1="Tiempo.txt"
File2="Memoria.txt"

executionSummaryFiles=(`find $searchDir -name '*executionSummary-*.txt' -print | sort | grep -v '._'`)
for i in ${executionSummaryFiles[*]};
do
	Total=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{sum=0}{sum=$6+$7+$8} END{print sum}')
	printf "$Total \n" >>$File1
	tsimTotal=$(cat $File1 | awk 'BEGIN{min=2**63-1; max=0}{if($File1<min){min=$File1};\
												if($File1>max){max=$File1};\
													total+=$File1; count+=1;\
													} \
													END{ print total, total/count, min, max }')

	Suma=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma=0}{suma=$10} END{print suma}')
	printf "$Suma \n" >>$File2
	memUsed=$(cat $File2 | awk 'BEGIN{ min=2**63-1; max=0}{if($File2<min){min=$File2};\
													if($File2>max){max=$File2};\
														suma+=$File2; count+=1;\
														} \
														 END{print suma, suma/count, min, max}')
done

printf "%i:%i:%i:%i\n%i:%i:%i:%i\n" $tsimTotal $memUsed >> $OUTFILE
rm Tiempo.txt
rm Memoria.txt


######## Ejercicio 2 ##################################################################################################
OutFile="evacuation.txt"

summaryFiles=(`find $searchDir -name '*Summary-*.txt' -print | sort `)
for i in ${summaryFiles[*]};
do
	alls=$( cat $i| tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	residents=$( cat $i | tail -n+2 | awk -F ':' '$3 == 0' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total,total/count,min,max }')

	visitorsI=$( cat $i | tail -n+2 | awk -F ':' '$3 == 1' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	residents-G0=$(cat $i | tail -n+2 | awk -F ':' '$3 == 0' | awk -F ':' '$4 == 0' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	residents-G1=$(cat $i | tail -n+2 | awk -F ':' '$3 == 0' | awk -F ':' '$4 == 1' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	residents-G2=$(cat $i | tail -n+2 | awk -F ':' '$3 == 0' | awk -F ':' '$4 == 2' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	residents-G3=$(cat $i | tail -n+2 | awk -F ':' '$3 == 0' | awk -F ':' '$4 == 3' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	visitorsI-G0=$(cat $i | tail -n+2 | awk -F ':' '$3 == 1' | awk -F ':' '$4 == 0' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;
											} \
											END{ print total/count,min,max }')

	visitorsI-G1=$(cat $i | tail -n+2 | awk -F ':' '$3 == 1' | awk -F ':' '$4 == 1' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	visitorsI-G2=$(cat $i | tail -n+2 | awk -F ':' '$3 == 1' | awk -F ':' '$4 == 2' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')

	visitorsI-G3=$(cat $i | tail -n+2 | awk -F ':' '$3 == 1' | awk -F ':' '$4 == 3' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total/count,min,max }')
done

printf "alls:%i:%i:%i\n" $alls >> $OutFiles
printf "residents:%i:%i:%i\n" $residents >> $OutFile
printf "visitorsI:%i:%i:%i\n" $visitorsI >> $OutFile
printf "residents-G0:%i:%i:%i\n" $residents-G0 >> $OutFile
printf "residents-G1:%i:%i:%i\n" $residents-G1 >> $OutFile
printf "residents-G2:%i:%i:%i\n" $residents-G2 >> $OutFile
printf "residents-G3:%i:%i:%i\n" $residents-G3 >> $OutFile
printf "visitorsI-G0:%i:%i:%i\n" $visitorsI-G0 >> $OutFile
printf "visitorsI-G1:%i:%i:%i\n" $visitorsI-G1 >> $OutFile
printf "visitorsI-G2:%i:%i:%i\n" $visitorsI-G2 >> $OutFile
printf "visitorsI-G3:%i:%i:%i\n" $visitorsI-G3 >> $OutFile


######## Ejercicio 3 ##################################################################################################
usePhoneFiles=(`find $searchDir -name '*usePhone-*.txt' -print | sort `)

File3="UsePhone.txt"
OutFiles="usePhone-stats.txt"

for i in ${usePhoneFiles[*]};
do
	UsePhone=(`cat $i | tail -n+3 | cut -d ':' -f 3`)
	for j in ${UsePhone[*]};
	do
		printf "%d:\n" $j >> $File3
		#Calcula promedio, min y max
		Phone=$(cat $File3 | cut -d ':' -f 1 | awk 'BEGIN{ min=2**63-1; max=0}{if($j<min){min=$j}};\
															{if($j>max){max=$j}};\
															{total+=$j; count+=1};\
															END { print total/count, min, max}')
	done
	printf "timestamp:%i:%i:%i \n" $Phone >> $OutFiles
done
rm UsePhone.txt
