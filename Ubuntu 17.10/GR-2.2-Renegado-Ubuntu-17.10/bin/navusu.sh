#!/bin/sh
# Función para detectar escritorio y navegador predeterminado del usuario
navegador_usuario(){
echo $HOME
# Determina el escritorio..
ESCRI=$(echo $XDG_CURRENT_DESKTOP)

# Condicionales...
if [ $ESCRI = "XFCE" ]
then
	ARCHCONF="$HOME/.config/xfce4/helpers.rc"
	WB="WebBrowser"
	navegador=$(cat $ARCHCONF | grep $WB -m1 | awk -F"=" '{print $2}')
elif [ $ESCRI = "MATE" ]
then
	ARCHCONF="$HOME/.config/mimeapps.list"
	WB="x-scheme-handler/http"
	navegador=$(cat $ARCHCONF | grep $WB -m1 | awk -F"=" '{print $2}' | awk -F"." '{print $1}')
elif [ $ESCRI = "LXDE" ]
then
	ARCHCONF="$HOME/.config/lxsession/LXDE/desktop.conf"
	WB="webbrowser/command"
	navegador=$(cat $ARCHCONF | grep $WB -m1 | awk -F"=" '{print $2}')
else
	# Si no se conoce el escritorio se pone firefox o el que se quiera como predeterminado...
	navegador="firefox"
fi
zenity --info --text="Escritorio: $ESCRI\nArchivo de consulta: $ARCHCONF\nParametro de Busqueda: $WB\n\nNavegador: $navegador"
}
# Llamar función
navegador_usuario
