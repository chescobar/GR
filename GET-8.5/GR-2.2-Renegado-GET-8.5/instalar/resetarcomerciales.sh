#!/bin/bash

#############################################################################
#  Guarangoradio un programa de Automatización de radio programado en bash  #
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

#Generar archivos vacios de la parrila de comerciales
rm -Rf ~/.guarangoradio/data/comerciales
mkdir ~/.guarangoradio/data/comerciales
i=0
	 while [  $i -le 23 ]; do
j=0
		mkdir ~/.guarangoradio/data/comerciales/$i	
		 while [  $j -le 55 ]; do					    
				touch ~/.guarangoradio/data/comerciales/$i/$j.com				
				echo comercial $i-$j				
				ls -l ~/.guarangoradio/data/comerciales/$i/$j.com		
			j=$(($j+5))				
		done
	     let i=$(($i+1)) 
	 done








#Borrar lineas en blanco de la parrilla
#sed '/^$/d' ~/.guarangoradio/data/parrilla/*/*.mus
