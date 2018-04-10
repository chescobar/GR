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
 
 
 
opcion=`/usr/bin/zenity --title="G Radio -v:alfalfa" --width=400 --height=350 \
                         --text="Seleccione la acción" \
                         --list --column="Seleccionar" --column="Acción" \
			 --checklist FALSE "Ejecutar G Radio" FALSE "Detener G Radio" FALSE "Programar Comerciales" FALSE "Borrar Comerciales" FALSE "Programar Parrilla de Programación" FALSE "Abrir Panel de Efectos" FALSE "Reporte de audios emitidos" FALSE "Reporte de pautaje de comerciales" FALSE "Reporte de parrilla programada"`
 
 
if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "Ejecutar G Radio" ];
                     then 			
		      ~/.gradio/bin/gradio.sh 
               elif [ "$opcion" = "Detener G Radio" ]
                     then
			zenity --question --text "Esta seguro que quiere cerrar Gradio"; echo $?
		if [ $? = 0 ]; then
                      kill -9 `cat ~/.gradio/data/pid`
		      killall -9 smplayer
		      ~/.gradio/bin/gradio-gui.sh
		fi

	      elif [ "$opcion" = "Programar Comerciales" ]
                     then
                      ~/.gradio/bin/comercial.sh

                   
               elif [ "$opcion" = "Borrar Comerciales" ]
                     then
                      ~/.gradio/bin/comercialborrar.sh


              elif [ "$opcion" = "Programar Parrilla de Programación" ]
                     then
                     ~/.gradio/bin/parrilla.sh
                     
              elif [ "$opcion" = "Abrir Panel de Efectos" ]
                     then
		      ~/.gradio/bin/gradio-gui.sh &                     
		      ~/.gradio/bin/panel.sh & 
		                

	      elif [ "$opcion" = "Reporte de audios emitidos" ]
                     then
                     ~/.gradio/bin/reporte.sh               

	      elif [ "$opcion" = "Reporte de pautaje de comerciales" ]
                     then
                     ~/.gradio/bin/reportepautaje.sh 

	      elif [ "$opcion" = "Reporte de parrilla programada" ]
                     then
                     ~/.gradio/bin/reporteparrilla.sh 

               fi

        done
        IFS=""    
fi

