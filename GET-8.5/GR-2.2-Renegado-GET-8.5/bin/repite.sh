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
export DISPLAY=:0
tema=`cat ~/.gradio/data/tmp/repite`
nombrebase=`echo "$tema" |awk -F/ '{print $NF}'`

echo "1" > ~/.gradio/data/tmp/repitiendo
killall -9 repitetmp.sh
#sleep 0.5
killall -9 mplayer 
killall -9 sleep 
killall -9 panico.sh
echo "Repitiendo:--> $nombrebase" > ~/.gradio/data/tmp/currentsong.txt 
#~/.gradio/bin/countdown.sh &
#xterm -iconic  -fg Green -bg Red -title "$tema"  -geometry 40x1-0+0 -e mplayer -volume 100 -slave -input file=~/.gradio/data/tmp/slave.txt "$tema"


xterm -iconic  -fg Green -bg Red -title "$tema"  -geometry 40x1-0+0 -e ~/.gradio/data/tmp/repitetmp.sh
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
		echo "Modo Manual" > ~/.gradio/data/tmp/currentcomercial.txt;
		echo "Modo Manual" > ~/.gradio/data/tmp/currentsong.txt;
		echo "00:00:00" > ~/.gradio/data/tmp/avance
fi
exit 0
