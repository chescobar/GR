#!/bin/bash
zenity --info --text "En GNU/Linux, El segundo monitor \n es una extensión en pixeles del primero. \n En la siguiente ventana defina \n en pixeles ese desplazamiento"
desplazamiento=`zenity --text "Ingrese o seleccione \n el desplazamiento al segundo monitor \n en pixeles" --entry "500" "1000" "1500" "2000"`
echo $desplazamiento > ~/.gradio/data/tmp/tvdesplazamiento
exit 0
