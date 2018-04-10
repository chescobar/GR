#!/bin/bash

usuario=`whoami`

#Inicio función que carga los lists de eventos y comerciales
function comercialplay() {
	echo "Ejecuta funcioncomercialplay"
	#duracionacumulada=0
if [[ $evento = 1 ]]; then
	carpeta="eventos"
else
	if [[ $evento = 0 ]]; then
		carpeta="comerciales"
		else 

		if [[ $evento = 2 ]]; then
		carpeta="eventos-espera"
		fi
	fi	
fi

acciones=`grep -c $ ~/.gradio/data/$carpeta/$hora/$minutocarga.com`
accion=1
	while [[ $accion -le $acciones ]]; do
	action="`sed -n $accion"p" ~/.gradio/data/$carpeta/$hora/$minutocarga.com`"   					




	actionbase=`echo "$action"|awk -F"|" '{print $1}'`
	habil=`echo "$action"|awk -F"|" '{print $2}'|grep $dia`
	inicio=`echo "$action"|awk -F"|" '{print $3}'`
	final=`echo "$action"|awk -F"|" '{print $4}'`
	now=`date +%Y%m%d` 

			if [ -d "$actionbase" ]; then
				comercialrandom=`/bin/ls -1 "$actionbase" | sort --random-sort | head -1`
#				ruta=`readlink --canonicalize "$actionbase/$comercialrandom"` # Converts to full path
				ruta="$actionbase/$comercialrandom"
				nombrebase=`echo "$ruta" |awk -F/ '{print $NF}'`
				extension="${nombrebase##*.}"
				validado=`grep -i $extension ~/.gradio/data/extensiones`
				if [ "$validado" != "" ]; then
				echo "ruta: " $ruta
				actionbase="$ruta"
				else
				echo "El archivo "$actionbase"/"$comercialrandom" parece no ser de audio" >> /home/$usuario/.gradio/data/tmp/log
				fi 
			fi

	if [[ "$actionbase" != "" ]]; then
		if [[ $now -ge $inicio && $now -le $final  && $habil -gt 0 ]]; then  

			if [[ $evento = 1 ]]; then
				nbaseev=`echo "$actionbase"|awk -F/ '{print $NF}'`
				echo "$actionbase" >> ~/.gradio/data/tmp/eventoslist
				echo "<font size='1' color='blue'><b>$nbaseev</b></font>" >> ~/.gradio/data/tmp/eventoslistweb

						duracion=`mplayer -ao null -identify -frames 0 "$actionbase" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`						
						duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
				echo "$nbaseev" "["$duracionview"]" >> ~/.gradio/data/tmp/eventoslistwebg3 
				echo "CargalistaEventos..................."
				#echo duracionacumulada $duracionacumulada
					echo "coincidencia en" ~/.gradio/data/$carpeta/$hora/$minutocarga.com

			fi #evento =1

			if [[ $evento = 2 ]]; then
				nbaseev=`echo "$actionbase"|awk -F/ '{print $NF}'`
				echo "$actionbase" >> ~/.gradio/data/tmp/eventos-esperalist
				echo "<font size='1' color='blue'><b>$nbaseev</b></font>" >> ~/.gradio/data/tmp/eventos-esperalistweb

						duracion=`mplayer -ao null -identify -frames 0 "$actionbase" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
						duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))				
				echo "$nbaseev" "["$duracionview"]" >> ~/.gradio/data/tmp/eventos-esperalistwebg3 
				echo "CargalistaEventos..................."
				#echo duracionacumulada $duracionacumulada
					echo "coincidencia en" ~/.gradio/data/$carpeta/$hora/$minutocarga.com

			fi #evento =2


			if [[ $evento = 0 ]]; then
			nbasecom=`echo "$actionbase"|awk -F/ '{print $NF}'`
			echo "$actionbase" >> ~/.gradio/data/tmp/comercialeslist
			echo "<font size='1' color='blue'><b>$nbasecom</b></font>" >> ~/.gradio/data/tmp/comercialeslistweb

						duracion=`mplayer -ao null -identify -frames 0 "$actionbase" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`						
						duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
			echo "$nbasecom" "["$duracionview"]" >> ~/.gradio/data/tmp/comercialeslistwebg3 
			echo "CargalistaComerciales..................."
			#echo duracionacumulada $duracionacumulada
				echo "coincidencia en" ~/.gradio/data/$carpeta/$hora/$minutocarga.com
			fi #evento=0
			
		fi #now
	fi #actionbase !=""
	accion=$(($accion+1))
	done #accion -le acciones
#Fin funcion
}

infinito=1
while [ $infinito = 1 ]; do
hora=`date  +%-H` 
dia=`date +%u`
minuto=`date +%-M`
segundo=`date +%-S`



if [[ $minuto -eq 0 ]]; then
sleep 1
tonohora=`cat ~/.gradio/data/tmp/tonohora`
if [ $tonohora = 1 ]; then
/home/$usuario/.gradio/bin/tono-hora.sh
fi
ranura=`echo "$hora-$(($hora+1)).mus"`
ranuraprevia=`echo "$(($hora-1))-$hora.mus"`

secuencia=`diff ~/.gradio/data/parrilla/$dia/$ranura ~/.gradio/data/parrilla/$dia/$ranuraprevia`
echo "secuencia" $secuencia
#Vaciar playlist por cambio de parrilla
if [[ "$secuencia" != "" ]]; then
echo "vacio la lista por cambio de parrilla"
~/.gradio/bin/vaciarlista.sh
sleep 1
~/.gradio/bin/vaciarlista.sh
sleep 3 #tiempo para cargar playlist
else
echo "dejar una linea en playlist ¿..?"
fi
fi



while [ $segundo -lt 58 ]; do
sleep 2
segundo=`date +%-S`
done
#echo "minuto" $minuto "segundo" $segundo

			evento=0

			minutocarga=$(($minuto+1))
			#echo "minutocarga" $minutocarga
			if [ $minutocarga -lt 60 ]; then
				
				if [ -s ~/.gradio/data/eventos/$hora/$minutocarga.com ]; then
				evento=1
				saltar=0
				echo "evento en la misma hora"
				echo "coincidencia apriori en" ~/.gradio/data/eventos/$hora/$minutocarga.com
				comercialplay
				fi
			else 
				
				hora=$(($hora+1))
				minutocarga=$(($minutocarga-60))			
				if [ -s ~/.gradio/data/eventos/$hora/$minutocarga.com ]; then
				evento=1
				saltar=0
				echo "evento en la siguiente hora"
				echo "coincidencia apriori en" ~/.gradio/data/eventos/$hora/$minutocarga.com
				comercialplay
				fi								
			fi

			if [ $minutocarga -lt 60 ]; then
				
				if [ -s ~/.gradio/data/eventos-espera/$hora/$minutocarga.com ]; then
				evento=2
				saltar=0
				echo "evento en la misma hora"
				echo "coincidencia apriori en" ~/.gradio/data/eventos-espera/$hora/$minutocarga.com
				comercialplay
				fi
			else 
				
				hora=$(($hora+1))
				minutocarga=$(($minutocarga-60))			
				if [ -s ~/.gradio/data/eventos-espera/$hora/$minutocarga.com ]; then
				evento=2
				saltar=0
				echo "evento en la siguiente hora"
				echo "coincidencia apriori en" ~/.gradio/data/eventos-espera/$hora/$minutocarga.com
				comercialplay
				fi								
			fi

			evento=0
			#minutocarga=$(($minuto+1))
			if [ $minutocarga -lt 60 ]; then
				
				if [ -s ~/.gradio/data/comerciales/$hora/$minutocarga.com ]; then
				evento=0
				echo "comercial en la misma hora"
				echo "coincidencia apriori en" ~/.gradio/data/comerciales/$hora/$minutocarga.com
				comercialplay
				fi
			else 				
				hora=$(($hora+1))
				minutocarga=$(($minutocarga-60))	
				echo "~/.gradio/data/comerciales/$hora/$minutocarga.com"		
				if [ -s ~/.gradio/data/comerciales/$hora/$minutocarga.com ]; then
				evento=0
				comercialplay
				echo "comercial en la siguiente hora"
				echo "coincidencia aprior en" ~/.gradio/data/comerciales/$hora/$minutocarga.com
				fi								
			fi
cnelineas=`grep -c $ ~/.gradio/data/tmp/eventoslist`
if [[ $cnelineas -ge 1 && $saltar = 0 ]]; then
sleep 2
~/.gradio/bin/siguiente.sh
saltar=1
while [[ $cnelineas -ge 1 ]]; do
sleep 5
cnelineas=`grep -c $ ~/.gradio/data/tmp/eventoslist`
done
fi
	while [[ $minuto = `date +%-M` ]]; do
	sleep 3
	done
done
