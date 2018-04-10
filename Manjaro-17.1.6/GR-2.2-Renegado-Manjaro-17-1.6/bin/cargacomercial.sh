#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 20-Ene-2012		    #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	    		    #
#############################################################################
#############################################################################
#                                                                           #
# This program is free software; you can redistribute it and/or modify it   #
# under the terms of the GNU General Public License as published by the     #
# Free Software Foundation; either version 2 of the License or any later    #
# version.								    #
#									    #
# This program is distributed in the hope that it will useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
# for more details.							    #
#									    #
############################################################################# 
#Comerciales 
#Después de cada tema aleatorio verifica de acuerdo a la hora si hay
#un comercial que emitir, basado en el minuto de inicio minini y el 
#final min final
#ToDo hacer un script independiente exportando las variables

function tiempo() {
echo "funciontiempo"
duracion=`mplayer -ao null -identify -frames 0 "$1" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
#duracion=`$PROGDUR -i "$1"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//`     			
			#IFS=":"
			#n=0
			#for duracion in $duracion
			#do
			#dura[$n]=$duracion
			#n=$(($n+1))
			#done
			#IFS=" "
			#	horas=`expr ${dura[0]} \* 3600`
			#	minuto=`expr ${dura[1]} \* 60`
			#	segundos=`echo "(${dura[2]}+0.5)/1"|bc`
			#	segundos=`echo $minuto + $segundos|bc`
			#	segundos=`echo $horas + $segundos|bc`
			#	echo segundos $segundos
			#	duracion=$segundos
			return $duracion
}

echo "===== Carga Comerciallist====="
function comercialplay() {
	echo "Ejecuta funcioncomercialplay"
	duracionacumulada=0
	while read comercial;
	do
		inicio=`date +%s` 
		now=`date +%Y%m%d` 
		
			IFS="|"
			n=0
			for WORD in $comercial
			do
			data[$n]=$WORD
			n=$(($n+1))
			done
			IFS=" "
		dia=`date +%u`
		habil=`echo ${data[1]}|sed -ne /$dia/p`	
		if [[ $now -ge ${data[2]} && $now -le ${data[3]}  && $habil -gt 0 ]]; then     					

			if [ -d "${data[0]}" ]; then
				comercialrandom=`/bin/ls -1 "${data[0]}" | sort --random-sort | head -1`
				ruta=`readlink --canonicalize "$comercial/$file"` # Converts to full path
				
				nombrebase=`echo "$ruta" |awk -F/ '{print $NF}'`
				extension="${nombrebase##*.}"
				validado=`grep -i $extension ~/.gradio/data/extensiones`
				if [ "$validado" != "" ]; then
				"${data[0]}"=$ruta
				else
				zenity --warning --text="El archivo seleccionado parece no ser de audio"
				fi 
			fi

		echo "${data[0]}" >> ~/.gradio/data/tmp/comercialeslist
		nombrebase=`echo "${data[0]}" |awk -F/ '{print $NF}'`
		echo "<font size='1' color='blue'><b>$nombrebase</b></font>" >> ~/.gradio/data/tmp/comercialeslistweb
		echo "$nombrebase" >> ~/.gradio/data/tmp/comercialeslistwebg3
		echo "CargalistaPlay..................."
		#gmplayer  "${data[0]}"
		tiempo  "${data[0]}"
		duracionacumulada=$(($duracionacumulada+$segundos))
		echo duracionacumulada $duracionacumulada
	echo "coincidencia en" ~/.gradio/data/comerciales/$hora/$minini.com
		fi				
	done < ~/.gradio/data/comerciales/$hora/$minini.com
}

function comercialplayx() {
	echo "ejecuta funcioncomercialplayx"
	while read comercial;
	do
		inicio=`date +%s`
		now=`date +%Y%m%d` 

			IFS="|"
			n=0
			for WORD in $comercial
			do
			data[$n]=$WORD
			n=$(($n+1))
			done
			IFS=" "
		dia=`date +%u`
		habil=`echo ${data[1]}|sed -ne /$dia/p`	
		if [[ $now -ge ${data[2]} && $now -le ${data[3]}  && $habil -gt 0 ]]; then 
		echo "encontrado data(0):" ${data[0]}   					
		echo "${data[0]}" >> ~/.gradio/data/tmp/comercialeslist
		echo "<font size='1' color='blue'>${data[0]}</font>" >> ~/.gradio/data/tmp/comercialeslistweb
		echo "CargalistaPlayX..................."
		fin=`date +%s`
		duracion=$(($fin-$inicio))

		fi
				
	done < ~/.gradio/data/comerciales/$(($hora+1))/$(($minini-60)).com		
}

echo "======================Carga Comerciales========================"
##Si el tema reproducido tiene menos de un minuto no necesita un lazo		
			if [ $minfin = $minini ]; then
				if [ -s ~/.gradio/data/comerciales/$hora/$minini.com ]; then
				echo "va a while en el mismo minuto"
				comercialplay
				fi
			fi

#			minfin=`date  +%-M`
#asegurarse que minini no es igual a minfin 
if [[ $minfin -ne $minini ]]; then

		if [ $hini = $hfin ]; then			
			echo "va a while en la misma hora"			
			while [[ $minini -lt $(($minfin+1)) ]]; do
			echo "minini:" $minini "minfin" $minfin 	
			if [ -s ~/.gradio/data/comerciales/$hora/$minini.com ]; then
				comercialplay
			fi

			#minfin=`date +%-M`			
			minini=$(($minini+1))
			done
		else
			echo "va a while con cambio de hora"		
			while [ $minini -le $(($minfin)) ]; do
			echo "minini:" $minini "minfin:" $minfin "va al lazo"
			if [ $minini -lt 60 ]; then
			echo '~/.gradio/data/comerciales/$hora/$minini.com' ~/.gradio/data/comerciales/$hora/$minini.com
				if [ -s ~/.gradio/data/comerciales/$hora/$minini.com ]; then
				comercialplay
				fi
			else 
			echo '~/.gradio/data/comerciales/$hora/$minini.com' ~/.gradio/data/comerciales/$hora/$minini.com
				if [ -s ~/.gradio/data/comerciales/$(($hora+1))/$(($minini-60)).com ]; then
				comercialplayx
				fi
				#minfin=`date +%-M`				
			fi
			minini=$(($minini+1))
			done		
		fi

fi
# fin asegurarse que minini no es igual a minfin 
##########################
#Hasta Aquí reproduce comerciales
##########################
					
echo "==========Fin Carga Comerciales==========="

