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
#Comerciales 
#Borrar los Comerciales caducados para depurar la matriz de comerciales

echo "Borrar Comerciales Caducados"

hora=0
while [ $hora -le 23 ]
do
minuto=0
while [ $minuto -le 59 ]
do
#echo "hora:" $hora;
#echo "minuto:" $minuto;
		if [ -s ~/.gradio/data/comerciales/$hora/$minuto.com ]; then
		#echo "hora1:" $hora;
		#echo "minuto1:" $minuto;
			while read comercial;
			do
				inicio=`date +%s` 
				now=`date +%Y%m%d` 

					IFS="|"
					n=0
					for WORD in $comercial
					do
					data[$n]=$WORD
					n=$(($n+1))
					done
					IFS=" "
				if [[ $now -gt ${data[3]} ]]; then 
				sed -i "/${data[3]}/d" ~/.gradio/data/comerciales/$hora/$minuto.com  			
				if [ ! -e ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt ]; then
				touch ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt
				fi
				#Reporte comercialesborrados
				echo $hora:$minuto, ${data[0]} , Caducado ${data[3]} >> ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt 
				fi

			echo ~/.gradio/data/comerciales/$hora/$minuto.com				
			done < ~/.gradio/data/comerciales/$hora/$minuto.com
		fi
minuto=$(($minuto+1))
done

hora=$(($hora+1))
echo "hora2" $hora
done

echo "Borrar Eventos Caducados"

hora=0
while [ $hora -le 23 ]
do
minuto=0
while [ $minuto -le 59 ]
do
#echo "hora:" $hora;
#echo "minuto:" $minuto;
		if [ -s ~/.gradio/data/eventos/$hora/$minuto.com ]; then
		#echo "hora1:" $hora;
		#echo "minuto1:" $minuto;
			while read comercial;
			do
				inicio=`date +%s` 
				now=`date +%Y%m%d` 

					IFS="|"
					n=0
					for WORD in $comercial
					do
					data[$n]=$WORD
					n=$(($n+1))
					done
					IFS=" "
				if [[ $now -gt ${data[3]} ]]; then 
				sed -i "/${data[3]}/d" ~/.gradio/data/eventos/$hora/$minuto.com  			
				if [ ! -e ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt ]; then
				touch ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt
				fi
				#Reporte comercialesborrados
				echo $hora:$minuto, ${data[0]} , Caducado ${data[3]} >> ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt 
				fi

			echo ~/.gradio/data/eventos/$hora/$minuto.com				
			done < ~/.gradio/data/eventos/$hora/$minuto.com
		fi
minuto=$(($minuto+1))
done

hora=$(($hora+1))
echo "hora2" $hora
done


echo "Borrar Eventos en espera Caducados"

hora=0
while [ $hora -le 23 ]
do
minuto=0
while [ $minuto -le 59 ]
do
#echo "hora:" $hora;
#echo "minuto:" $minuto;
		if [ -s ~/.gradio/data/eventos-espera/$hora/$minuto.com ]; then
		#echo "hora1:" $hora;
		#echo "minuto1:" $minuto;
			while read comercial;
			do
				inicio=`date +%s` 
				now=`date +%Y%m%d` 

					IFS="|"
					n=0
					for WORD in $comercial
					do
					data[$n]=$WORD
					n=$(($n+1))
					done
					IFS=" "
				if [[ $now -gt ${data[3]} ]]; then 
				sed -i "/${data[3]}/d" ~/.gradio/data/eventos-espera/$hora/$minuto.com  			
				if [ ! -e ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt ]; then
				touch ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt
				fi
				#Reporte comercialesborrados
				echo $hora:$minuto, ${data[0]} , Caducado ${data[3]} >> ~/.gradio/data/reporte/comercialesborrados-`date +%Y-%d-%m`.txt 
				fi

			echo ~/.gradio/data/eventos-espera/$hora/$minuto.com				
			done < ~/.gradio/data/eventos-espera/$hora/$minuto.com
		fi
minuto=$(($minuto+1))
done

hora=$(($hora+1))
echo "hora2" $hora
done

