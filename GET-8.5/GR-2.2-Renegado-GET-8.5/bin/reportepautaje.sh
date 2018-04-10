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
i=0 
ruta=~/.gradio/data/reporte/pautaje-`date +%Y%m%d`.txt
echo "#########################################################################" > $ruta
echo "###                   REPORTE DE PAUTAJE DE COMERCIALES                ##" >> $ruta
echo "###                               G - RADIO                            ##" >> $ruta
echo "#########################################################################" >> $ruta
echo Reporte de pautaje `date +%Y-%m-%d` >> $ruta
echo " " >> $ruta
echo Formato":" Comercial"|"Días de la semana"|"Fecha inicio"|"Fecha fin >> $ruta
echo "Días de la semana; 1=lunes 2=martes 3=miércoles ...... 7=domingo" >> $ruta
echo " " >> $ruta
echo ======================================================================== >> $ruta
echo " " >> $ruta
while [ $i -le 23 ]; do
j=0
while [ $j -le 59 ]; do
if [ -s ~/.gradio/data/comerciales/$i/$j.com ]; then
echo "==$i horas $j minutos==" >> $ruta
cat ~/.gradio/data/comerciales/$i/$j.com >> $ruta
echo " " >> $ruta
fi
j=$(($j+1))
done
i=$(($i+1))
done
i=0
echo "#########################################################################" >> $ruta
echo "###                    REPORTE DE PAUTAJE DE EVENTOS                   ##" >> $ruta
echo "###                               G - RADIO                            ##" >> $ruta
echo "#########################################################################" >> $ruta
echo Reporte de pautaje `date +%Y-%m-%d` >> $ruta
echo " " >> $ruta
echo Formato":" Comercial"|"Días de la semana"|"Fecha inicio"|"Fecha fin >> $ruta
echo "Días de la semana; 1=lunes 2=martes 3=miércoles ...... 7=domingo" >> $ruta
echo " " >> $ruta
echo ======================================================================== >> $ruta
echo " " >> $ruta
while [ $i -le 23 ]; do
j=0
while [ $j -le 59 ]; do
if [ -s ~/.gradio/data/eventos/$i/$j.com ]; then
echo "==$i horas $j minutos==" >> $ruta
cat ~/.gradio/data/eventos/$i/$j.com >> $ruta
echo " " >> $ruta
fi
j=$(($j+1))
done
i=$(($i+1))
done
i=0
echo "#########################################################################" >> $ruta
echo "###               REPORTE DE PAUTAJE DE EVENTOS EN ESPERA              ##" >> $ruta
echo "###                               G - RADIO                            ##" >> $ruta
echo "#########################################################################" >> $ruta
echo Reporte de pautaje `date +%Y-%m-%d` >> $ruta
echo " " >> $ruta
echo Formato":" Comercial"|"Días de la semana"|"Fecha inicio"|"Fecha fin >> $ruta
echo "Días de la semana; 1=lunes 2=martes 3=miércoles ...... 7=domingo" >> $ruta
echo " " >> $ruta
echo ======================================================================== >> $ruta
echo " " >> $ruta
while [ $i -le 23 ]; do
j=0
while [ $j -le 59 ]; do
if [ -s ~/.gradio/data/eventos-espera/$i/$j.com ]; then
echo "==$i horas $j minutos==" >> $ruta
cat ~/.gradio/data/eventos-espera/$i/$j.com >> $ruta
echo " " >> $ruta
fi
j=$(($j+1))
done
i=$(($i+1))
done

$EDITOR $ruta
#~/.gradio/bin/gradio-gui.sh
