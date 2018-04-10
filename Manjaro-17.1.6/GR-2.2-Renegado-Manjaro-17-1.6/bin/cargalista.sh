#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 5-Ago-2017		    #
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

echo "======================================================="
echo "G Radio -v:aqua ***Carga Lista****"
salir=0
nlinea=1
playlist=0
while [ $salir=0 ]; do  #1
		listatemas=14
		hora=`date  +%-H` 
		dia=`date +%u`
		fecha=`date +%-9d-%-m-%-Y-%-H_%-M`

		##Determinar el número de lineas playlist de la lista
		ranura=`echo "$hora-$(($hora+1)).mus"`
		nlineas=`grep -c $ ~/.gradio/data/parrilla/$dia/$ranura|grep -v "^[ ]*$" `
		hora1=`date  +%-H` 
		#playlist=0

	echo "la ranura tiene:" $nlineas "lineas y nlinea parte de:" $nlinea #>> ~/.gradio/data/tmp/gr-$fecha.log
	while [ $hora = $hora1 ]; do  #2

	#Construye un playlis de n temas

			playlist=`grep -c $ ~/.gradio/data/tmp/playlist|grep -v "^[ ]*$"`
			

			echo "playlist inicial" $playlist #>> ~/.gradio/data/tmp/gr-$fecha.log
			while [ $playlist -le $listatemas ]; do #3
			#if [ -s ~/.gradio/data/parrilla/$dia/$ranura ]; then	#fi1
			caracteres=`wc -m ~/.gradio/data/parrilla/$dia/$ranura|cut -d " " -f 1`
			echo caracteres $caracteres
				if [[ $caracteres -gt $listatemas ]]; then
					nlinea=1 
					
				while [ $nlinea -le $nlineas ]; do #4
				caracteres=`wc -m ~/.gradio/data/parrilla/$dia/$ranura|cut -d " " -f 1`
				echo "nlinea:" $nlinea "nlineas" $nlineas  #>> ~/.gradio/data/tmp/gr-$fecha.log

				line="`sed -n $nlinea"p" ~/.gradio/data/parrilla/$dia/$ranura`" 

				if [[ $hora = $hora1 ]]; then #fi3

				ouch=0		
				if [[ $line = "Hora" ]]; then #fi4
						echo Hora >> ~/.gradio/data/tmp/playlist	
						randomfile="Hora"
						echo "<font size="1" color="green"><b>$randomfile</b></font></br>" >> ~/.gradio/data/tmp/playlistweb
						echo "$randomfile" >> ~/.gradio/data/tmp/playlistg3
				else #fi4
					line=`echo -e "${line}"|sed  s/\'//g` #Con asterisco
					#echo "line filtro1" $line >> ~/.gradio/data/tmp/gr-$fecha.log
					
					line=`echo -e "${line}"|sed  s/"*"/""/g` #|sed  s/" "/"\\\\ "/g` #sin esterisco y limpiado


			if [[ -f "$line" ]]; then #Es archivo?				

				extension="${line##*.}"
						validado=`grep -i $extension ~/.gradio/data/extensiones`
							if [ "$validado" != "" ]; then #fi5 es archivo?
						randomfile=$line
					duracion=`mplayer -ao null -identify -frames 0 "$randomfile" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
					echo duracion $duracion	
						#duracion=`printf "%.0f\n" $duracion`
						duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
						nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
						echo "$randomfile" >> ~/.gradio/data/tmp/playlist 
						echo "<font size='1' color='green'><b>$nombrebase</b></font></br>" >> ~/.gradio/data/tmp/playlistweb
						echo "$nombrebase" "["$duracionview"]" >> ~/.gradio/data/tmp/playlistg3
						#echo "archivo:" $randomfile >> ~/.gradio/data/tmp/gr-$fecha.log
			fi #es archivo?

					else #fi5 es carpeta?
					if [[ -d "$line" ]]; then # Es directorio?
						files=`ls -R "$line"|grep -c $`
						if [[ $ouch = 0 ]]; then #fi6

						yatocado=1
						infinito=0
						encabezado=""
						while [[ $yatocado = 1 || $encabezado != "" ]]; do

						randomico=$((RANDOM % $files))
						#echo "randomico:" $randomico >> ~/.gradio/data/tmp/gr-$fecha.log
							if [[ $randomico != 0 ]]; then #00
								
							
								temabase="`ls -R "$line"|sed -n $randomico"p"`"
								#echo "temabase" $temabase #>> ~/.gradio/data/tmp/gr-$fecha.log
							
								encabezado=`echo $temabase|grep \/:`
								#echo "encabezado" $encabezado
								if [[ $encabezado = "" ]]; then
								randomfile=`find "$line" -name "$temabase" -print|sed -n 1p`
								fi
								if [[ "$randomfile" != "" ]]; then #fi7
								extension="${randomfile##*.}"
								validado=`grep -i $extension ~/.gradio/data/extensiones`
							if [ "$validado" != "" ]; then #fi8	
										#echo "extensión desde randomico" $extension #>> ~/.gradio/data/tmp/gr-$fecha.log
										valido=1

							else
										#echo "no cumple extension" >> ~/.gradio/data/tmp/gr-$fecha.log				
										valido=0
							fi #fi8
								#Control de random para no repetir
								nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
								ruta=`echo "$randomfile"|sed s/"\/$nombrebase"//g`
									control=""
									if [[ -s "$ruta"/.historico.mus ]]; then
									control=`grep "\"$nombrebase" "$ruta"/.historico.mus`
									fi
								control1=`grep "$nombrebase" ~/.gradio/data/tmp/playlist`
									#echo "control:" $control "control1" $control1 "valido" $valido
								if [[ $control = "" && $control1 = "" && $valido = 1 ]]; then
								yatocado=0
								fi
								#echo "yatocado:" $yatocado

								#echo "files:" $files >> ~/.gradio/data/tmp/gr-$fecha.log
								else
								echo "error randomico fue" $randomico #>> ~/.gradio/data/tmp/gr-$fecha.log
							
							fi #00	
							#encabezado=`echo $temabase|grep \/:`
							
						ouch=0	
						fi #ouch fi 7
					infinito=$(($infinito +1))
					#echo "infinito" $infinito
								if [[ $files -lt 5 || $infinito -gt 600 ]]; then
								yatocado=0
								fi
					if [[ $infinito -gt 500 && -s "$ruta"/.historico.mus ]]; then
					rm "$ruta"/.historico.mus
					# 1000 intentos deberían ser suficientes :)
					fi
					done #ya tocado

										echo "$randomfile" >> ~/.gradio/data/tmp/playlist
					duracion=`mplayer -ao null -identify -frames 0 "$randomfile" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
					echo duracion $duracion	
										#duracion=`printf "%.0f\n" $duracion`
										echo "<font size='1' color='green'><b>"$temabase"</b></font></br>" >> ~/.gradio/data/tmp/playlistweb
										duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
										echo "$temabase" "[""$duracionview""]"  >> ~/.gradio/data/tmp/playlistg3
						fi #fi 6
				else
				#echo "no encontre la carpeta" $line >> ~/.gradio/data/tmp/gr-$fecha.log	
				randomfile=""
				fi # es directorio?
					fi #fi4

				fi #fi3
						hora1=`date  +%"-H"`

						#echo "randomfile a playlist -->" $randomfile >> ~/.gradio/data/tmp/gr-$fecha.log	

					playlist=`grep -c $ ~/.gradio/data/tmp/playlist`

							while [[ $playlist -ge $listatemas ]]; do
							#echo "playlist es ge que listatemas"
							sleep 3

							dropfinal=`cat ~/.gradio/data/tmp/ultimodrop`
							if [[ $dropfinal = "1" ]]; then
							sleep 3
							echo "0" > ~/.gradio/data/tmp/ultimodrop
							fi		

							playlist=`grep -c $ ~/.gradio/data/tmp/playlist`
							done	

							
				
				
			else
				playlist=$(($playlist+1)) #para salir del lazo infinito
				echo "playlist" $playlist
			
			fi #fi1	
			nlinea=$(($nlinea+1))
			Shell "sed -i '/^$/d' ~/.gradio/data/tmp/playlist*" Wait			
			~/.gradio/bin/cartucho.sh &
			done #4 
			
		else #fi1
			#killall -9 zenity
			#zenity --warning --title="Alerta" --text "No existe parrilla musical programada a la $hora horas" &
			echo "No existe parrilla musical programada a la $hora horas" > ~/.gradio/data/tmp/currentcomercial.txt
			playlist=$listatemas

			#playlist=`grep -c $ ~/.gradio/data/tmp/playlist|grep -v "^[ ]*$"`





			hora1=`date  +%"-H"`
			#echo "hora" $hora "hora1" $hora1
			sleep 3
			playlist=0
			nlinea=0
		fi #fi1
			
			#echo playlist: $playlist >> ~/.gradio/data/tmp/gr-$fecha.log
			#echo listatemas: $listatemas >> ~/.gradio/data/tmp/gr-$fecha.log
			
		done #3
		exec ~/.gradio/bin/cartucho.sh &
			#exit 0		
	#hora1=`date  +%"H"`mortal error
	hora1=`date  +%-H` 
	#echo "hora:" $hora "hora1:"$hora1 >> ~/.gradio/data/tmp/gr-$fecha.log
	#sleep 3
	done #2
	#echo "salio de lazo de hora" >> ~/.gradio/data/tmp/gr-$fecha.log
done #1
