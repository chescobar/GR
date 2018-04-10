#!/bin/bash
usuario=`whoami`
logo=`zenity --filename=/home/$usuario/G\ Radio/logo/ --file-selection --title="Seleccione el logo en formato PNG"` 

		if [ $? -eq 0 ]
		then
			case $? in
				 0)
				        echo "\"$logo\" seleccionado.";;
				 1)
				        echo "No ha seleccionado ningún archivo.";;
				-1)
				        echo "No ha seleccionado ningún archivo.";;
			esac
		fi
		#########################
if [[ $? = 0 ]]; then
extension="${logo##*.}"
valido=`echo $extension|grep -i PNG`
valido=`echo $extension|grep -i GIF`
if [[ $valido != "" ]]; then
nombrebase=`echo "$logo" |awk -F/ '{print $NF}'`
echo $nombrebase > ~/.gradio/data/tmp/logo.name
convert "$logo" ~/.gradio/data/tmp/logo.rgba
ancho=`file "$logo"|awk -F "," '{print $2}'|awk '{print $1}'`
alto=`file "$logo"|awk -F "," '{print $2}'|awk '{print $3}'`
echo $ancho > ~/.gradio/data/tmp/logo.info
echo $alto >> ~/.gradio/data/tmp/logo.info
else
zenity --warning --text "El archivo seleccionado no es PNG"
fi
fi
exit 0
