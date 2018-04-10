#!/bin/bash
usuario=`whoami`
tema=`cat /home/$usuario/.gradio/data/tmp/drop|awk -F
dfx=`cat /home/$usuario/.gradio/data/panel/tmp/dfxtmp `
fx=`cat /home/$usuario/.gradio/data/panel/tmp/fxtmp `
echo "tema:" $tema
extension="${tema##*.}"
extension=`echo $extension`
echo \"extension:\" $extension
validado=`grep -i $extension ~/.gradio/data/extensiones`
echo "validado:" $validado
if [ "$validado" != "" ]; then
	nombrebase=`echo "$tema" |awk -F/ '{print $NF}'|sed s/".$extension"//g`
        echo $tema > ~/.gradio/data/panel/botonera/fxxs/$dfx/"FX"$fx".play"
		duracion=`mplayer -ao null -identify -frames 0 "$tema" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
		duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
        echo $nombrebase "[""$duracionview""]" > ~/.gradio/data/panel/botonera/fxxs/$dfx/"FX"$fx".nombre"
fi