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
~/.gradio/bin/detenermanual.sh
else
echo "1" > ~/.gradio/data/tmp/stop
echo "Reproduccipon detenida..Play para iniciar" > ~/.gradio/data/tmp/currentcomercial.txt
#~/.gradio/bin/fadeout.sh
killall -9 pisador.sh
~/.gradio/bin/detenermanual.sh
fi
exit 0


