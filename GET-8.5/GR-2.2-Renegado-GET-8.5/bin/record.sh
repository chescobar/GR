#!/bin/bash
export DISPLAY=:0.0
if [ -d ~/respaldos/ ]; then
fecha=`date +%m-%d-%Y-%H-%M`
if [ -s ~/respaldos/grabacion-$fecha.mp3 ]; then
zenity --warning --text "Ya existe un archivo de esa fecha" &
else
xterm -geometry 80x3 -title "Grabacion-$fecha" -e rec -c 1 ~/respaldos/grabacion-$fecha.mp3
fi
else
mkdir ~/respaldos
#!/bin/bash
fecha=`date +%m-%d-%Y-%H-%M`
if [ -s ~/respaldos/grabacion-$fecha.mp3 ]; then
zenity --warning --text "Ya existe un archivo de esa fecha" &
else
xterm -geometry 80x3 -title "Grabacion-$fecha" -e rec -c 1 ~/respaldos/grabacion-$fecha.mp3
fi
fi
