#!/bin/bash
#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 23-Jun-2011		    #
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
mix=`zenity --list --title="Menu" --text="Tiempo de Mezcla" --column="Segundos" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"`

if [ "${mix:-NULL}" != "NULL" ]; then
#if [[ "$mix" != "" ]]; then
echo $mix > ~/.gradio/data/mix.txt
fi
