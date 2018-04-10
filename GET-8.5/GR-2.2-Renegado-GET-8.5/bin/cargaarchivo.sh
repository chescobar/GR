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
usuario=`whoami`
yadexiste=`which yad`
if [[ $yadexiste = "" ]]; then
echo "yad no está instalado"
comando="zenity"
else
comando="yad"
centrado="--center"
fi

       archivo=`$comando --width=700 --height=600 $centrado --filename=/home/$usuario/G\ Radio/ --file-selection --title="Seleccione el archivo de audio a ser programado"` 
if [ $? -eq 0 ]
then
        case $? in
                 0)
                        echo "\"$archivo\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
else
exit
fi
nombrebase=`echo "$archivo" |awk -F/ '{print $NF}'`
echo "$archivo" >> ~/.gradio/data/tmp/parrillag3
echo "$nombrebase" >> ~/.gradio/data/tmp/baseparrillag3
