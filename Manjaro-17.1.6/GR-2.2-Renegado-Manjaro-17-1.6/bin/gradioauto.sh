#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 04-Marzo-2018		    #
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

function tiempo() {
#echo "funciontiempo en gradio.sh"
duracion=`mplayer -ao null -identify -frames 0 "$1" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
#echo duracion $duracion	
echo "00:00:$duracion" > ~/.gradio/data/tmp/duracion
#echo "duracion" $duracion
				segundos=$duracion
				return $segundos
}
###############INICIO PROGRAMA######################

killall -9 comercialdaemon.sh
killall -9 cargalista.sh
#echo "======================================================="
echo "G Radio bash module  -v:Renegado"
echo $$ > ~/.gradio/data/pid

					echo "Cargando.." > ~/.gradio/data/tmp/avance
					echo "Cargando" > ~/.gradio/data/tmp/avanceweb
#~/.gradio/bin/gradio-gui.sh &
#Reproducir desde la parrilla
#Determinar dia de la semana y hora
echo "Modo Automático" > ~/.gradio/data/tmp/currentcomercial.txt;




#Vaciar playlist y Comerciales
#cat /dev/null > ~/.gradio/data/tmp/playlistg3
#cat /dev/null > ~/.gradio/data/tmp/playlist
#cat /dev/null > ~/.gradio/data/tmp/playlistweb
#cat /dev/null > ~/.gradio/data/tmp/cartucho1
#cat /dev/null > ~/.gradio/data/tmp/cartucho2
#cat /dev/null > ~/.gradio/data/tmp/cartucho3
#cat /dev/null > ~/.gradio/data/tmp/cartucho4
#cat /dev/null > ~/.gradio/data/tmp/cartucho5
#sed -i "1d" ~/.gradio/data/tmp/playlist
#sed -i "1d" ~/.gradio/data/tmp/playlistweb
#sed -i "1d" ~/.gradio/data/tmp/playlistg3

#Las siguientes lineas vacían los comerciales, pero si el operador
#cierra y abre el programa por emergencia, perderá los comerciales no pautados
#en todo caso puede borrar manualmente los comerciales

#cat /dev/null > ~/.gradio/data/tmp/comercialeslist
#cat /dev/null > ~/.gradio/data/tmp/comercialeslistweb
#cat /dev/null > ~/.gradio/data/tmp/comercialeslistwebg3
#sed -i "1d" ~/.gradio/data/tmp/comercialeslist
#sed -i "1d" ~/.gradio/data/tmp/comercialeslistweb
#sed -i "1d" ~/.gradio/data/tmp/comercialeslistwebg3

#Vaciar eventos
cat /dev/null > ~/.gradio/data/tmp/eventoslist
cat /dev/null > ~/.gradio/data/tmp/eventoslistweb
cat /dev/null > ~/.gradio/data/tmp/eventoslistwebg3
sed -i "1d" ~/.gradio/data/tmp/eventoslist
sed -i "1d" ~/.gradio/data/tmp/eventoslistweb
sed -i "1d" ~/.gradio/data/tmp/eventoslistwebg3

~/.gradio/bin/cargalista.sh & #xterm -iconic  -e 

z=`ps -e |grep comercialdaemon.sh`
if [ "$z" = "" ]; then 
~/.gradio/bin/comercialdaemon.sh & #xterm -iconic  -e 
fi
sleep 1 #Tiempo para que el cargalista cargue el playlist
					echo "Listo!" > ~/.gradio/data/tmp/avance
					echo "Listo!" > ~/.gradio/data/tmp/avanceweb


salir=0
saliolazo=0
#################################################
while [ $salir=0 ]; do
minini=`date  +%-M`
hini=`date +%-H`
hora=`date  +%-H` 
dia=`date +%u`
minuto=`date +%-M`
#echo `date`
previo="inicio"

ranura=`echo "$hora-$(($hora+1)).mus"`
echo 0 > ~/.gradio/data/tmp/repitiendo

echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt
echo "Visor de Temas Musicales" > ~/.gradio/data/tmp/currentsong.txt

caracteres=`wc -m ~/.gradio/data/parrilla/$dia/$ranura|cut -d " " -f 1`

			if [[ $caracteres -lt 5 ]]; then

				cat /dev/null > ~/.gradio/data/tmp/playlistg3
				cat /dev/null > ~/.gradio/data/tmp/playlist
				cat /dev/null > ~/.gradio/data/tmp/playlistweb
				cat /dev/null > ~/.gradio/data/tmp/cartucho1
				cat /dev/null > ~/.gradio/data/tmp/cartucho2
				cat /dev/null > ~/.gradio/data/tmp/cartucho3
				cat /dev/null > ~/.gradio/data/tmp/cartucho4
				cat /dev/null > ~/.gradio/data/tmp/cartucho5
				sed -i "1d" ~/.gradio/data/tmp/playlist
				sed -i "1d" ~/.gradio/data/tmp/playlistweb
				sed -i "1d" ~/.gradio/data/tmp/playlistg3

			fi



##Determinar el número de lineas de playlist
nlineas=`grep -c $ ~/.gradio/data/tmp/playlist`
hora1=`date  +%-H` 
#echo nlineas: $nlineas
while [ $hora = $hora1 ]; do
#		echo ranura $ranura 
nlineas=`grep -c $ ~/.gradio/data/tmp/playlist`

#########################PARRILLA MUSICAL#####################################################


	if [[ $nlineas -ge 1 ]]; then		
		nlinea=1 
		while [ $nlinea -le $nlineas ]; do 

			estadotv=`cat ~/.gradio/data/tmp/tvestado`
			desplazamiento=`cat ~/.gradio/data/tmp/tvdesplazamiento`
			teletexto=`cat ~/.gradio/data/tmp/teletexto`
			if [[ $estadotv = 1 ]]; then
			tvopcion="-fs -geometry $desplazamiento"
			else
			tvopcion="--novideo"
			fi
			srt=~/.gradio/data/tmp/teletexto.srt
			color=`cat ~/.gradio/data/tmp/teletexto.color`
			if [[ $estadotv = 1 && $teletexto = 1 ]]; then
			srtopcion="-utf8 -sub $srt $color "
			else
			srtopcion=""
			fi
				
				###echo 0 > ~/.gradio/data/tmp/repitiendo
				randomfile=`sed -n 1p ~/.gradio/data/tmp/playlist`

				nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
				musini=`date +%s`					
	
			if [[ $randomfile = "Hora" && $previo != "$randomfiles" ]];
				then	
					twitter=`cat ~/.gradio/data/tmp/twidge`
					mix=`cat ~/.gradio/data/mix.txt`
					nombrebase="Hora"
					echo "Hora" > ~/.gradio/data/tmp/currentsong.txt 
					echo "Hora" ~/.gradio/data/tmp/currentsongweb
					if [[ $twitter = 1 ]]; then 
					echo "Ahora emitiendo la hora"|twidge update & 
					fi
					echo "Hora" ~/CurrenSong.txt
					killall -9 countdown.sh
					echo "Hora" > ~/.gradio/data/tmp/avance
					echo "<font color='red' size='24'><b>Hora</b></font>" > ~/.gradio/data/tmp/avanceweb
						sed -i "1d" ~/.gradio/data/tmp/playlistg3
						#echo randomfile $randomfile

					~/.gradio/bin/cartucho.sh &
					~/.gradio/bin/GR_ClientSocketPlayList.gambas &
					
						desiguiente=`cat ~/.gradio/data/tmp/desiguiente`
						if [[ $desiguiente = 0 ]]; then
						sleep $(($mix-2))
						fi

					xterm -iconic  -fg Green -bg DarkBlue -title "hora" -geometry 40x1-0+0  -e ~/.gradio/data/panel/hora.sh

						previo="$randomfile"

						sed -i "1d" ~/.gradio/data/tmp/playlist
						sed -i "1d" ~/.gradio/data/tmp/playlistweb
						desiguiente=0
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.gradio/bin/detenermanual.sh
fi


			else
				if [[ -s "$randomfile" ]]; then

				intercultural=`echo "$randomfile"|grep "Intercultural/Contenido/"`
				#echo "randomfile" $randomfile
				#echo "intercultural" $intercultural
				if [[ $intercultural != "" ]]; then
				echo "Ini Intercultural" > ~/.gradio/data/tmp/avance
				echo "Intro Intercultural" > ~/.gradio/data/tmp/currentsong.txt
				echo "<font color='red' size='24'><b>Ini Publicidad</b></font>" > ~/.gradio/data/tmp/avanceweb
				mplayer -af volnorm ~/G\ Radio/Intercultural/Entrada/*
				#echo "Es espacio intercultural"
				fi

					echo "$nombrebase" > ~/.gradio/data/tmp/currentsong.txt
					echo "$nombrebase" > ~/CurrentSong.txt
					twitter=`cat ~/.gradio/data/tmp/twidge`
					if [[ $twitter = 1 ]]; then 
					echo "Ahora emitiendo $nombrebase"|twidge update &
					fi

					echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb

					if [[ `cat ~/.gradio/data/tmp/mezcla` = 1 ]]; then
						if [[ `cat ~/.gradio/data/tmp/pisador` = 1 ]]; then 
						avanti=`echo "$randomfile"|grep -i avance`
							if [ "$avanti" = "" ]; then 
								if [[  $line != "Hora" ]]; then 
								xterm -iconic  -fg Black -bg Yellow -title "Pisador" -geometry 40x1+0+0 -e ~/.gradio/data/panel/pisador.sh & 
								fi
							fi
						fi  

						minini=`date  +%-M`
						echo $randomfile > ~/.gradio/data/tmp/repite
						echo "#!/bin/bash" > ~/.gradio/data/tmp/repitetmp.sh
						echo "killall -9 countdown.sh" >> ~/.gradio/data/tmp/repitetmp.sh
						echo "~/.gradio/bin/countdown.sh &" >> ~/.gradio/data/tmp/repitetmp.sh
						echo "mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  $srtopcion -af volnorm \"$randomfile\"" >> ~/.gradio/data/tmp/repitetmp.sh
						#echo "sleep 1" >> ~/.gradio/data/tmp/repitetmp.sh
						echo "echo "0" > ~/.gradio/data/tmp/repitiendo" >> ~/.gradio/data/tmp/repitetmp.sh



						chmod 755 ~/.gradio/data/tmp/repitetmp.sh

						tiempo "$randomfile"
					 	killall -9 countdown.sh
						sleep 0.2
						~/.gradio/bin/countdown.sh &
						#xterm -iconic  -fg Green -bg DarkBlue -title "$nombrebase"  -geometry 40x1-0+0 -e 
						mplayer $tvopcion $srtopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  -af volnorm -slave -input file=~/.gradio/data/tmp/slave.txt  "$randomfile" > /dev/null 2>&1 &

				logo=`cat ~/.gradio/data/tmp/tvlogo`
				if [[ $estadotv = 1 && $logo = 1 ]]; then
				~/.gradio/bin/logopersiste.sh &
				fi
						ruta=`echo "$randomfile"|sed s/"\/$nombrebase"//g`
						echo "$nombrebase" >> "$ruta"/.historico.mus
						#echo "ruta" $ruta
						previo="$randomfile"
						#sleep 2
						~/.gradio/bin/cartucho.sh &
						~/.gradio/bin/GR_ClientSocketPlayList.gambas &

						sleep 1			
						sed -i "1d" ~/.gradio/data/tmp/playlist
						sed -i "1d" ~/.gradio/data/tmp/playlistweb
						sed -i "1d" ~/.gradio/data/tmp/playlistg3
						#echo randomfile $randomfile

						


						tiempo "$randomfile"
						minfin=`echo $(($minini + $segundos/60))`
						hfin=`echo $((($hini*60+$minfin)/60))`	
						#echo "minini:" $minini "minfin:" $minfin "hfin:" $hfin
						mix=`cat ~/.gradio/data/mix.txt`
						mezcla=`echo $segundos - $mix|bc`
						#echo "mezcla a" $mezcla "segundos"
						lazorepite=`cat ~/.gradio/data/tmp/repitiendo`
						if [[ $modo = 0 ]]; then
						.  ~/.gradio/bin/panico.sh &
						fi
						~/.gradio/bin/cartucho.sh &
						~/.gradio/bin/GR_ClientSocketPlayList.gambas &
						
						.  ~/.gradio/bin/panico.sh & #para panico

						sleep $mezcla
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.gradio/bin/detenermanual.sh
fi


					else 

						if [[ `cat ~/.gradio/data/tmp/pisador` = 1 ]]; then  
				
						avanti=`echo "$randomfile"|grep -i avance`
							if [ "$avanti" = "" ]; then 				
							xterm -iconic  -fg Black -bg Yellow -title "Pisador" -geometry 40x1+0+0 -e ~/.gradio/data/panel/pisador.sh & 
							fi
						fi  
						minini=`date  +%-M`
						sed -i "1d" ~/.gradio/data/tmp/playlist
						sed -i "1d" ~/.gradio/data/tmp/playlistweb
						sed -i "1d" ~/.gradio/data/tmp/playlistg3
						tiempo "$randomfile"
						#echo randomfile $randomfile
						~/.gradio/bin/cartucho.sh &
						~/.gradio/bin/GR_ClientSocketPlayList.gambas &
						killall -9 countdown.sh
						~/.gradio/bin/countdown.sh &
						#xterm -iconic  -fg Green -bg DarkBlue -title "$nombrebase" -geometry 40x1-0+0 -e 
						mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  $srtopcion -af volnorm  -slave -input file=~/.gradio/data/tmp/slave.txt  "$randomfile"  > /dev/null 2>&1
				logo=`cat ~/.gradio/data/tmp/tvlogo`
				if [[ $estadotv = 1 && $logo = 1 ]]; then
				~/.gradio/bin/logopersiste.sh &
				fi
						previo="$randomfile"
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.gradio/bin/detenermanual.sh
fi

					fi 
				else
					echo "parece que $randomfile no existe"
						sed -i "1d" ~/.gradio/data/tmp/playlist
						sed -i "1d" ~/.gradio/data/tmp/playlistweb
						sed -i "1d" ~/.gradio/data/tmp/playlistg3
				fi
			fi

			musfin=`date +%s`
			duramus=$(($musfin-$musini))
			if [ -s ~/.gradio/data/reporte/parrilla-`date +%Y-%d-%m` ]; then
			touch ~/.gradio/data/reporte/parrilla-`date +%Y-%d-%m`
			fi
			echo `date +%Y-%m-%d`,`date +%H:%M:%S`,`echo $randomfile|sed s/","/"_"/g`,$duramus,segundos,musica >> ~/.gradio/data/reporte/parrilla-`date +%Y-%d-%m`.txt
			~/.gradio/bin/tiempointercul.sh &

			~/.gradio/bin/tiempocomerciales.sh & 
echo $mix > ~/.gradio/data/mix			
			minfin=`date  +%-M`
			hfin=`date +%-H`

espera=`cat ~/.gradio/data/tmp/stop`
repitiendo=`cat ~/.gradio/data/tmp/repitiendo`

while [[ $repitiendo = 1 ]]; do
echo "GR repitiendo: $nombrebase" > ~/.gradio/data/tmp/currentsong.txt
echo "Gr repitiendo: $nombrebase" > ~/CurrentSong.txt
sleep 0.1
repitiendo=`cat ~/.gradio/data/tmp/repitiendo`
done

if [[ $espera = 1 ]]; then
~/.gradio/bin/detenermanual.sh
fi



#while [[ $espera = 1 ]]; do
#echo "Detenido...... Presione Play para pasar a modo automático" > ~/.gradio/data/tmp/currentsong.txt
#echo "Detenido...... Presione Play para pasar a modo automático" > ~/CurrentSong.txt
#sleep 1
#espera=`cat ~/.gradio/data/tmp/stop`
#done

########################################INICIO EVENTOS
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.gradio/bin/detenermanual.sh
fi
	
	echo "+++++++++Inicio Reproducción Eventos++++++++++++++++"
		cnelineas=`grep -c $ ~/.gradio/data/tmp/eventoslist`
		if [ -s ~/.gradio/data/tmp/eventoslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 
					twitter=`cat ~/.gradio/data/tmp/twidge`
					if [[ $twitter = 1 ]]; then 
					echo "Ahora emitiendo Eventos"|twidge update &
					fi

			
while [[ $cnelineas -ge 1 ]]; do
	comercial="`head -1 ~/.gradio/data/tmp/eventoslist`"
	#comercial=`sed -n 1p ~/.gradio/data/tmp/eventoslist`
	#echo "comercial:" $comercial
	nombrebase=$comercial  #`echo "$comercial" |awk -F/ '{print $NF}'`
	comini=`date +%s`
	echo "Evento: $nombrebase" > ~/.gradio/data/tmp/currentsong.txt;
	echo "Evento: $nombrebase" > ~/CurrentSong.txt
	echo "Evento: $nombrebase" > ~/.gradio/data/tmp/currentcomercial.txt;
	echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb;
	sed -i "1d" ~/.gradio/data/tmp/eventoslistweb
	sed -i "1d" ~/.gradio/data/tmp/eventoslistwebg3
			sleep 0.2
			killall -9 countdown.sh
			
		#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 

		internet=`echo "$comercial"|grep "http://"`
		echo "$comercial" > ~/.gradio/data/tmp/tmpweb
		ejecutar=`echo $comercial|grep 123456789098765432100`
		comando=`echo $comercial|awk -F"&&" '{print $2}'`
		#echo "comando" $comando 

		if [[ $internet != "" ]]; then
			echo "00:00:"`echo "$comercial"|awk '{print $4}'`  > ~/.gradio/data/tmp/duracion
			~/.gradio/bin/countdown.sh &
			mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  $srtopcion -af volnorm -slave -input file=~/.gradio/data/tmp/slave.txt $comercial #> /dev/null 2>&1 &
			previo="$comercial"
			sed -i "1d" ~/.gradio/data/tmp/eventoslist
		else		
			if [[ $ejecutar = "" ]]; then
			tiempo "$comercial"
					killall -9 countdown.sh
					#sleep 0.5
					~/.gradio/bin/countdown.sh &
			mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  $srtopcion -af volnorm -slave -input file=~/.gradio/data/tmp/slave.txt  "$comercial" > /dev/null 2>&1 &
			sed -i "1d" ~/.gradio/data/tmp/eventoslist
			cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.gradio/data/tmp/fundidocomerciales`
			espera=$(($segundos-$fundidocom))
			sleep $espera

			previo="$comercial"
			else
			source $comando
			fi
		fi
				



	#sed -i "1d" ~/.gradio/data/tmp/eventoslist
	cnelineas=`grep -c $ ~/.gradio/data/tmp/eventoslist`
	#echo "cnelineas:" $cnelineas

	comfin=`date +%s`
	duracion=$(( $comfin - $comini ))


				if [ -s ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
				touch ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`
				fi
				echo `date +%Y-%m-%d`,`date +%H:%M:%S`,`echo "$comercial"|sed s/","/"_"/g`,$duracion,segundos,eventos >> ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

done
		fi
		#echo "0" >  ~/.gradio/data/tmp/desiguiente
		
	#if [[ $iniespaciop = 3 ]]; then
	#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.gradio/data/panel/playfinespacio.sh
	#fi

echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
#echo "+++++++++Fin Reproducción Eventos++++++++++++++++"
################################### FIN EVENTOSS #####################################

########################################INICIO COMERCIALES
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.gradio/bin/detenermanual.sh
fi
	
	#echo "+++++++++Inicio Reproducción Comerciales++++++++++++++++"
		iniespaciop=`cat ~/.gradio/data/tmp/espacio`
		cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`
		if [ -s ~/.gradio/data/tmp/comercialeslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 
			desiguiente=`cat ~/.gradio/data/tmp/desiguiente`
			if [[ $desiguiente = 0 ]]; then
			sleep $(($mix-1))
			fi

			if [[ $iniespaciop = 1 ]]; then
			~/.gradio/data/panel/playinicioespacio.sh #xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 
			iniespaciop=3
			fi
					twitter=`cat ~/.gradio/data/tmp/twidge`
					if [[ $twitter = 1 ]]; then 
			echo "Ahora emitiendo Comerciales"|twidge update &
			xterm -iconic  -fg Green -bg DarkBlue -title "Clima" -geometry 40x1-0+0  -e ~/.gradio/bin/tiempo-clima.sh &
					fi

while [[ $cnlineas -ge 1 ]]; do

			comercial="`head -1 ~/.gradio/data/tmp/comercialeslist`"

			#comercial=`sed -n 1p ~/.gradio/data/tmp/comercialeslist`

			nombrebase=`echo "$comercial" |awk -F/ '{print $NF}'`
			comini=`date +%s`
			echo "$nombrebase" > ~/.gradio/data/tmp/currentsong.txt;
			echo "$nombrebase" > ~/CurrentSong.txt
			echo "$nombrebase" > ~/.gradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb;
			sed -i "1d" ~/.gradio/data/tmp/comercialeslistweb
			sed -i "1d" ~/.gradio/data/tmp/comercialeslistwebg3
			tiempo "$comercial"
					killall -9 countdown.sh
					#sleep 0.5
					~/.gradio/bin/countdown.sh &
				#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 
				
				mplayer -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  $tvopcion -af volnorm -slave -input file=~/.gradio/data/tmp/slave.txt  "$comercial"  > /dev/null 2>&1 &
				~/.gradio/bin/GR_ClientSocketCom.gambas &


				previo="$comercial"

			sed -i "1d" ~/.gradio/data/tmp/comercialeslist
			cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.gradio/data/tmp/fundidocomerciales`
			espera=$(($segundos-$fundidocom))
			sleep $espera



			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))


						if [ -s ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%m-%d`,`date +%H:%M:%S`,`echo "$comercial"|sed s/","/"_"/g`,$duracion,segundos,comerciales >> ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales


done
		fi
		echo "0" >  ~/.gradio/data/tmp/desiguiente
		
	if [[ $iniespaciop = 3 ]]; then
	~/.gradio/data/panel/playfinespacio.sh #xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 
	fi
			espera=`cat ~/.gradio/data/tmp/stopcomercial`
			while [[ $espera = 1 ]]; do
			echo "Detenido Comerciales...... Presione Play para pasar a modo automático" > ~/.gradio/data/tmp/currentsong.txt
			sleep 1
			espera=`cat ~/.gradio/data/tmp/stopcomercial`
			done
echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
#echo "+++++++++Fin Reproducción Comerciales++++++++++++++++"
################################### FIN COMERCIALES #####################################

########################################INICIO EVENTOS CON ESPERA
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
sleep $mix
~/.gradio/bin/detenermanual.sh
fi
	
	#echo "+++++++++Inicio Reproducción Eventos con espera++++++++++++++++"
		cnelineas=`grep -c $ ~/.gradio/data/tmp/eventos-esperalist`
		if [ -s ~/.gradio/data/tmp/eventos-esperalist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 
					twitter=`cat ~/.gradio/data/tmp/twidge`
					if [[ $twitter = 1 ]]; then 
					echo "Ahora emitiendo Eventos con espera"|twidge update &
					fi

			
while [[ $cnelineas -ge 1 ]]; do
	comercial="`head -1 ~/.gradio/data/tmp/eventos-esperalist`"
	#comercial=`sed -n 1p ~/.gradio/data/tmp/eventoslist`
	#echo "comercial:" $comercial
	nombrebase=$comercial  #`echo "$comercial" |awk -F/ '{print $NF}'`
	comini=`date +%s`
	echo "Evento: $nombrebase" > ~/.gradio/data/tmp/currentsong.txt;
	echo "Evento: $nombrebase" > ~/CurrentSong.txt
	echo "Evento: $nombrebase" > ~/.gradio/data/tmp/currentcomercial.txt;
	echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb;
	sed -i "1d" ~/.gradio/data/tmp/eventos-esperalistweb
	sed -i "1d" ~/.gradio/data/tmp/eventos-esperalistwebg3
			sleep 0.2
			killall -9 countdown.sh
			
		#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e 

		internet=`echo "$comercial"|grep "http://"`
		echo "$comercial" > ~/.gradio/data/tmp/tmpweb
		ejecutar=`echo $comercial|grep 123456789098765432100`
		comando=`echo $comercial|awk -F"&&" '{print $2}'`
		#echo "comando" $comando 

		if [[ $internet != "" ]]; then
			echo "00:00:"`echo "$comercial"|awk '{print $4}'`  > ~/.gradio/data/tmp/duracion
			~/.gradio/bin/countdown.sh &
			mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  $srtopcion -af volnorm -slave -input file=~/.gradio/data/tmp/slave.txt $comercial #> /dev/null 2>&1 &
			previo="$comercial"
			sed -i "1d" ~/.gradio/data/tmp/eventos-esperalist
		else		
			if [[ $ejecutar = "" ]]; then
			tiempo "$comercial"
					killall -9 countdown.sh
					#sleep 0.5
					~/.gradio/bin/countdown.sh &
			mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  $srtopcion -af volnorm -slave -input file=~/.gradio/data/tmp/slave.txt  "$comercial" > /dev/null 2>&1 &
			sed -i "1d" ~/.gradio/data/tmp/eventos-esperalist
			cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.gradio/data/tmp/fundidocomerciales`
			espera=$(($segundos-$fundidocom))
			sleep $espera

			previo="$comercial"
			else
			source $comando
			fi
		fi
				



	#sed -i "1d" ~/.gradio/data/tmp/eventos-esperalist
	cnelineas=`grep -c $ ~/.gradio/data/tmp/eventos-esperalist`
	#echo "cnelineas:" $cnelineas

	comfin=`date +%s`
	duracion=$(( $comfin - $comini ))


				if [ -s ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
				touch ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`
				fi
				echo `date +%Y-%m-%d`,`date +%H:%M:%S`,`echo "$comercial"|sed s/","/"_"/g` ,$duracion,segundos,"eventos en espera" >> ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

done
		fi
		#echo "0" >  ~/.gradio/data/tmp/desiguiente
		
	#if [[ $iniespaciop = 3 ]]; then
	#xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.gradio/data/panel/playfinespacio.sh
	#fi

echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
#echo "+++++++++Fin Reproducción Eventos++++++++++++++++"
################################### FIN EVENTOS CON ESPERA #####################################

nlinea=$(($nlinea+1))
#echo "nlinea" $nlinea	
done 

#Si no hay lista 
else
 
sleep 3
fi	
hora1=`date  +%-H`
saliolazo=1
#echo "saliolazo" $saliolazo
echo "G Radio: No existe parrilla a las $hora horas" > ~/.gradio/data/tmp/currentcomercial.txt

done
#echo "final"
done
