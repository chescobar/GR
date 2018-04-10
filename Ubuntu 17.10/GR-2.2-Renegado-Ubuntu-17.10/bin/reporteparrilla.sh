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

i=1
ruta=~/.gradio/data/reporte/parrilla-programada-`date +%Y%m%d`.txt
echo Reporte de pautaje `date +%Y-%m-%d` > $ruta
echo " " >> $ruta
echo "Días de la semana; 1=lunes 2=martes 3=miércoles ...... 7=domingo" >> $ruta
echo " " >> $ruta
echo ======================================================================== >> $ruta
echo " " >> $ruta
while [ $i -le 7 ]; do

j=0
while [ $j -le 23 ]; do
k=$j-$(($j+1)).mus
if [ -s ~/.gradio/data/parrilla/$i/$k ]; then

echo "==Día: `echo $i|sed s/1/lunes/g|sed s/2/martes/g|sed s/3/miércoles/g|sed s/4/jueves/g|sed s/5/viernes/g|sed s/6/sábado/g|sed s/7/domingo/g` ranura:  desde las $j hasta las" $(($j+1)) "horas ==" >> $ruta
cat ~/.gradio/data/parrilla/$i/$k >> $ruta
echo " " >> $ruta
fi
j=$(($j+1))
done
i=$(($i+1))
done
$EDITOR $ruta
#~/.gradio/bin/gradio-gui.sh
