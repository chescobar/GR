#!/bin/bash
#Evalúa el tiempo acumulado de comerciales
hora=`date +%-H`
minuto=0
acumulado=0
while [ $minuto -le 59 ]; do
if [[ -s ~/.gradio/data/comerciales/$hora/$minuto.com ]]; then
while read linea
do
ruta=`echo "$linea"| awk -F "|" {'print $1'}`
inicio=`echo "$linea"| awk -F "|" {'print $3'}`
fin=`echo "$linea"| awk -F "|" {'print $4'}`
hoy=`date +%Y%m%d`

                if [[ -d "$ruta/" && $hoy -le $fin && $hoy -ge $inicio ]]; then
                #echo "es directorio"
                tiempos=`mplayer -ao null -identify -frames 0 "$ruta"/* 2>&1 | grep ID_LENGTH|awk -F"=" {'print $2'}`
                #echo tiempos $tiempos
                        arreglo=(`echo ${tiempos}`)
                        dimarr=`echo ${#arreglo[@]}`
                        mayor=0
                        i=0
                        while [ $i -lt $dimarr ]; do

                        #echo "tiempo[0]: " ${tiempos[0]}
                        #echo "arreglo[$i]: " ${arreglo[$i]}

                        if (($(echo "${arreglo[$i]} > $mayor" |bc -l ) )); then
                        mayor=${arreglo[$i]}
			#echo mayor $mayor
                        fi
                        i=$(($i+1))
                        done

                        acumulado=`echo "scale=2; $acumulado + $mayor" | bc`
                else

if [[ -s "$ruta" && $hoy -le $fin && $hoy -ge $inicio  ]]; then

                #echo "no es directorio"
                        tiempo=`mplayer -ao null -identify -frames 0 "$ruta" 2>&1 | grep ID_LENGTH|awk -F"=" {'print $2'}`
			acumulado=`echo "scale=2; $acumulado + $tiempo" | bc`
                fi

#echo "ruta: " $ruta "inicio: " $inicio "fin: " $fin "tiempo: " $tiempo "acumulado: " $acumulado
fi
done < ~/.gradio/data/comerciales/$hora/$minuto.com
fi
minuto=$(($minuto+1))
done
minutos=`echo "scale=2; $acumulado / 60"|bc`
echo "$minutos min"  > ~/.gradio/data/tmp/tiempocomerciales
#echo "minutos acumulados: " $minutos
                                              
