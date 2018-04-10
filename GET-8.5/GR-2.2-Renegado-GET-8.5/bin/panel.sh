#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 20-Ene-2012		    #
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

#Interfaz gráfica para G radio
 
opcion=`/usr/bin/zenity --title="G Radio" --width=210 --height=350 \
                         --text="Panel de Efectos" \
                         --list --column="Selección" --column="Reproducir" \
                         --checklist FALSE "Efecto 1" FALSE "Efecto 2" FALSE "Efecto 3" FALSE "Efecto 4" FALSE "Efecto 5" FALSE "Efecto 6" FALSE "Efecto 7" FALSE "Efecto 8" FALSE "Efecto 9" FALSE "Efecto 10" FALSE "Reproducir Hora" FALSE "Programar Efectos" `
 
 
if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "Efecto 1" ];
                     then 
                      ~/.gradio/data/panel/efecto1.sh &			
               elif [ "$opcion" = "Efecto 2" ]
                     then
                      ~/.gradio/data/panel/efecto2.sh &                   
               elif [ "$opcion" = "Efecto 3" ]
                     then
                      ~/.gradio/data/panel/efecto3.sh &
               elif [ "$opcion" = "Efecto 4" ]
                     then
                      ~/.gradio/data/panel/efecto4.sh &
               elif [ "$opcion" = "Efecto 5" ]
                     then
                      ~/.gradio/data/panel/efecto5.sh &
               elif [ "$opcion" = "Efecto 6" ]
                     then
                      ~/.gradio/data/panel/efecto6.sh &
               elif [ "$opcion" = "Efecto 7" ]
                     then
                      ~/.gradio/data/panel/efecto7.sh &
               elif [ "$opcion" = "Efecto 8" ]
                     then
                      ~/.gradio/data/panel/efecto8.sh &
               elif [ "$opcion" = "Efecto 9" ]
                     then
                      ~/.gradio/data/panel/efecto9.sh &
               elif [ "$opcion" = "Efecto 10" ]
                     then
                      ~/.gradio/data/panel/efecto10.sh &
               elif [ "$opcion" = "Reproducir Hora" ]
                     then
                      ~/.gradio/data/panel/hora.sh &
               elif [ "$opcion" = "Programar Efectos" ]
                     then
                      ~/.gradio/bin/panelprogramar.sh &
               fi
        done
        IFS=""
~/.gradio/bin/panel.sh &       
fi
