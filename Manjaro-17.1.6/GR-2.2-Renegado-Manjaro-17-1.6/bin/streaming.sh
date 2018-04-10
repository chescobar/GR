#!/bin/bash

opcion=`/usr/bin/zenity --title="Programar Cadena" --width=400 --height=300 \
                         --text="Seleccione página web o URL de streaming" \
                         --list --column="Cadena" --column="Seleccione" \
                         --radiolist TRUE "Pagina_Web" FALSE "URL_streaming" `

if [ $? -eq 0 ]; then

usuario=`whoami`

archivo=`zenity --filename=/home/$usuario/G\ Radio/ --file-selection --title="Seleccione el audio de entrada a la cadena"` 
if [ $? -eq 0 ]
then
        case $? in
                 0)
                        echo "\"$archivo\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
else
archivo="noarchivo"
fi

if [ $opcion = "Pagina_Web" ]; then
		url=`zenity --entry --text="Introduzca la dirección del sitio WEB ej: http://www.radiopublica.ec/" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		horastr=`zenity --entry --text="Introduzca la hora de inicio ej: 10:30" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		duracion=`zenity --entry --text="Ingrese la duración en segundos" --title="Duración"`
		if [ $? -ne 0 ]
		then
		exit      
		fi
		nombrebase=`echo "$archivo" |awk -F/ '{print $NF}'`
		archivo= `echo $archivo` 

		cola=`date +%s`

		  navegador=`which google-chrome`
		  if [ $navegador != "" ]; then
		  navegador="google-chrome"
		  else
		  navegador="firefox"
		  fi
		  #echo $navegador
		  


		echo "#!/bin/bash" > ~/.gradio/data/streaming/str$cola.sh
		echo "export DISPLAY=:0.0" >> ~/.gradio/data/streaming/str$cola.sh

		echo "echo "$nombrebase" > ~/.gradio/data/tmp/currentsong.txt" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo "$nombrebase" > ~/CurrentSong.txt" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo '<font size='1' color='red'><b>$nombrebase</b></font>' > ~/.gradio/data/tmp/currentsongweb" >> ~/.gradio/data/streaming/str$cola.sh
		echo "archduracion=`mplayer -ao null -identify -frames 0 \"$archivo\" 2>&1 | grep ID_LENGTH|awk -F\"=\" '{print $2}'|awk -F "." '{print $1}'`" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo 00:00:\$archduracion > ~/.gradio/data/tmp/duracion" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/pausa.sh" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/countdown.sh &" >> ~/.gradio/data/streaming/str$cola.sh
		echo "mplayer \"$archivo\"" >> ~/.gradio/data/streaming/str$cola.sh
		echo "killall -9 panico.sh" >> ~/.gradio/data/streaming/str$cola.sh
		echo "killall -9 countdown.sh" >> ~/.gradio/data/streaming/str$cola.sh
		echo "killall -9 $navegador" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo $url > ~/.gradio/data/tmp/currentsong.txt" >> ~/.gradio/data/streaming/str$cola.sh
		echo "export DISPLAY=:0.0" >> ~/.gradio/data/streaming/str$cola.sh
		echo "$navegador $url &" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo 00:00:$duracion > ~/.gradio/data/tmp/duracion" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/countdown.sh &" >> ~/.gradio/data/streaming/str$cola.sh
		echo "sleep $duracion" >> ~/.gradio/data/streaming/str$cola.sh
		echo "killall -9 $navegador" >> ~/.gradio/data/streaming/str$cola.sh
		echo "killall -9 chrome" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/despausa.sh" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/siguiente.sh" >> ~/.gradio/data/streaming/str$cola.sh
		chmod 755 ~/.gradio/data/streaming/str$cola.sh
		at -f ~/.gradio/data/streaming/str$cola.sh $horastr > ~/.gradio/data/tmp/streaming 2>&1
		zenity --info --text "ha programado la página $url con $duracion segundos de duración a las $horastr"
else
		url=`zenity --entry --text="Introduzca la dirección de streaming ej: http://91.121.159.50:8000/rvtnapo" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		horastr=`zenity --entry --text="Introduzca la hora de inicio ej: 10:30" --title="Streaming"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		duracion=`zenity --entry --text="Ingrese la duración en segundos" --title="Duración"`
		if [ $? -ne 0 ]
		then
		exit
		fi
		cola=`date +%s`
		echo "#!/bin/bash" > ~/.gradio/data/streaming/str$cola.sh
		echo "export DISPLAY=:0.0" >> ~/.gradio/data/streaming/str$cola.sh
		echo "killall -9 panico.sh" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/pausa.sh" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo "Intro Cadena" > ~/.gradio/data/tmp/currentsong.txt" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo "Intro Cadena" > ~/CurrentSong.txt" >> ~/.gradio/data/streaming/str$cola.sh
		echo "archduracion=`mplayer -ao null -identify -frames 0 \"$archivo\" 2>&1 | grep ID_LENGTH|awk -F\"=\" '{print $2}'|awk -F "." '{print $1}'`" >> ~/.gradio/data/streaming/str$cola.sh		
		echo "echo 00:00:\$archduracion > ~/.gradio/data/tmp/duracion" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/countdown.sh &" >> ~/.gradio/data/streaming/str$cola.sh
		echo "xterm -iconic  -fg Green -bg Red -title \"$archivo\"  -geometry 40x1-0+0 -e mplayer -volume 100 \"$archivo\"" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo 00:00:$duracion > ~/.gradio/data/tmp/duracion" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/countdown.sh &" >> ~/.gradio/data/streaming/str$cola.sh
		echo "echo $url > ~/.gradio/data/tmp/currentsong.txt" >> ~/.gradio/data/streaming/str$cola.sh
		echo "xterm -iconic  -fg Green -bg Red -title "$url"  -geometry 80x1-0+0 -e mplayer -volume 100 -endpos $duracion $url"  >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/despausa.sh" >> ~/.gradio/data/streaming/str$cola.sh
		echo "~/.gradio/bin/siguiente.sh" >> ~/.gradio/data/streaming/str$cola.sh
		chmod 755 ~/.gradio/data/streaming/str$cola.sh

		at -f ~/.gradio/data/streaming/str$cola.sh $horastr > ~/.gradio/data/tmp/streaming 2>&1
		zenity --info --text "ha programado la página $url con $duracion segundos de duración a las $horastr"
fi
fi
