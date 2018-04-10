#!/bin/bash
usuario=`whoami`
tema=`cat /home/$usuario/.gradio/data/tmp/drop|awk -F

#tema=$tema|sed -e s/file:\/\///g|sed -e s/%20/\ /g
echo "tema:" $tema
extension="${tema##*.}"
extension=`echo $extension`
echo \"extension:\" $extension
validado=`grep -i $extension ~/.gradio/data/extensiones`
echo "validado:" $validado
if [ "$validado" != "" ]; then
playlist=$((`grep -c $ ~/.gradio/data/tmp/playlist`*1))
nombrebase=`echo "$tema" |awk -F/ '{print $NF}'`
echo playlist: $playlist
		duracion=`mplayer -ao null -identify -frames 0 "$tema" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
		duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
if [ $playlist -ge 1 ]; then
	sed -i "1d" ~/.gradio/data/tmp/playlist
	sed -i "1d" ~/.gradio/data/tmp/playlistg3
	sed -i "1 i $tema" ~/.gradio/data/tmp/playlist
	sed -i "1 i $nombrebase" ~/.gradio/data/tmp/playlistg3
	sed -i "1d" ~/.gradio/data/tmp/playlistweb
	sed -i "1 i <font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" ~/.gradio/data/tmp/playlistweb
	echo $nombrebase "[""$duracionview""]"  > ~/.gradio/data/tmp/cartucho1
else
	echo $tema >> ~/.gradio/data/tmp/playlist
	echo $nombrebase >> ~/.gradio/data/tmp/playlistg3
	echo $nombrebase "[""$duracionview""]"  > ~/.gradio/data/tmp/cartucho1
	echo "<font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" >> ~/.gradio/data/tmp/playlistweb
fi
fi