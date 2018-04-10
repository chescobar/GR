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
limite=60
if [[ $previo = "ON" ]]; then
echo 	"OFF"  > ~/.gradio/data/tmp/volumenbajo



for i in `seq 1 $limite`;
        do
                amixer set Master 1%+
                amixer -D pulse sset Master 1%+
        done    


else
echo 	"ON"  > ~/.gradio/data/tmp/volumenbajo

for i in `seq 1 $limite`;
        do
                amixer set Master 1%-
                amixer -D pulse sset Master 1%-
        done  
fi
exit 0
