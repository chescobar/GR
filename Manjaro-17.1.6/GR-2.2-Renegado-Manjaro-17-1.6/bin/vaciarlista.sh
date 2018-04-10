#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash         #
#	             Última actualización: 15-Jun-2017                      #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	                    #
#############################################################################
#############################################################################
#                                                                           #
# This program is free software; you can redistribute it and/or modify it   #
# under the terms of the GNU General Public License as published by the     #
# Free Software Foundation; either version 2 of the License or any later    #
# version.                                                                  #
#	                                                                    #
# This program is distributed in the hope that it will useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
# for more details.	                                                    #
#	                                                                    #
############################################################################# 
#cat /dev/null > ~/.gradio/data/tmp/comercialeslist
#Vaciar playlist y Comerciales
cat /dev/null > ~/.gradio/data/tmp/playlistg3
cat /dev/null > ~/.gradio/data/tmp/playlist
cat /dev/null > ~/.gradio/data/tmp/playlistweb
while [ cartucho -le 14 ]; do
cat /dev/null > ~/.gradio/data/tmp/cartucho$cartucho
cartucho=$(($cartucho+1))
done

sed -i "1d" ~/.gradio/data/tmp/playlist
sed -i "1d" ~/.gradio/data/tmp/playlistweb
sed -i "1d" ~/.gradio/data/tmp/playlistg3

sleep 1
~/.gradio/bin/cartucho.sh &
#exit 0
exit 0
