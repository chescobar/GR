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
usuario=`whoami`
yadexiste=`which yad`
if [ "$yadexiste" = "" ]; then
echo "yad no está instalado"
comando="zenity"
else
comando="yad"
centrado="--center"
fi
tema=`$comando --width=700 --height=600 $centrado --filename="/home/$usuario/G Radio/comerciales/" --file-selection --title="Seleccione el archivo de audio a ser programado como comercial"` 

        case $? in
                 0)
                        echo "\"$tema\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
		
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
comercialeslist=$((`grep -c $ ~/.gradio/data/tmp/comercialeslist`*1))
		duracion=`mplayer -ao null -identify -frames 0 "$tema" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'``
		duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))

extension="${tema##*.}"
validado=`grep -i $extension ~/.gradio/data/extensiones`
if [ "$validado" != "" ]; then
comercialeslist=$((`grep -c $ ~/.gradio/data/tmp/comercialeslist`*1))
nombrebase=`echo "$tema" |awk -F/ '{print $NF}'`
echo comercialeslist: $comercialeslist
	echo "$tema" >> ~/.gradio/data/tmp/comercialeslist
	echo "$nombrebase" "[""$duracionview""]" >> ~/.gradio/data/tmp/comercialeslistwebg3
	echo "<font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" ~/.gradio/data/tmp/comercialeslistweb
fi
