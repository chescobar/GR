#!/bin/bash

usuario=`whoami`
yadexiste=`which yad`
if [ "$yadexiste" = "" ]; then
echo "yad no está instalado"
comando="zenity"
else
comando="yad"
centrado="--center"
fi

tema=`$comando --width=700 --height=600 $centrado --filename="/home/$usuario/G Radio/musica/" --file-selection --title="Seleccione el archivo de audio a ser programado como tema musical"` 

        case $? in
                 0)
                        echo "\"$tema\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
		
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac

extension="${tema##*.}"
validado=`grep -i $extension ~/.gradio/data/extensiones`
if [ "$validado" != "" ]; then
playlist=$((`grep -c $ ~/.gradio/data/tmp/playlist`*1))
nombrebase=`echo "$tema" |awk -F/ '{print $NF}'`
		duracion=`mplayer -ao null -identify -frames 0 "$tema" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
		duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
echo playlist: $playlist
if [ $playlist -ge 1 ]; then
        sed -i "1d" ~/.gradio/data/tmp/playlist
        sed -i "1d" ~/.gradio/data/tmp/playlistg3
        sed -i "1 i $tema" ~/.gradio/data/tmp/playlist
        sed -i "1 i $nombrebase "[""$duracionview""]"" ~/.gradio/data/tmp/playlistg3
        sed -i "1d" ~/.gradio/data/tmp/playlistweb
        sed -i "1 i <font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" ~/.gradio/data/tmp/playlistweb
        echo $nombrebase "[""$duracionview""]" > ~/.gradio/data/tmp/cartucho1
else
        echo $tema >> ~/.gradio/data/tmp/playlist
        echo $nombrebase "[""$duracionview""]" >> ~/.gradio/data/tmp/playlistg3
        echo $nombrebase "[""$duracionview""]" >> ~/.gradio/data/tmp/cartucho1
        echo "<font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" >> ~/.gradio/data/tmp/playlistweb
fi
fi
            
