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
a=`ps uax|grep -v grep|grep GMain.gambas`
if [ "$a" = "" ]; then 
~/.gradio/bin/detener.sh
~/.gradio/bin/GMain.gambas &
else
	accion=`/usr/bin/zenity --title="GRadio aparece como abierto, por favor revise sus pantallas" --width=400 --height=200 \
                         --text="GRadio aparece como abierto, por favor revise sus ventanas" \
                         --list --column="Seleccione" --column="Ejecutar" \
                         --radiolist TRUE "Si se ha estado ejecutando no hacer nada" FALSE "Parece colgado, resetear el programa" `

	if [ $? -eq 0 ]; then
		if [[ $accion = "Parece colgado, resetear el programa" ]]; then
		killall -9 GMain.gambas 
		killall -9 gbr3
		~/.gradio/bin/detener.sh
		~/.gradio/bin/GMain.gambas &
		fi
	else
	exit 0
	fi
fi
