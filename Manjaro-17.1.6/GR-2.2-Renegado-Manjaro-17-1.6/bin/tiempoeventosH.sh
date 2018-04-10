#!/bin/bash
#Evalúa el tiempo acumulado de comerciales
hora=0
minuto=0
acumulado=0
acumuladocorte=0
hh=0
minutocorte=`cat ~/.gradio/data/tmp/MM`
echo "minutocorte" $minutocorte
while [ $hh -le 23 ]; do
bandera=`cat ~/.gradio/data/tmp/$hh`
if [ $bandera = 1 ]; then
hora=$hh
fi
hh=$(($hh+1))
done

while [ $minuto -le 59 ]; do
	if [[ -s ~/.gradio/data/eventos/$hora/$minuto.com ]]; then
	while read linea
		do
		ruta=`echo "$linea"| awk -F "|" {'print $1'}`
		inicio=`echo "$linea"| awk -F "|" {'print $3'}`
		fin=`echo "$linea"| awk -F "|" {'print $4'}`
		hoy=`date +%Y%m%d`
		
		
		if [[ -d "$ruta/" && $hoy -le $fin && $hoy -ge $inicio ]]; then
                echo "es directorio"
                tiempo=`mplayer -ao null -identify -frames 0 "$ruta"/* 2>&1|grep ID_LENGTH|awk -F"=" {'print $2'}|sort -nr |head -n 1`
                                
                acumulado=`echo "scale=2; $acumulado + $tiempo" | bc`
			if [[ $minutocorte = $minuto ]]; then 
			acumuladocorte=`echo "scale=2; $acumuladocorte + $tiempo" | bc`
			fi

                else
                
		if [[ -s "$ruta" && $hoy -le $fin && $hoy -ge $inicio  ]]; then	
		tiempo=`mplayer -ao null -identify -frames 0 "$ruta" 2>&1 | grep ID_LENGTH|awk -F"=" {'print $2'}`
		acumulado=`echo "scale=2; $acumulado + $tiempo" | bc`
			if [[ $minutocorte = $minuto ]]; then 
			acumuladocorte=`echo "scale=2; $acumuladocorte + $tiempo" | bc`
			fi
		fi		
		fi
		
	done < ~/.gradio/data/eventos/$hora/$minuto.com
	fi
	minuto=$(($minuto+1))
done
minutos=`echo "scale=2; $acumulado / 60"|bc`
minutoscorte=`echo "scale=2; $acumuladocorte / 60"|bc`
echo "$minutos min"  > ~/.gradio/data/tmp/tiempoeventosH
echo "$minutoscorte min"  > ~/.gradio/data/tmp/tiempoeventosM
echo "Acumulados: " $minutos
echo "Este corte: " $minutoscorte
