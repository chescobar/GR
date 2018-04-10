#!/bin/bash
#Evalúa el tiempo acumulado de comerciales
hora=0
minuto=`cat ~/.gradio/data/tmp/MM`
acumulado=0
hh=0

while [ $hh -le 23 ]; do
bandera=`cat ~/.gradio/data/tmp/$hh`
if [ $bandera = 1 ]; then
hora=$hh
fi
hh=$(($hh+1))
done

	if [[ -s ~/.gradio/data/comerciales/$hora/$minuto.com ]]; then
	while read linea
		do
		ruta=`echo "$linea"| awk -F "|" {'print $1'}`
		inicio=`echo "$linea"| awk -F "|" {'print $3'}`
		fin=`echo "$linea"| awk -F "|" {'print $4'}`
		hoy=`date +%Y%m%d`

		if [[ -d "$ruta" ]]; then
			mayor=`mplayer -ao null -identify -frames 0 "$ruta"/* 2>&1 | grep ID_LENGTH|awk -F"=" {'print $2'}|sort -nr | head -n1`

			acumulado=`echo "scale=2; $acumulado + $mayor" | bc`
		else

		if [[ -s "$ruta" && $hoy -le $fin && $hoy -ge $inicio  ]]; then

			tiempo=`mplayer -ao null -identify -frames 0 "$ruta" 2>&1 | grep ID_LENGTH|awk -F"=" {'print $2'}`
			acumulado=`echo "scale=2; $acumulado + $tiempo" | bc`
		fi

		#echo "hora: " $hora "ruta: " $ruta "inicio: " $inicio "fin: " $fin "tiempo: " $tiempo "acumulado: " $acumulado
		fi
	done < ~/.gradio/data/comerciales/$hora/$minuto.com
	fi

minutos=`echo "scale=2; $acumulado / 60"|bc`
echo "$minutos min"  > ~/.gradio/data/tmp/tiempocomercialesM
#echo "minutos acumulados: " $minutos
