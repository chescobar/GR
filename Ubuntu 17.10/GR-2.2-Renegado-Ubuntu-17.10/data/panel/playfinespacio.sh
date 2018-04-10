#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#	  Última actualización: 28-Jul-2011    #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	        #
#############################################################################
#############################################################################
#                                                                           #
# This program is free software; you can redistribute it and/or modify it   #
# under the terms of the GNU General Public License as published by the     #
# Free Software Foundation; either version 2 of the License or any later    #
# version.    #
#	    #
# This program is distributed in the hope that it will useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
# for more details.	    #
#	    #
############################################################################# 

function tiempo() {
echo "funciontiempo en gradio.sh"
duracion=`mplayer -ao null -identify -frames 0 "$1" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
echo "00:00:$duracion" > ~/.gradio/data/tmp/duracion
echo "duracion" $duracion
				segundos=$duracion
				return $segundos
}

estadotv=`cat ~/.gradio/data/tmp/tvestado`
desplazamiento=`cat ~/.gradio/data/tmp/tvdesplazamiento`
if [[ $estadotv = 1 ]]; then
tvopcion="-fs -geometry $desplazamiento"
fi
					echo "Fin Publi" > ~/.gradio/data/tmp/avance
					echo "<font color='red' size='24'><b>Fin Publicidad</b></font>" > ~/.gradio/data/tmp/avanceweb
salidaespacio=`ls ~/G\ Radio/fin-espacio-pub/`
tiempo ~/G\ Radio/fin-espacio-pub/"$salidaespacio"
fundido=`cat ~/.gradio/data/tmp/fundidocomout`
mplayer $tvopcion -af volnorm ~/G\ Radio/fin-espacio-pub/"$salidaespacio" > /dev/null 2>&1 &
#espera=$(($segundos-$fundido))
espera=$segundos
echo espera $espera
sleep $espera
exit 0
