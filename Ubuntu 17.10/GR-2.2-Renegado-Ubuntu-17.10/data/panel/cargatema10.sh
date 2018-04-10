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
playlist=$((`grep -c $ ~/.gradio/data/tmp/playlist`*1))


extension="${tema##*.}"
validado=`grep -i $extension ~/.gradio/data/extensiones`
if [ "$validado" != "" ]; then
playlist=$((`grep -c $ ~/.gradio/data/tmp/playlist`*1))
nombrebase=`echo "$tema" |awk -F/ '{print $NF}'`
#duracion=`$PROGDUR -i "$tema"  2>&1 | egrep "Duration" | cut -d ' ' -f 4 | sed s/,//|awk -F. '{print $1}'`
		duracion=`mplayer -ao null -identify -frames 0 "$tema" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
		duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
echo playlist: $playlist
cartucho=10
precartucho=$(($cartucho - 1))
preprecartucho=$(($precartucho - 1))
poscartucho=$(($cartucho + 1))
if [ $playlist -ge $precartucho ]; then

        sed -i "$precartucho a $tema" ~/.gradio/data/tmp/playlist
        sed -i "$precartucho a $nombrebase "[""$duracionview""]"" ~/.gradio/data/tmp/playlistg3
        sed -i "$precartucho a <font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" ~/.gradio/data/tmp/playlistweb
        sed -i "$poscartucho""d" ~/.gradio/data/tmp/playlist
        sed -i "$poscartucho""d" ~/.gradio/data/tmp/playlistg3
        sed -i "$poscartucho""d" ~/.gradio/data/tmp/playlistweb
        echo $nombrebase "[""$duracionview""]" > ~/.gradio/data/tmp/cartucho$cartucho
else
if [ $playlist -eq 0 ]; then
        echo $tema > ~/.gradio/data/tmp/playlist
        echo $nombrebase "[""$duracionview""]" > ~/.gradio/data/tmp/playlistg3
        echo $nombrebase "[""$duracionview""]" > ~/.gradio/data/tmp/cartucho1
        echo "<font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" > ~/.gradio/data/tmp/playlistweb
fi

barrido=1
while [ $barrido -lt $precartucho ]; do
posbarrido=$(($barrido+1))
#echo $barrido
	if [ $playlist -eq $barrido ]; then
        echo $tema >> ~/.gradio/data/tmp/playlist
        echo $nombrebase "[""$duracionview""]" >> ~/.gradio/data/tmp/playlistg3
        echo $nombrebase "[""$duracionview""]" > ~/.gradio/data/tmp/cartucho$posbarrido
        echo "<font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" >> ~/.gradio/data/tmp/playlistweb
        fi
        barrido=$(($barrido+1))
done

fi
fi

