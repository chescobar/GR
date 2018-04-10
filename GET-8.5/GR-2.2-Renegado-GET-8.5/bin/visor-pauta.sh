#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 28-Jul-2011		    #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	    		    #
#	     Visor iniciado el 5 de mayo de 2017	    		    #
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

function tiempo() {
#echo "funciontiempo en gradio.sh"
	duracion=`mplayer -ao null -identify -frames 0 "$1" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
	#duracion=`printf "%.0f\n" $duracion`
	duracion=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
	return $segundos
}
###############INICIO PROGRAMA######################
usuario=`whoami`

user=`whoami`
ruta="/home/$user/.gradio/data"
dia=`` 
## Limpia el visor
		cat /dev/null > $ruta/tmp/visor-pauta
		cat /dev/null > $ruta/tmp/visor-pautaweb
		cat /dev/null > $ruta/tmp/visor-pautawebg3



#while [ $salir=0 ]; do

	minuto=`date  +%-M`
	hora=`date  +%-H` 
	dia=`date +%u`
	minuto=`date +%-M`
		
		#echo "dia" $dia "Hora" $hora "minuto" $minuto
slide=0

while [ $slide -le 23 ]; do
minslide=0

while [ $minslide -le 59 ]; do

	for pautaje in $( echo eventos comerciales eventos-espera ); do
	#echo "pautaje" $pautaje
		if [ -s "$ruta/$pautaje/$slide/$minslide.com" ]
		then
			etiqueta=0
			pauta=""
			data[2]=100000000
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
			#Etiqueta

			if [[ $now -ge ${data[2]} && $now -le ${data[3]}  && $habil -gt 0 ]]; then  
					if [ $etiqueta = 0 ];
					then
					echo "[["$slide":"$minslide" --> $pautaje]]" >> $ruta/tmp/visor-pauta
					echo "[["$slide":"$minslide" --> $pautaje]]" >> $ruta/tmp/visor-pautaweb
					echo "[["$slide":"$minslide" --> $pautaje]]" >> $ruta/tmp/visor-pautawebg3
					etiqueta=1
					fi 
				actionbase=`echo "${data[0]}"|awk -F"|" '{print $1}'`
				pauta="$actionbase"  					

				if [ -d "$actionbase" ]; then
					comercialrandom=`/bin/ls -1 "$actionbase" | sort --random-sort | head -1`
					#echo "comercialrandom" $comercialrandom
					actionbase=`echo "$comercial"|awk -F"|" '{print $1}'`
					rutacom="$actionbase/$comercialrandom"
					nombrebase=`echo "$rutacom" |awk -F/ '{print $NF}'`
					extension="${nombrebase##*.}"
					validado=`grep -i $extension $ruta/extensiones`

					if [ "$validado" != "" ]; then
					pauta="$rutacom"
					else
					zenity --warning --text="El archivo seleccionado parece no ser de audio"
					fi 
				fi
			tiempo  "$pauta"
			comercial_pautado=`echo $pauta|sed s/"\/home\/$usuario\/"//g`
			echo "$comercial_pautado" "("$duracion")" >> $ruta/tmp/visor-pauta
			nombrebase=`echo "${data[0]}" |awk -F/ '{print $NF}'`
			echo "<font size='1' color='blue'><b>$nombrebase</b></font>" >> $ruta/tmp/visor-pautaweb
			echo "$nombrebase" >> $ruta/tmp/visor-pautawebg3
			#echo "CargalistaPlay..................."
			#gmplayer  "${data[0]}"

#			duracionacumulada=$(($duracionacumulada+$segundos))
			
		#echo "coincidencia en" $ruta/$pautaje/$slide/$minslide.com "data de 2" ${data[2]}

			fi				
		done < $ruta/$pautaje/$slide/$minslide.com
		fi
	done #for pautaje
minslide=$(($minslide + 1))	
done #while minslide
slide=$(($slide + 1))
echo "actualizando: " $slide":00 horas"
echo -en "\e[1A"


done #while slide
#echo duracionacumulada $duracionacumulada
#done

