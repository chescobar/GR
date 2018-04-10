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
 
#Reporte de Emisiones

# Establece el editor a usar
if [ -f /usr/bin/pluma ]
then
        EDITOR="pluma"
else
        if [ -f /usr/bin/leafpad ]
        then
                EDITOR="leafpad"
        else
		if [ -f /usr/bin/mousepad ]
		then
		        EDITOR="mousepad"
		else
                EDITOR="gedit"
		fi
        fi
fi

	opcion=`/usr/bin/zenity --title="Reporte de emisiones G Radio" --width=400 --height=300 \
                         --text="Puede emitir reportes de comerciales ó de la parrilla" \
                         --list --column="Reporte" --column="Seleccione" \
                         --radiolist TRUE "Comerciales" FALSE "Parrilla" `

if [ $? -eq 0 ]; then
	 
	Y=`date +%Y`
	YP=$(($Y-1))
	YN=$(($Y+1)) 
	anio=`/usr/bin/zenity --title="Reporte de emisiones G Radio" --width=400 --height=200 \
		                 --text="Selecciones el o los años" \
		                 --list --column="Reporte" --column="Seleccione" \
				 --multiple \
		                 --checklist FALSE "$YP" TRUE "$Y" FALSE "$YN" `


				if [ $? -eq 0 ]
				then
					IFS="|"
					for anio in $anio
					do
						if [ "$anio" = $YP ];
						     then 
						     A[0]=$YP

						elif [ "$anio" = $Y ];
						     then 
						     A[1]=$Y

						elif [ "$anio" = $YN ];
						     then 
						     A[2]=$YN		
					       fi
					done
				else
				exit 0
				fi
	###
	mes=`/usr/bin/zenity --title="Reporte de emisiones G Radio" --width=400 --height=450 \
		                 --text="Ingrese el o los meses" \
		                 --list --column="Puede Seleccionar mas de un rango" --column="Rango de Hora" \
		                 --multiple \
				 --checklist FALSE "Enero" FALSE "Febrero" FALSE "Marzo" FALSE "Abril" FALSE "Mayo" FALSE "Junio" FALSE "Julio" FALSE "Agosto" FALSE "Septiembre" FALSE "Octubre" FALSE "Noviembre" FALSE "Diciembre" `
	 
	 
	if [ $? -eq 0 ]
	then
		IFS="|"
		for mes in $mes
		do
		       if [ "$mes" = "Enero" ];
		             then 
		              rango[1]=01
		       elif [ "$mes" = "Febrero" ]
		             then
		              rango[2]=02
		      
		       elif [ "$mes" = "Marzo" ]
		             then
		              rango[3]=03
	 
		       elif [ "$mes" = "Abril" ]
		             then
		              rango[4]=04

		       elif [ "$mes" = "Mayo" ]
		             then
		              rango[5]=05

		       elif [ "$mes" = "Junio" ]
		             then
		              rango[6]=06

		       elif [ "$mes" = "Julio" ]
		             then
		              rango[7]=07

		       elif [ "$mes" = "Agosto" ]
		             then
		              rango[8]=08

		       elif [ "$mes" = "Septiembre" ]
		             then
		              rango[9]=09

		       elif [ "$mes" = "Octubre" ]
		             then
		              rango[10]=10

		       elif [ "$mes" = "Noviembre" ]
		             then
		              rango[11]=11

		       elif [ "$mes" = "Diciembre" ]
		             then
		              rango[12]=12              

		       fi
		done
		IFS=""	
	else
	exit 0       
	fi
	###

#Reporte de comerciales 
if [ $opcion = Comerciales ]; then
buscar=`zenity --entry --text="Introduzca parte del nombre del comercial a buscar" --title="Reporte de comerciales"`
###
#Generación del archivo comerciales.txt
#2014-16-08-19:29, /home/cescobar/G Radio/comerciales/GPN/GADPN - PROGRAMACION FERIA CACAO.mp3, 69 segundos
archivo=~/.gradio/data/reportes/reporte-`date +%Y-%h-%Hh%Mm.txt`
touch $archivo 
ii=0
while [ $ii -le 2 ]; do
jj=1
while [ $jj -le 12 ]; do

if [[ "${A[$ii]}" != "" && "${rango[$jj]}" != "" ]]; then
echo "====================  Reporte del Mes" ${rango[$jj]} "=====================" >> $archivo
echo "" >> $archivo
fi
diames=1
while [ $diames -le 31 ]; do
echo "A($ii)" ${A[$ii]} "rango($jj)" ${rango[$jj]}
if [[ "${A[$ii]}" != "" && "${rango[$jj]}" != "" ]]; then
if [[ $diames -lt 10 ]]; then 
diames=`echo $diames|sed  s/^/0/g`
fi
echo "Fecha:"  ${A[$ii]}"-"${rango[$jj]}"-"$diames   >> $archivo
filtro=${A[$ii]}-$diames-${rango[$jj]}-
grep -h -i "$buscar" ~/.gradio/data/reporte/comercial-${A[$ii]}-$diames-${rango[$jj]}.txt|sed  s/"$filtro"//g >> $archivo
echo "" >> $archivo
echo "" >> $archivo
fi
diames=`echo $diames|sed  s/^0//g`
diames=$(($diames+1))
done
jj=$(($jj+1))
done
ii=$(($ii+1))
done
$EDITOR $archivo		
fi 

#Reporte de parrilla 
if [ $opcion = Parrilla ]; then
buscar=`zenity --entry --text="Introduzca parte del nombre del audio de la parrilla a buscar" --title="Reporte de parrilla"`
###
#Generación del archivo parrilla-emitida.txt
archivo=~/.gradio/data/reporte/parrilla-emitida-`date +%Y-%h-%Hh%Mm.txt`
touch $archivo
ii=0
while [ $ii -le 2 ]; do
jj=1
while [ $jj -le 12 ]; do
grep -h -i "$buscar" ~/.gradio/data/reporte/parrilla-${A[$ii]}-??-${rango[$jj]}.txt >> $archivo
jj=$(($jj+1))
done
ii=$(($ii+1))
done
$EDITOR $archivo		
fi 
#~/.gradio/bin/gradio-gui.sh

else
exit 0
fi

