#!/bin/bash
usuario=`whoami`
tema=`cat /home/$usuario/.gradio/data/tmp/drop|awk -F '{print $1}'|sed s/'file\:\/\/'/""/g|sed s/\%20/\ /g|sed s/"%C3%91"/"Ñ"/g|sed s/"%C3%B1"/"ñ"/g|sed s/"%C2%B4"/\´/g|sed s/"%C2%AA"/"ª"/g|sed s/"%5B"/"["/g|sed s/"%5D"/"]"/g|sed s/"%C3%AD"/"í"/g|sed s/"%C3%A1"/"á"/g|sed s/"%C3%A9"/"é"/g|sed s/"%C3%B3"/"ó"/g|sed s/"%C3%BA"/"ú"/g`
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
