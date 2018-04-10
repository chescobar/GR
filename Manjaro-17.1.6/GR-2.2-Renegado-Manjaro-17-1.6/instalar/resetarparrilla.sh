#!/bin/bash

#############################################################################
#  Guarangoradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 23-Jun-2011		    #
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

#Generar archivos vacios de la parrila de comerciales
rm -Rf ~/.guarangoradio/data/parrilla
mkdir ~/.guarangoradio/data/parrilla
i=0
	 while [  $i -le 7 ]; do
j=0
		mkdir ~/.guarangoradio/data/parrilla/$i	
		 while [  $j -le 23 ]; do
				ranura=$j-$(($j+1)).mus					    
				touch ~/.guarangoradio/data/parrilla/$i/$ranura				
				echo ranura $ranura				
				ls -l ~/.guarangoradio/data/parrilla/$i	
			j=$(($j+1))				
		done
	     let i=$(($i+1)) 
	 done

echo "1 lunes" > ~/.guarangoradio/data/parrilla/leeme.txt
echo "2 martes" >> ~/.guarangoradio/data/parrilla/leeme.txt
echo "3 miércoles" >> ~/.guarangoradio/data/parrilla/leeme.txt
echo "4 jueves" >> ~/.guarangoradio/data/parrilla/leeme.txt
echo "5 viernes" >> ~/.guarangoradio/data/parrilla/leeme.txt
echo "6 sábado" >> ~/.guarangoradio/data/parrilla/leeme.txt
echo "7 domingo" >> ~/.guarangoradio/data/parrilla/leeme.txt
echo "0 generico" >> ~/.guarangoradio/data/parrilla/leeme.txt


#Borrar lineas en blanco de la parrilla
#sed '/^$/d' ~/.guarangoradio/data/parrilla/*/*.mus
