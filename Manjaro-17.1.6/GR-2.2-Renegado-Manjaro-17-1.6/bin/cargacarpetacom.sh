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

pautaini=$(zenity --calendar --title="Fecha de inicio de pautaje" --date-format=%Y%m%d)
if [ $? -ne 0 ]
then
exit
fi

echo $pautaini

pautafin=$(zenity --calendar --title="Fecha de fin de pautaje" --date-format=%Y%m%d)
if [ $? -ne 0 ]
then
exit
fi
echo $pautafin



##########################

opcion=`/usr/bin/zenity --title="Programación de Comerciales G Radio" --width=400 --height=300 \
                         --text="Seleccione los día" \
                         --list --column="Seleccionar" --column="Día" \
			 --checklist --multiple  TRUE "Lunes" TRUE "Martes" TRUE "Miércoles" TRUE "Jueves" TRUE "Viernes" TRUE "Sábado" TRUE "Domingo" `
 


if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "Lunes" ];
                     then 
                      dia[1]=1
               elif [ "$opcion" = "Martes" ]
                     then
                      dia[2]=2
              elif [ "$opcion" = "Miércoles" ]
                     then
                      dia[3]=3
                     
             elif [ "$opcion" = "Jueves" ]
                     then
                      dia[4]=4

	     elif [ "$opcion" = "Viernes" ]
                     then
                      dia[5]=5

	     elif [ "$opcion" = "Sábado" ]
                     then
                      dia[6]=6
 
	     elif [ "$opcion" = "Domingo" ]
                     then
                      dia[7]=7
 
 
               fi
        done
        IFS=" "
else
exit       
fi
diasemite=${dia[1]}${dia[2]}${dia[3]}${dia[4]}${dia[5]}${dia[6]}${dia[7]}
echo $diasemite

usuario=`whoami`
	dir=`zenity --filename=/home/$usuario/G\ Radio/comerciales/ --file-selection --directory --title="Seleccione una Carpeta de comerciales para reproducir aleatoriamente"`

if [ $? -eq 0 ]
then
        case $? in
                 0)
                        echo "\"$dir\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
echo "$dir""|""$diasemite""|""$pautaini""|""$pautafin" > ~/.gradio/data/tmp/comercialg3    
else
exit
fi
exit 0
