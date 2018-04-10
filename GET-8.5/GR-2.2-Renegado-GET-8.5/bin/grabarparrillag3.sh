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


dia=1
while [[ $dia -le 7 ]]; do
d=`cat ~/.gradio/data/tmp/d$dia`
if [[ $d = 1 ]]; then
	hora=0
	while [[ $hora -le 23 ]]; do
	h=`cat ~/.gradio/data/tmp/$hora`
		if [[ $h = 1 ]]; then
		cp ~/.gradio/data/tmp/parrillag3 ~/.gradio/data/parrilla/$dia/$hora-$(($hora + 1)).mus
		fi
	hora=$(($hora + 1))
	done
fi
dia=$(($dia + 1))
done

#cat /dev/null > ~/.gradio/data/tmp/parrillag3
#sed -i "1d" ~/.gradio/data/tmp/parrillag3
#cat /dev/null > ~/.gradio/data/tmp/baseparrillag3
#sed -i "1d" ~/.gradio/data/tmp/baseparrillag3
killall -9 cargalista.sh
sleep 0.5
~/.gradio/bin/cargalista.sh &
