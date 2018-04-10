#!/bin/bash 
#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 18-Ene-2012		    #
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

if [[ -s ~/.gradio/bin/GR_Comercial.gambas ]]; then
	~/.gradio/bin/GR_Comercial.gambas
else

		listo=0
		#         while [  $listo -ne 1000 ]; do

		#Encera variables
		iii=0
		while [ $iii  -le 59 ]; do
		dia[$iii]=0
		hr[$iii]=0
		mn[$iii]=0
		iii=$(($iii+1))
		done
		  

		#Para programar comerciales con fecha inicio fin -- pendiente
		pautaini=$(zenity --calendar --title="Fecha de inicio de pautaje" --date-format=%Y%m%d)
		if [ $? -ne 0 ]
		then
		exit
		fi

		echo $pautaini


		#echo $inicio

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

		opcion=`/usr/bin/zenity --title="Programación de Comerciales G Radio" --width=400 --height=600 \
				         --text="Seleccione las horas" \
				         --list --column="Seleccionar" --column="Rango de Hora" \
				         --checklist --multiple FALSE "00" FALSE "01" FALSE "02" FALSE "03" FALSE "04" FALSE "05" FALSE "06" FALSE "07" FALSE "08" FALSE "09" FALSE "10" FALSE "11" FALSE "12" FALSE "13" FALSE "14" FALSE "15" FALSE "16" FALSE "17" FALSE "18" FALSE "19" FALSE "20" FALSE "21" FALSE "22" FALSE "23" `
		 



		if [ $? -eq 0 ]
		then
			IFS="|"
			for opcion in $opcion
			do
			       if [ "$opcion" = "00" ];
				     then 
				      hr[0]=1
			       elif [ "$opcion" = "01" ]
				     then
				      hr[1]=1
			      
			       elif [ "$opcion" = "02" ]
				     then
				      hr[2]=1
		 
			       elif [ "$opcion" = "03" ]
				     then
				      hr[3]=1

			       elif [ "$opcion" = "04" ]
				     then
				      hr[4]=1

			       elif [ "$opcion" = "05" ]
				     then
				      hr[5]=1


			       elif [ "$opcion" = "06" ]
				     then
				      hr[6]=1


			       elif [ "$opcion" = "07" ]
				     then
				      hr[7]=1


			       elif [ "$opcion" = "08" ]
				     then
				      hr[8]=1


			       elif [ "$opcion" = "09" ]
				     then
				      hr[9]=1


			       elif [ "$opcion" = "10" ]
				     then
				      hr[10]=1


			       elif [ "$opcion" = "11" ]
				     then
				      hr[11]=1


			       elif [ "$opcion" = "12" ]
				     then
				      hr[12]=1


			       elif [ "$opcion" = "13" ]
				     then
				      hr[13]=1


			       elif [ "$opcion" = "14" ]
				     then
				      hr[14]=1


			       elif [ "$opcion" = "15" ]
				     then
				      hr[15]=1


			       elif [ "$opcion" = "16" ]
				     then
				      hr[16]=1


			       elif [ "$opcion" = "17" ]
				     then
				      hr[17]=1


			       elif [ "$opcion" = "18" ]
				     then
				      hr[18]=1


			       elif [ "$opcion" = "19" ]
				     then
				      hr[19]=1


			       elif [ "$opcion" = "20" ]
				     then
				      hr[20]=1


			       elif [ "$opcion" = "21" ]
				     then
				      hr[21]=1


			       elif [ "$opcion" = "22" ]
				     then
				      hr[22]=1


			       elif [ "$opcion" = "23" ]
				     then
				      hr[23]=1



			       fi
			done
			IFS=" "
		else
		exit      
		fi

		opcion=`/usr/bin/zenity --title="Programación de Comerciales G Radio" --width=400 --height=600 \
				         --text="Seleccione los minutos" \
				         --list --column="Seleccionar" --column="Minuto de reproducción" \
				         --checklist --multiple FALSE "00" FALSE "05" FALSE "10" FALSE "15" FALSE "20" FALSE "25" FALSE "30" FALSE "35" FALSE "40" FALSE "45" FALSE "50" FALSE "55" `
		 
		 
		if [ $? -eq 0 ]
		then
			IFS="|"
			for opcion in $opcion
			do
			       if [ "$opcion" = "00" ];
				     then 
				      mn[0]=1
			       elif [ "$opcion" = "05" ]
				     then
				      mn[5]=1
			      
			       elif [ "$opcion" = "10" ]
				     then
				      mn[10]=1
		 
			       elif [ "$opcion" = "15" ]
				     then
				      mn[15]=1

			       elif [ "$opcion" = "20" ]
				     then
				      mn[20]=1

			       elif [ "$opcion" = "25" ]
				     then
				      mn[25]=1


			       elif [ "$opcion" = "30" ]
				     then
				      mn[30]=1


			       elif [ "$opcion" = "35" ]
				     then
				      mn[35]=1


			       elif [ "$opcion" = "40" ]
				     then
				      mn[40]=1

			       elif [ "$opcion" = "45" ]
				     then
				      mn[45]=1

			       elif [ "$opcion" = "50" ]
				     then
				      mn[50]=1

			       elif [ "$opcion" = "55" ]
				     then
				      mn[55]=1

			       fi
			done
			IFS=" "
		else
		exit       
		fi



		usuario=`whoami`

		       comercial=`zenity --filename=/home/$usuario/G\ Radio/comerciales/ --file-selection --title="Seleccione el archivo de audio a ser programado"` 

		if [ $? -eq 0 ]
		then
			case $? in
				 0)
				        echo "\"$comercial\" seleccionado.";;
				 1)
				        echo "No ha seleccionado ningún archivo.";;
				-1)
				        echo "No ha seleccionado ningún archivo.";;
			esac
		#########################

			i=0
				 while [  $i -le 23 ]; do     

			j=0
				 while [  $j -le 55 ]; do				     

		#		hora=${hr[$i]}
					if [[ ${hr[$i]} -eq "1" ]]; then
		#		minuto=${mn[$j]}
						if [[  ${mn[$j]} -eq "1" ]]; then

							vacio=1
							if [ -s ~/.gradio/data/comerciales/$i/$j.com ]; then
							vacio=0
							fi
				
							if [ $vacio = 1 ]; then
							echo "$comercial""|"$diasemite"|"$pautaini"|"$pautafin > ~/.gradio/data/comerciales/$i/$j.com
							echo primera linea
							else
							echo "$comercial""|"$diasemite"|"$pautaini"|"$pautafin >> ~/.gradio/data/comerciales/$i/$j.com
							echo segunda linea
							fi
						#sed '/^$/d' ~/.gradio/data/comerciales/$i/$j.com > ~/.gradio/data/comerciales/$i/$j.com
						echo $comercial
						fi
					fi
					j=$(($j+5))				
				done
	
				     i=$(($i+1)) 
				 done


		
			     
		echo listo es $listo
			     listo=$(($listo+1)) 

		else
		exit       
		fi

		#opcion=`/usr/bin/zenity --title="Programación de Comerciales G Radio" --width=400 --height=200 \
		#                         --text="Termino la programación de comerciales?" \
		#                         --list --column="Seleccionar" --column="Si/No" \
		#                         --checklist FALSE "Si" FALSE "No" `
		 
		 
		#if [ $? -eq 0 ]
		#then
		#        IFS="|"
		#        for opcion in $opcion
		#        do
		#               if [ "$opcion" = "Si" ];
		#                     then 
		#                      listo=1000		      
		#               elif [ "$opcion" = "No" ]
		#                     then
		#                      echo "sigue la selección" 
		#               fi
		#        done
			IFS=" "
		#else
		#exit       
		#fi
		#         done
		#~/.gradio/bin/gradio-gui.sh
fi
exit 0

