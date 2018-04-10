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
previo=`cat  ~/.gradio/data/tmp/volumenbajo`
if [[ $previo = "ON" ]]; then
echo 	"OFF"  > ~/.gradio/data/tmp/volumenbajo
amixer set Master 50%
amixer set Master 55%
amixer set Master 60%
amixer set Master 65%
amixer set Master 70%
amixer set Master 75%
amixer set Master 80%
amixer set Master 85%
amixer set Master 90%
amixer set Master 95%
amixer set Master 100%
else
echo 	"ON"  > ~/.gradio/data/tmp/volumenbajo
amixer set Master 99%
amixer set Master 98%
amixer set Master 97%
amixer set Master 96%
amixer set Master 95%
amixer set Master 94%
amixer set Master 93%
amixer set Master 92%
amixer set Master 91%
amixer set Master 90%
amixer set Master 88%
amixer set Master 85%
amixer set Master 83%
amixer set Master 75%
amixer set Master 70%
amixer set Master 65%
amixer set Master 60%
amixer set Master 55%
amixer set Master 50%
fi
exit 0
