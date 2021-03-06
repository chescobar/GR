#!/bin/bash
#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
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
########################################INICIO COMERCIALES MANUAL
#. ~/.gradio/bin/comercialplay.sh 	
	echo "+++++++++Inicio Reproducción Comerciales++++++++++++++++"
		
espera=`cat ~/.gradio/data/tmp/stop`
if [[ $espera = 1 ]]; then
		iniespaciop=`cat ~/.gradio/data/tmp/espacio`
		cnlineas=`grep -c $ ~/.gradio/data/tmp/comercialeslist`
		if [ -s ~/.gradio/data/tmp/comercialeslist ]; then

		minini=`date  +%-M`
		hini=`date +%-H`
		cnlinea=1 

			#sleep $(($mix-2))
			if [[ $iniespaciop = 1 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.gradio/data/panel/playinicioespacio.sh
			iniespaciop=3
			fi

		while [ $cnlinea -le $cnlineas ]; 
		do 
		cline="`sed -n $cnlinea"p" ~/.gradio/data/tmp/comercialeslist`" 
		cline1=`sed -n $cnlinea"p" ~/.gradio/data/tmp/comercialeslist` #  sed --follow-symlinks --posix --expression s/'"'//g` 
						
			cline=`echo -e "${cline}"|sed  s/\'//g`
			cline=`echo -e "${cline}"|sed  s/" "/"\\\\ "/g`
					
			randomfile=`sed -n 1p ~/.gradio/data/tmp/comercialeslist`
			sed -i "1d" ~/.gradio/data/tmp/comercialeslist
			sed -i "1d" ~/.gradio/data/tmp/comercialeslistweb
			sed -i "1d" ~/.gradio/data/tmp/comercialeslistwebg3
			echo randomfile $randomfile
			nombrebase=`echo "$randomfile" |awk -F/ '{print $NF}'`

			comini=`date +%s`
			# randomfile se usa para calcular el tiempo del sleep ;)
			echo "$randomfile" > ~/.gradio/data/tmp/currentsong.txt;
			echo "$randomfile" > ~/.gradio/data/tmp/currentcomercial.txt;
			echo "<font size="1" color="red"><b>$nombrebase</b></font>" > ~/.gradio/data/tmp/currentsongweb;
				xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e mplayer -volume 100 -slave -input file=~/.gradio/data/tmp/slave.txt  "$randomfile" 
			comfin=`date +%s`
			duracion=$(( $comfin - $comini ))
						if [ -s ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m` ]; then
						touch ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`
						fi
						echo `date +%Y-%d-%m-%H:%M`, "$randomfile", $duracion segundos >> ~/.gradio/data/reporte/comercial-`date +%Y-%d-%m`.txt #Reporte comerciales

			esperacom=`cat ~/.gradio/data/tmp/stopcomercial`
			
			if [[ $iniespaciop = 3 ]]; then
			if [[ $espera = 1 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.gradio/data/panel/playfinespacio.sh
			fi
			fi

			while [[ $esperacom = 1 ]]; do
			echo "Detenido...... Presione PlayComerciales para continuar reproduciendo" > ~/.gradio/data/tmp/currentcomercial.txt
			sleep 1
			esperacom=`cat ~/.gradio/data/tmp/stopcomercial`
			if [[ $iniespaciop = 1 ]]; then
			if [[ $espera = 0 ]]; then
			xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.gradio/data/panel/playinicioespacio.sh
			iniespaciop=3
			fi
			fi
			done
						
		cnlinea=$(($cnlinea+1))
		echo "cnlinea" $cnlinea
	
		done 
		
		#minfin=`date  +%-M`
		#hfin=`date +%-H`
#		echo "===Dispara CargaComercial====== con minini:" $minini "minfin:" $minfin "hfin:" $hfin
#		. ~/.gradio/bin/cargacomercial.sh &
		echo "=============Fin Comerciales==================="
		fi
		#fi de comerciales

		
		if [[ $iniespaciop = 3 ]]; then
		xterm -iconic  -fg Green -bg Red -title "$nombrebase"  -geometry 40x1-0+0 -e ~/.gradio/data/panel/playfinespacio.sh
		fi
		echo "Visor de Comerciales" > ~/.gradio/data/tmp/currentcomercial.txt;
		echo "+++++++++Fin Reproducción Comerciales++++++++++++++++"
fi
################################### FIN COMERCIALES #####################################
