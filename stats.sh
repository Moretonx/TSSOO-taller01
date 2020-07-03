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
	Total=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{sum=0}{sum=$6+$7+$8} END{print sum}') #Suma de los tiempos
	printf "$Total \n" >>$File1
	#Calculo de las sumas totales, promedio, mínimos y máximos
	tsimTotal=$(cat $File1 | awk 'BEGIN{min=2**63-1; max=0}{if($File1<min){min=$File1};\ 
												if($File1>max){max=$File1};\
													total+=$File1; count+=1;\
													} \
													END{ print total, total/count, min, max }')

	Suma=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{suma=0}{suma=$9} END{print suma}') #Suma de la memoria de simulación
	printf "$Suma \n" >>$File2
	#Calculo de las sumas totales, promedio, mínimos y máximos
	memUsed=$(cat $File2 | awk 'BEGIN{ min=2**63-1; max=0}{if($File2<min){min=$File2};\
													if($File2>max){max=$File2};\
														suma+=$File2; count+=1;\
														} \
														 END{print suma, suma/count, min, max}')
done

printf "tsimTotal:%i:%i:%i:%i\n" $tsimTotal >> $OUTFILE
printf "memUsed:%i:%i:%i:%i\n" $memUsed >> $OUTFILE
rm Tiempo.txt Memoria.txt


######## Ejercicio 2 ##################################################################################################

OutFile="evacuation.txt"
file1="File1.txt"
file2="File2.txt"
file3="File3.txt"
file4="File4.txt"
file5="File5.txt"
file6="File6.txt"
file7="File7.txt"
file8="File8.txt"
file9="File9.txt"
file10="File10.txt"
file11="File11.txt"

summaryFiles=(`find $searchDir -name '*Summary-*.txt' -print | sort | grep -v '._'`)
for i in ${summaryFiles[*]};
do
	#Para todas las Personas
	temp1=$(cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; count+=1;\
											} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp1 >> $file1
	alls=$(cat $file1 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')
	
	#Solo Residentes
	temp2=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==0){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp2 >> $file2
	residents=$(cat $file2 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Visitantes tipo 1
	temp3=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==1){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp3 >> $file3
	visitorsI=$(cat $file3 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Residentes menores de 15 años
	temp4=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==0 && $4 == 0){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp4 >> $file4
	residentsG0=$(cat $file4 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Residentes desde 15 hasta 29 años
	temp5=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==0 && $4 == 1){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp5 >> $file5
	residentsG1=$(cat $file5 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Resitentes desde 30 hasta 64 años
	temp6=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==0 && $4 == 2){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp6 >> $file6
	residentsG2=$(cat $file6 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Residentes mayores a 64 años
	temp7=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==0 && $4 == 3){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp7 >> $file7
	residentsG1=$(cat $file7 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Visitantes tipo 1 menores de 14 años
	temp8=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==1 && $4 == 0){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp8 >> $file8
	visitorsIG0=$(cat $file8 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Visitantes tipo 1 desde 15 hasta 29 años
	temp9=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==1 && $4 == 1){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp9 >> $file9
	visitorsIG1=$(cat $file9 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	##Visitantes tipo 1 desde 30 hasta 64 años
	temp10=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==1 && $4 == 2){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp10 >> $file10
	visitorsIG2=$(cat $file10 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')

	#Visitantes mayores a 64 años
	temp11=$( cat $i | tail -n+2 | awk -F ':' 'BEGIN{ min=2**63-1; max=0 }{if($3==1 && $4 == 3){if($8<min){min=$8};\
											if($8>max){max=$8};\
											total+=$8; countR+=1;\
											}} \
											END{ print total,min,max }')
	printf "%i %i %i\n" $temp11 >> $file11
	visitorsIG3=$(cat $file11 | awk 'BEGIN{ min=2**63-1; max=0 }{if($2<min){min=$2};\
											if($3>max){max=$3};\
											total+=$1; count+=1;\
											} \
											END{ print total/count,min,max }')
done

printf "alls:%i:%i:%i\n" $alls >> $OutFile
printf "residents:%i:%i:%i\n" $residents >> $OutFile
printf "visitorsI:%i:%i:%i\n" $visitorsI >> $OutFile
printf "residents-G0:%i:%i:%i\n" $residentsG0 >> $OutFile
printf "residents-G1:%i:%i:%i\n" $residentsG1 >> $OutFile
printf "residents-G2:%i:%i:%i\n" $residentsG2 >> $OutFile
printf "residents-G3:%i:%i:%i\n" $residentsG3 >> $OutFile
printf "visitorsI-G0:%i:%i:%i\n" $visitorsIG0 >> $OutFile
printf "visitorsI-G1:%i:%i:%i\n" $visitorsIG1 >> $OutFile
printf "visitorsI-G2:%i:%i:%i\n" $visitorsIG2 >> $OutFile
printf "visitorsI-G3:%i:%i:%i\n" $visitorsIG3 >> $OutFile

rm File1.txt File2.txt File3.txt File4.txt File5.txt File6.txt File7.txt File8.txt File9.txt File10.txt File11.txt



######## Ejercicio 3 ##################################################################################################

OutFiles="usePhone-stats.txt"
File3="tiempo_medicion.txt"
File4="UsePhone.txt"

printf "timestamp:promedio:min:max \n" >> $OutFilePhone
archivo_usePhone=(`find $searchDir -name '*usePhone-*.txt' -print | sort | grep -v '._'`)

for i in ${archivo_usePhone[*]};
do
	
	#Calcula promedios del tiempo medido
	Tiempo_medicion=(`cat $i | tail -n+3 | cut -d ':' -f 2`) #Las primeras 2 lineas del archivo no se leen
	for j in ${tiempo_medicion[*]};
	do
		printf "%i\n" $j >> $File3
		Tiempomedicion=$(cat $File3 | awk 'BEGIN{suma=0}{suma+=$1; count+=1 }; END { print suma/count }')
	done

	#Calcula promedio, min y max del uso del celular
	UsePhone=(`cat $i | tail -n+3 | cut -d ':' -f 3`)
	for j in ${UsePhone[*]};
	do
		printf "%i\n" $j >> $File4
		Phone=$(cat $File4 awk 'BEGIN{ min=2**63-1; max=0}{if($j<min){min=$j}};\
														{if($j>max){max=$j}};\
														{total+=$j; count+=1};\
														END { print total/count, min, max}')
	done
	printf "%i:" $Tiempomedicion >> $OutFiles
	printf "%i:%i:%i\n" $Phone >> $OutFiles
done
rm tiempo_medicion.txt UsePhone.txt 
