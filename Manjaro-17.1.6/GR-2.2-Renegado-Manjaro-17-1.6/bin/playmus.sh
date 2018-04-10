#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 28-Jul-2011		    #
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

########################################REPRODUCE PLAYLIST MANUALMENTE

	echo "+++++++++Inicio Reproducción++++++++++++++++"
function tiempo() {
echo "funciontiempo en gradio.sh"
duracion=`mplayer -ao null -identify -frames 0 "$1" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
echo "00:00:$duracion" > ~/.gradio/data/tmp/duracion
echo "duracion" $duracion
				segundos=$duracion
				return $segundos
}

echo "Modo Manual" > ~/.gradio/data/tmp/currentcomercial.txt;
killall -9 panico.sh
killall -9 gmplayer
killall -9 mplayer
killall -9 sleep
killall -9 countdown.sh
killall -9 gradioauto.sh
echo "00:00:00" > ~/.gradio/data/tmp/avance

		cnlineas=`grep -c $ ~/.gradio/data/tmp/playlist`
		if [[ $cnlineas -ge 1 ]]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 

		#while [ $cnlinea -le $cnlineas ]; 
		#do 



		cline="`sed -n $cnlinea"p" ~/.gradio/data/tmp/playlist`" 
		cline1=`sed -n $cnlinea"p" ~/.gradio/data/tmp/playlist` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			cline=`echo -e "${cline}"|sed  s/\'//g`
			cline=`echo -e "${cline}"|sed  s/" "/"\\\\ "/g`
					
			randomfile=`sed -n 1p ~/.gradio/data/tmp/playlist`
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

	if [[ $randomfile = "Hora"  ]];
				then	
					nombrebase="Hora"
					echo "Hora" > ~/.gradio/data/tmp/currentsong.txt 
					echo "Hora" ~/.gradio/data/tmp/currentsongweb
					echo "Hora" ~/CurrenSong.txt
					killall -9 countdown.sh
					echo "Hora" > ~/.gradio/data/tmp/avance
					echo "<font color='red' size='24'><b>Hora</b></font>" > ~/.gradio/data/tmp/avanceweb
						sed -i "1d" ~/.gradio/data/tmp/playlistg3
						echo randomfile $randomfile

					xterm -iconic  -fg Green -bg DarkBlue -title "hora" -geometry 40x1-0+0  -e ~/.gradio/data/panel/hora.sh

						sed -i "1d" ~/.gradio/data/tmp/playlist
						sed -i "1d" ~/.gradio/data/tmp/playlistweb
						desiguiente=0

			else

				logo=`cat ~/.gradio/data/tmp/tvlogo`
				if [[ $estadotv = 1 && $logo = 1 ]]; then
				~/.gradio/bin/logopersiste.sh &
				fi

			sed -i "1d" ~/.gradio/data/tmp/playlist
			sed -i "1d" ~/.gradio/data/tmp/playlistg3
			sed -i "1d" ~/.gradio/data/tmp/playlistweb
			echo randomfile $randomfile
			nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`
			tiempo "$randomfile"
			~/.gradio/bin/countdown.sh &
			~/.gradio/bin/cartucho.sh &

			musini=`date +%s`
			# randomfile se usa para calcular el tiempo del sleep ;)
			echo "$nombrebase" > ~/.gradio/data/tmp/currentsong.txt;
			# echo "$nombrebase" > ~/.gradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb;

						echo $randomfile > ~/.gradio/data/tmp/repite
						echo "#!/bin/bash" > ~/.gradio/data/tmp/repitetmp.sh
						echo "killall -9 countdown.sh" >> ~/.gradio/data/tmp/repitetmp.sh
						echo "~/.gradio/bin/countdown.sh &" >> ~/.gradio/data/tmp/repitetmp.sh
						echo "mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo $srtopcion -af volnorm   \"$randomfile\"" >> ~/.gradio/data/tmp/repitetmp.sh
						echo "sleep 0.5" >> ~/.gradio/data/tmp/repitetmp.sh
						echo "echo "0" > ~/.gradio/data/tmp/repitiendo" >> ~/.gradio/data/tmp/repitetmp.sh



						chmod 755 ~/.gradio/data/tmp/repitetmp.sh


				xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer $tvopcion -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo $srtopcion -af volnorm -slave  -input file=~/.gradio/data/tmp/slave.txt  "$randomfile" 
				
			musfin=`date +%s`
			duracion=$(( $musfin - $musini ))
						if [ -s ~/.gradio/data/reporte/parrilla-`date +%Y-%d-%m` ]; then
						touch ~/.gradio/data/reporte/parrilla-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.gradio/data/reporte/parrilla-`date +%Y-%d-%m`.txt #Reporte parrilla


		fi
	fi
		

		echo "Modo Manual" > ~/.gradio/data/tmp/currentcomercial.txt;
		echo "Modo Manual" > ~/.gradio/data/tmp/currentsong.txt;
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 1 ]]; then
~/.gradio/bin/gradioauto.sh
fi


################################### FIN PLAYLIST #####################################
