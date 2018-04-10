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
panico=0 
while [[ $panico -lt $mezcla ]]; do
#	echo "panico" $panico "mezcla" $mezcla
	a=`ps -e |grep mplayer`
	verifica=0
	verificado=0
	if [ "$a" = "" ]; then 
		while [[ $verfica -le 4 ]]; do
		sleep 1
		a=`ps -e |grep mplayer`
			if [ "$a" = "" ]; then
			verificado=$(($verificado+1))
			echo "panico verifica" $verificado
				if [ $verificado = 4 ]; then
				~/.gradio/bin/siguiente.sh
				echo "entró en pánico a las" `date`
				panico=0
				exit 0
				fi
			fi
		verifica=$(($verifica+1))
		done
		
	fi
	sleep 4
	panico=$(($panico+4))
done
panico=0
exit 0
