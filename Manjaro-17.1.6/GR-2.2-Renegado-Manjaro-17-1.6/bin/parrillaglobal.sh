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

#Programar la parrilla de música por horas

if [[ -s ~/.gradio/bin/GR_Parrilla_Global.gambas ]]; then

~/.gradio/bin/GR_Parrilla_Global.gambas

else

opcion=`/usr/bin/zenity --title="Creación de Parrilla G Radio" --width=400 --height=300 \
                         --text="Seleccione el día" \
                         --list --column="Puede seleccionar mas de un día" --column="Día" \
			 --multiple \
                         --checklist FALSE "Lunes" FALSE "Martes" FALSE "Miércoles" FALSE "Jueves" FALSE "Viernes" FALSE "Sábado" FALSE "Domingo" `
 
 
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
                      dia[2]=1
              elif [ "$opcion" = "Miércoles" ]
                     then
                      dia[3]=1
                     
             elif [ "$opcion" = "Jueves" ]
                     then
                      dia[4]=1

	     elif [ "$opcion" = "Viernes" ]
                     then
                      dia[5]=1

	     elif [ "$opcion" = "Sábado" ]
                     then
                      dia[6]=1
 
	     elif [ "$opcion" = "Domingo" ]
                     then
                      dia[7]=1
 
 
               fi
        done
        IFS=""
else	
exit
       
fi

opcion=`/usr/bin/zenity --title="Creación de Parrilla G Radio" --width=400 --height=600 \
                         --text="Seleccione el rango de la hora" \
                         --list --column="Puede Seleccionar mas de un rango" --column="Rango de Hora" \
                         --multiple \
			 --checklist FALSE "00-01" FALSE "01-02" FALSE "02-03" FALSE "03-04" FALSE "04-05" FALSE "05-06" FALSE "06-07" FALSE "07-08" FALSE "08-09" FALSE "09-10" FALSE "10-11" FALSE "11-12" FALSE "12-13" FALSE "13-14" FALSE "14-15" FALSE "15-16" FALSE "16-17" FALSE "17-18" FALSE "18-19" FALSE "19-20" FALSE "20-21" FALSE "21-22" FALSE "22-23" FALSE "23-24" `
 
 
if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "00-01" ];
                     then 
                      rango[0]=1
               elif [ "$opcion" = "01-02" ]
                     then
                      rango[1]=1
              
               elif [ "$opcion" = "02-03" ]
                     then
                      rango[2]=1
 
               elif [ "$opcion" = "03-04" ]
                     then
                      rango[3]=1

               elif [ "$opcion" = "04-05" ]
                     then
                      rango[4]=1

               elif [ "$opcion" = "05-06" ]
                     then
                      rango[5]=1

               elif [ "$opcion" = "06-07" ]
                     then
                      rango[6]=1

               elif [ "$opcion" = "07-08" ]
                     then
                      rango[7]=1

               elif [ "$opcion" = "08-09" ]
                     then
                      rango[8]=1

               elif [ "$opcion" = "09-10" ]
                     then
                      rango[9]=1

               elif [ "$opcion" = "10-11" ]
                     then
                      rango[10]=1

               elif [ "$opcion" = "11-12" ]
                     then
                      rango[11]=1

               elif [ "$opcion" = "12-13" ]
                     then
                      rango[12]=1

               elif [ "$opcion" = "13-14" ]
                     then
                      rango[13]=1
               
               elif [ "$opcion" = "14-15" ]
                     then
                      rango[14]=1

               elif [ "$opcion" = "15-16" ]
                     then
                      rango[15]=1

               elif [ "$opcion" = "16-17" ]
                     then
                      rango[16]=1

               elif [ "$opcion" = "17-18" ]
                     then
                      rango[17]=1

               elif [ "$opcion" = "18-19" ]
                     then
                      rango[18]=1

               elif [ "$opcion" = "19-20" ]
                     then
                      rango[19]=1

               elif [ "$opcion" = "20-21" ]
                     then
                      rango[20]=1

               elif [ "$opcion" = "21-22" ]
                     then
                      rango[21]=1

               elif [ "$opcion" = "22-23" ]
                     then
                      rango[22]=1

               elif [ "$opcion" = "23-24" ]
                     then
                      rango[23]=1

               fi
        done
        IFS=""
    
else
exit
fi

listo=0
         while [  $listo -ne 1000 ]; do

usuario=`whoami`

       dir=`zenity --filename=/home/$usuario/G\ Radio/musica/ --file-selection --directory --title="Seleccione una Carpeta de audios para reproducir aleatoriamente"` 

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
else
exit
fi
################

######

			#Insertar hora
				hora=`/usr/bin/zenity --title="Creación de Parrilla G Radio" --width=200 --height=200 \
						 --text="Desea insertar reproducción de hora?" \
						 --list --column="Seleccionar" --column="Marque la casilla" \
						 --checklist FALSE "Si" FALSE "No" `

			if [ $? -eq 0 ]
			then
				IFS="|"
				for hora in $hora
				do
				       if [ "$hora" = "Si" ];
					     then 
					     echo Hora Seleccionada

				       elif [ "$hora" = "No" ];
					     then 
					     echo Hora No seleccionada

		
				       fi
				done
			else
			exit
			fi
			
			#Fin insertar hora
					
######


i=1
			 while [  $i -le 7 ]; do
			     #echo i $i

		j=0
				 while [  $j -le 23 ]; do
				     #echo j $j

					if [[ ${dia[$i]} -eq "1" ]]; then
						if [[  ${rango[$j]} -eq "1" ]]; then
						rangoc=$j-$(($j+1))
						echo dia $i rango $rangoc horazenity $hora

							if [ $listo = 0 ]; then
								echo $dir"/*" > ~/.gradio/data/parrilla/$i/$rangoc.mus		
							   else
								echo $dir"/*" >> ~/.gradio/data/parrilla/$i/$rangoc.mus
							fi
							
							if [ $hora = "Si" ]; then
								echo Hora >> ~/.gradio/data/parrilla/$i/$rangoc.mus
							fi

							cat ~/.gradio/data/parrilla/$i/$rangoc.mus
######

						fi
					fi
					j=$(($j+1))				
				done
		
			     i=$(($i+1)) 
			 done
			 hora=No


################
	
		




		cat ~/.gradio/data/parrilla/$dia/$rango.mus

             echo listo es $listo
             listo=$(($listo+1)) 


	opcion=`/usr/bin/zenity --title="Creación de Parrilla G Radio" --width=400 --height=200 \
                         --text="Termino la creación de la lista?" \
                         --list --column="Seleccionar" --column="Si/No" \
                         --checklist FALSE "Si" FALSE "No" `
 
 
if [ $? -eq 0 ]
then
        IFS="|"
        for opcion in $opcion
        do
               if [ "$opcion" = "Si" ];
                     then 
                      listo=1000
               elif [ "$opcion" = "No" ]
                     then
                      echo "sigue la selección" 
               fi
        done
        IFS=""
else
exit   
fi





         done
fi
#~/.gradio/bin/gradio-gui.sh




