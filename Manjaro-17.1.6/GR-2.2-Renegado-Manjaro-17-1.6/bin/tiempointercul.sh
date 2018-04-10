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

######### INTERCULTURAL
#!/bin/sh
usuario=`whoami`
hoy=`date +%Y-%d-%m`
tiempos=`grep "Intercultural/Contenido" /home/$usuario/.gradio/data/reporte/*|grep $hoy|awk -F "," {'print $4'}|sed s/segundos//g|sed s/" "//g`
#                echo tiempos $tiempos
                        arreglo=(`echo ${tiempos}`)
                        dimarr=`echo ${#arreglo[@]}`
                        mayor=0
                        i=0
                        while [ $i -lt $dimarr ]; do

#                        echo "arreglo[$i]: " ${arreglo[$i]}
                        acumulado=$((acumulado+${arreglo[$i]}))
#			echo acumulado $acumulado
                        i=$(($i+1))
                        done
			acumulado=`echo "scale=2; $acumulado / 60" | bc`
			echo "$acumulado min" > /home/$usuario/.gradio/data/tmp/porcintercultural
			echo "acumulado Intercultural" $acumulado

########### ARTISTA NACIONAL
#naccarpetas=`cat -s /home/$usuario/.gradio/data/tmp/nacionalcarpetas`
#readarray naccarpetas < "/home/$usuario/.gradio/data/tmp/nacionalcarpetas"

tocadosglobal=`grep "G\ Radio/musica/" /home/$usuario/.gradio/data/reporte/*|grep $hoy|awk -F "," {'print $4'}|sed s/segundos//g|sed s/" "//g`
                        arregloglobal=(`echo ${tocadosglobal}`)
                        dimarrglobal=`echo ${#arregloglobal[@]}`
                        i=0
                        acumuladoglobal=0
                        while [ $i -lt $dimarrglobal ]; do

                        #echo "arregloglobal[$i]: " ${arregloglobal[$i]}
                        acumuladoglobal=$((acumuladoglobal+${arregloglobal[$i]}))
                        
                        i=$(($i+1))
                        done
			#echo "acumuladoglobalsegndos: " $acumuladoglobal
                        acumuladoglobal=`echo "scale=2; $acumuladoglobal / 60" | bc`
			#echo "acumuladoglobalminutos: " $acumuladoglobal

IFS=$'\r\n' GLOBIGNORE='*' command eval  'arreglonaccar=($(cat /home/$usuario/.gradio/data/tmp/nacionalcarpetas))'
                        dimarrnaccar=`echo ${#arreglonaccar[@]}`

j=0
acumuladonac=0
dimarrnacglobal=0

while [ $j -lt $dimarrnaccar ]; do

tocados=`grep "${arreglonaccar[$j]}" /home/$usuario/.gradio/data/reporte/*|grep $hoy|awk -F "," {'print $4'}|sed s/segundos//g|sed s/" "//g`
                      #echo "arreglo[$j]: " ${arreglo[$j]}
                      #echo "arreglonaccar[$j]: " ${arreglonaccar[$j]}

                        arreglonac=(`echo ${tocados}`)
                        dimarrnac=`echo ${#arreglonac[@]}`
			dimarrnacglobal=$(($dimarrnacglobal+$dimarrnac))
                        i=0

                        while [ $i -lt $dimarrnac ]; do

                        #echo "arreglo[$i]: " ${arreglo[$i]}
                        acumuladonac=$(($acumuladonac+${arreglonac[$i]}))
                        #echo "acumuladonac: " $acumuladonac
                        i=$(($i+1))
                        done
j=$(($j+1))
done
                        acumuladonac=`echo "scale=2; $acumuladonac / 60" | bc`
			#echo "acumuladonacminutos: " $acumuladonac
			echo "nacional/global" $acumuladonac"/"$acumuladoglobal
                        echo "$dimarrnacglobal"/"$dimarrglobal" > /home/$usuario/.gradio/data/tmp/porcnacional

