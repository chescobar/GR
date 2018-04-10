#!/bin/bash
user=`whoami`
IFS=$'\n'
ruta=`echo $1 |awk -F " " {' print $1 '}`
echo "" > ~/.gradio/data/tmp/BuscarCom
comercialscan=`echo $1 |awk -F "$ruta " {' print $2 '}`
escaneo=`grep -i "$comercialscan" /home/$user/.gradio/data/$ruta/*/*|awk -F ".gradio/data/$ruta/" {' print $2 '}|sed s/".com\:"/"|"/g`
echo escaneo $escaneo
n=0
	for line in $escaneo
	do
	#echo "linea" $line
	IFS="|"
		m=0
		for WORD in $line
		do
		data[$m]=$WORD
		m=$(($m+1))
		done
	echo `echo ${data[0]}|sed s/"\/"/"\:"/g`',"'${data[1]}'",'`echo ${data[2]}|sed s/1/L/g|sed s/2/M/g|sed s/3/X/g|sed s/4/J/g|sed s/5/V/g|sed s/6/S/g|sed s/7/D/g`","`echo ${data[3]}|cut -c 1-4`"-"`echo ${data[3]}|cut -c 5-6`"-"`echo ${data[3]}|cut -c 7-8`","`echo ${data[4]}|cut -c 1-4`"-"`echo ${data[4]}|cut -c 5-6`"-"`echo ${data[4]}|cut -c 7-8`	>> /home/$user/.gradio/data/tmp/BuscarCom		
	IFS="\n"
	n=$(($n+1))	
	done
	
	sort -n ~/.gradio/data/tmp/BuscarCom  > ~/.gradio/data/tmp/BuscarComSort
	 sed -i '1i Hora, Audio, Días, Inicio, Fin' ~/.gradio/data/tmp/BuscarComSort
	
