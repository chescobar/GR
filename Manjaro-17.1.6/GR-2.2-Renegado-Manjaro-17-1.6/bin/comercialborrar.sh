#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 18-Enero-2011		    #
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

#Borrar comerciales
   #!/bin/sh

usuario=`whoami`

       comborrar=`zenity --filename=/home/$usuario/G\ Radio/comerciales/ --file-selection --title="Seleccione el archivo de audio a ser borrado"` 


#        comborrar=`zenity --file-selection --title="Seleccione el archivo del comercial a borrar"`

#        case $? in
#                 0)
#                        echo "\"$comborrar\" seleccionado.";;
#                 1)
#                        echo "No ha seleccionado ningún archivo.";;
#                -1)
#                        echo "No ha seleccionado ningún archivo.";;
#        esac

if [ $? = 0 ]; then
	comborrar=`echo "$comborrar"|sed s/"\/"/'\\\\\/'/g`
	echo "comborrar" "$comborrar"
	for i in `grep -li "$comborrar" ~/.gradio/data/comerciales/*/*.com`
	do
	sed -i /"$comborrar"/d `echo $i`
	echo "i" $i
	done
fi
#~/.gradio/bin/gradio-gui.sh

