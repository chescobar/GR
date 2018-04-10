#!/bin/bash
#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 23-Jun-2011		    #
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

########################################INICIO COMERCIALES MANUAL
#. ~/.gradio/bin/comercialplay.sh 	

function tiempo() {
#echo "funciontiempo en gradio.sh"
duracion=`mplayer -ao null -identify -frames 0 "$1" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
echo "00:00:$duracion" > ~/.gradio/data/tmp/duracion
#echo "duracion" $duracion
				segundos=$duracion
				return $segundos
}

	
espera=`cat ~/.gradio/data/tmp/stop`

 

modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 1 ]]; then
a=`ps -e |grep gradioauto.sh`
if [ "$a" = "" ]; then
~/.gradio/bin/gradioauto.sh
else
~/.gradio/bin/siguiente.sh
fi
fi


modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then

echo "Modo Manual" > ~/.gradio/data/tmp/currentcomercial.txt;
killall -9 panico.sh
killall -9 gmplayer
killall -9 mplayer
killall -9 sleep
killall -9 countdown.sh
killall -9 gradioauto.sh
echo "00:00:00" > ~/.gradio/data/tmp/avance
		iniespaciop=`cat ~/.gradio/data/tmp/espacio`
		cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`

			estadotv=`cat ~/.gradio/data/tmp/tvestado`
			desplazamiento=`cat ~/.gradio/data/tmp/tvdesplazamiento`
			teletexto=`cat ~/.gradio/data/tmp/teletexto`
			if [[ $estadotv = 1 ]]; then
			tvopcion="-fs -geometry $desplazamiento"
			else
			tvopcion=""
			fi
			srt=~/.gradio/data/tmp/teletexto.srt
			color=`cat ~/.gradio/data/tmp/teletexto.color`
			if [[ $estadotv = 1 && $teletexto = 1 ]]; then
			srtopcion="-sub $srt $color "
			else
			srtopcion=""
			fi


		if [ -s ~/.gradio/data/tmp/comercialeslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 

			#sleep $(($mix-2))
			if [[ $iniespaciop = 1 ]]; then
			~/.gradio/data/panel/playinicioespacio.sh
			iniespaciop=3
			fi

		while [ $cnlineas -ge 1 ]; 
		do 
		cline="`sed -n $cnlinea"p" ~/.gradio/data/tmp/comercialeslist`" 
		cline1=`sed -n $cnlinea"p" ~/.gradio/data/tmp/comercialeslist` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			cline=`echo -e "${cline}"|sed  s/\'//g`
			cline=`echo -e "${cline}"|sed  s/" "/"\\\\ "/g`
					
			randomfile=`sed -n 1p ~/.gradio/data/tmp/comercialeslist`
			sed -i "1d" ~/.gradio/data/tmp/comercialeslist
			sed -i "1d" ~/.gradio/data/tmp/comercialeslistweb
			sed -i "1d" ~/.gradio/data/tmp/comercialeslistwebg3
			echo randomfile $randomfile
			nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`

			comini=`date +%s`
			# randomfile se usa para calcular el tiempo del sleep ;)
			echo "$randomfile" > ~/.gradio/data/tmp/currentsong.txt;
			echo "$randomfile" > ~/.gradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb;

			tiempo "$randomfile"
			~/.gradio/bin/countdown.sh &

				xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer -volume 100 $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo $srtopcion -slave -input file=~/.gradio/data/tmp/slave.txt  "$randomfile"  > /dev/null 2>&1 &


			previo="$comercial"

			#sed -i "1d" ~/.gradio/data/tmp/comercialeslist
			cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`
			fundidocom=`cat ~/.gradio/data/tmp/fundidocomerciales`
			esperat=$((segundos-$fundidocom))
			#echo "esperat" $esperat
			sleep $esperat

			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))
						if [ -s ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

			esperacom=`cat ~/.gradio/data/tmp/stopcomercial`
			
			if [[ $iniespaciop = 3 ]]; then
			if [[ $esperacom = 1 ]]; then
			~/.gradio/data/panel/playfinespacio.sh
			if [[ $espera = 1 ]]; then
			echo "Detenido...... Presione Play para pasar a modo automático" > ~/.gradio/data/tmp/currentsong.txt
			fi

			modo=`cat ~/.gradio/data/tmp/modo`
			if [[ $modo = 0 ]]; then
			echo "Modo Manual...... Presione *Manual* para pasar a modo automático" > ~/.gradio/data/tmp/currentsong.txt
			fi

			echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
			exit 0
			fi
			fi
		cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`				
		#cnlinea=$(($cnlinea+1))
		#echo "cnlinea" $cnlinea
	
		done 
		
		#minfin=`date  +%-M`
		#hfin=`date +%-H`
#		echo "===Dispara CargaComercial====== con minini:" $minini "minfin:" $minfin "hfin:" $hfin
#		. ~/.gradio/bin/cargacomercial.sh &
		echo "=============Fin Comerciales==================="
		fi
		#fi de comerciales

		
		if [[ $iniespaciop = 3 ]]; then
		xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.gradio/data/panel/playfinespacio.sh
		fi
		echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
		echo "+++++++++Fin Reproducción Comerciales++++++++++++++++"


fi

#. ~/.gradio/bin/playmanevt.sh 

#######################################
#####################################################
### PLAY MANUAL EVENTOS .......... INICIO ############################3

modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 1 ]]; then
~/.gradio/bin/gradioauto.sh
fi


modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then

echo "Modo Manual" > ~/.gradio/data/tmp/currentcomercial.txt;
killall -9 panico.sh
killall -9 gmplayer
killall -9 mplayer
killall -9 sleep
killall -9 countdown.sh
killall -9 gradioauto.sh
echo "00:00:00" > ~/.gradio/data/tmp/avance

		cnlineas=`grep -c $ ~/.gradio/data/tmp/eventos-esperalist`

			estadotv=`cat ~/.gradio/data/tmp/tvestado`
			desplazamiento=`cat ~/.gradio/data/tmp/tvdesplazamiento`
			teletexto=`cat ~/.gradio/data/tmp/teletexto`
			if [[ $estadotv = 1 ]]; then
			tvopcion="-fs -geometry $desplazamiento"
			else
			tvopcion=""
			fi
			srt=~/.gradio/data/tmp/teletexto.srt
			color=`cat ~/.gradio/data/tmp/teletexto.color`
			if [[ $estadotv = 1 && $teletexto = 1 ]]; then
			srtopcion="-sub $srt $color "
			else
			srtopcion=""
			fi


		if [ -s ~/.gradio/data/tmp/eventos-esperalist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 


		echo "cnlineas" $cnlineas
		while [ $cnlineas -ge 1 ]; 
		do 
		cline="`sed -n $cnlinea"p" ~/.gradio/data/tmp/eventos-esperalist`" 
		cline1=`sed -n $cnlinea"p" ~/.gradio/data/tmp/eventos-esperalist` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			cline=`echo -e "${cline}"|sed  s/\'//g`
			cline=`echo -e "${cline}"|sed  s/" "/"\\\\ "/g`
					
			randomfile=`sed -n 1p ~/.gradio/data/tmp/eventos-esperalist`
			sed -i "1d" ~/.gradio/data/tmp/eventos-esperalist
			sed -i "1d" ~/.gradio/data/tmp/eventos-esperalistweb
			sed -i "1d" ~/.gradio/data/tmp/eventos-esperalistwebg3
			echo randomfile $randomfile
			nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`

			comini=`date +%s`
			# randomfile se usa para calcular el tiempo del sleep ;)
			echo "$randomfile" > ~/.gradio/data/tmp/currentsong.txt;
			echo "$randomfile" > ~/.gradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb;

			tiempo "$randomfile"
			~/.gradio/bin/countdown.sh &

			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer -volume 100 $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo $srtopcion -slave -input file=~/.gradio/data/tmp/slave.txt  "$randomfile"  > /dev/null 2>&1 &


			previo="$comercial"

			#sed -i "1d" ~/.gradio/data/tmp/eventos-esperalist
			cnlineas=`grep -c $ ~/.gradio/data/tmp/eventos-esperalist`
			fundidocom=`cat ~/.gradio/data/tmp/fundidocomerciales`
			esperat=$((segundos-$fundidocom))
			#echo "esperat" $esperat
			sleep $esperat

			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))
						if [ -s ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

			esperacom=`cat ~/.gradio/data/tmp/stopcomercial`
			
			if [[ $esperacom = 1 ]]; then
			if [[ $espera = 1 ]]; then
			echo "Detenido...... Presione Play para pasar a modo automático" > ~/.gradio/data/tmp/currentsong.txt
			fi
			echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
			if [[ $modo = 0 ]]; then
			echo "Modo Manual...... Presione *Manual* para pasar a modo automático" > ~/.gradio/data/tmp/currentsong.txt
			fi

			exit 0
			fi

		cnlineas=`grep -c $ ~/.gradio/data/tmp/eventos-esperalist`				
		#cnlinea=$(($cnlinea+1))
		echo "cnlineas" $cnlineas
	
		done 
		
		#minfin=`date  +%-M`
		#hfin=`date +%-H`
#		echo "===Dispara CargaComercial====== con minini:" $minini "minfin:" $minfin "hfin:" $hfin
#		. ~/.gradio/bin/cargacomercial.sh &
		echo "=============Fin Comerciales==================="
		fi
		#fi de comerciales


		echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
		echo "+++++++++Fin Reproducción Comerciales++++++++++++++++"


fi
################################### FIN EVENTOS #####################################


echo "Modo Manual" > ~/.gradio/data/tmp/currentsong.txt;
echo "00:00:00" > ~/.gradio/data/tmp/avance
modo=`cat ~/.gradio/data/tmp/modo`

if [[ $modo = 1 ]]; then
~/.gradio/bin/gradioauto.sh
fi


################################### FIN COMERCIALES #####################################
