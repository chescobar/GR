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

modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 0 ]]; then
playingcom=`ps -e |grep playmancom.sh`
if [ "$playingcom" = "" ]; then 
killall -9 gradio.sh
killall -9 gradioauto.sh
killall -9 cargalista.sh
sleep 0.1
~/.gradio/bin/playmus.sh
else
echo "Reproduciendo comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
fi
else
echo "0" >  ~/.gradio/data/tmp/stopcomercial
a=`ps -e |grep gradioauto.sh`
if [ "$a" = "" ]; then 
killall -9 fadeout.sh
killall -9 mplayer
killall -9 countdown.sh
echo "00:00:00" > ~/.gradio/data/tmp/avance
echo "0" > ~/.gradio/data/tmp/stop
~/.gradio/bin/gradioauto.sh &
else
echo "0" > ~/.gradio/data/tmp/repitiendo
echo "0" > ~/.gradio/data/tmp/stop
~/.gradio/bin/siguiente.sh
fi
fi
