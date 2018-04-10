#!/bin/bash

mascara=`find ~/.gradio/bin/mascara/ -name '*.gambas' | awk -F / '{print $7}'|sed s/.gambas//|
zenity \
    --list \
    --title "Search Results" \
    --text "Seleccione una Interfaz" \
    --column "Interface"|awk -F "|" '{print $1}'`
echo mascara .$mascara.
if [[ $mascara != "" ]]; then
echo $mascara > ~/.gradio/data/tmp/mascara.name
rm ~/.gradio/bin/GMain.gambas
ln -s ~/.gradio/bin/mascara/"$mascara".gambas ~/.gradio/bin/GMain.gambas


zenity --warning --title="Alerta" --text "Para que la interface seleccionada se habilite, debe reiniciar el programa" 
else

mascara=`find ~/.gradio/bin/mascara/ -name '*.gambas' | awk -F / '{print $7}'|sed s/.gambas//|head -1`
echo $mascara > ~/.gradio/data/tmp/mascara.name
rm ~/.gradio/bin/GMain.gambas
ln -s ~/.gradio/bin/mascara/"$mascara".gambas ~/.gradio/bin/GMain.gambas
fi
