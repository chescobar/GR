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
kill -9 `cat ~/.gradio/data/pid`
espera=`cat ~/.gradio/data/tmp/stop`
if [[ $espera = 1 ]]; then
#		mix=`cat ~/.gradio/data/mix.txt`
#		sleep $mix
		echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
		echo "Detenido despúes del tema, PLAY para iniciar" > ~/.gradio/data/tmp/currentsong.txt;
		echo "00:00:00" > ~/.gradio/data/tmp/avance
else
		echo "Modo Manual" > ~/.gradio/data/tmp/currentcomercial.txt;
		echo "Modo Manual" > ~/.gradio/data/tmp/currentsong.txt;
		echo "00:00:00" > ~/.gradio/data/tmp/avance
fi


killall -9 countdown.sh
killall -9 gradioauto.sh
killall -9 tiempo.sh
killall -9 mplayer
killall -9 gradio.sh
killall -9 cargalista.sh
killall -9 pavumeter
#killall -9 comercialdaemon.sh
killall -9 playmancom.sh
#~/.gradio/bin/fadeout.sh

exit 0
