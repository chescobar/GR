#!/bin/bash
usuario=`whoami`
efecto=`zenity --filename="/home/$usuario/G Radio/efectos/" --file-selection --title="Seleccione el archivo de audio a ser programado como pisador"` 
nombrebase=`echo "$efecto" |awk -F/ '{print $NF}'`

if [ $? = 0 ]; then
   echo "sleep \`cat ~/.gradio/data/tmp/disparo\` ; play \"$efecto\"" > ~/.gradio/data/panel/pisador.sh
   echo $nombrebase > ~/.gradio/data/tmp/pisadorname
else
exit 0
fi
                 
