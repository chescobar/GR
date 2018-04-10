#! /bin/bash

#!/bin/bash 
#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#			  Última actualización: 28-Jul-2011		    #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	    		    #
#############################################################################
#############################################################################
#                                                                           #
# This program is free software; you can redistribute it and/or modify it   #
# under the terms of the GNU General Public License as published by the     #
# Free Software Foundation; either version 2 of the License or any later    #
# version.								    #
#									    #
# This program is distributed in the hope that it will useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
# for more details.							    #
#									    #
############################################################################# 

############################################################################# 
#                G Radio - Versión 2.2 - Renegado	                    # 
#                              Marzo 2018                                   #
############################################################################# 
usuario=`whoami`
sudo pacman -S --noconfirm mplayer 
sudo pacman -S --noconfirm ffmpeg2theora
sudo pacman -S --noconfirm ffmpeg
#sudo pacman -S --noconfirmlibav-tools
sudo pacman -S --noconfirm xterm

sudo pacman -S --noconfirm sox 
#sudo pacman -S --noconfirm libsox-fmt-all 
sudo pacman -S --noconfirm gambas3
sudo pacman -S --noconfirm gedit
sudo pacman -S --noconfirm at
sudo pacman -S --noconfirm imagemagick

sudo cp ../mplayer/*png /usr/share/mplayer/skins/clearplayer
sudo cp ../bin/cue /usr/local/bin/cue
sudo cp ../bin/buscar /usr/local/bin/buscar
sudo chmod 755 /usr/local/bin/buscar
sudo chmod 755 /usr/local/bin/cue
cp -R ../.mplayer/ /home/$usuario/

## Si no existen las carpetas para G Radio las crea

test ! -d /home/$usuario/.gradio/ && mkdir /home/$usuario/.gradio
test ! -d /home/$usuario/"G Radio"/ && mkdir /home/$usuario/"G Radio"
test ! -d /home/$usuario/"G Radio"/musica/ && mkdir /home/$usuario/"G Radio"/musica
test ! -d /home/$usuario/"G Radio"/comerciales/ && mkdir /home/$usuario/"G Radio"/comerciales && cp ../comerciales/* /home/$usuario/"G Radio"/comerciales/
test ! -d /home/$usuario/"G Radio"/efectos/ && mkdir /home/$usuario/"G Radio"/efectos && cp  ../efectos/* /home/$usuario/"G Radio"/efectos/
test ! -d /home/$usuario/"G Radio"/avances/ && mkdir /home/$usuario/"G Radio"/avances
test ! -d /home/$usuario/"G Radio"/fin-espacio-pub/ && mkdir /home/$usuario/"G Radio"/fin-espacio-pub && cp -R ../fin-espacio-pub/* /home/$usuario/"G Radio"/fin-espacio-pub/
test ! -d /home/$usuario/"G Radio"/inicio-espacio-pub/ && mkdir /home/$usuario/"G Radio"/inicio-espacio-pub && cp  -R ../inicio-espacio-pub/* /home/$usuario/"G Radio"/inicio-espacio-pub/
test ! -d /home/$usuario/"G Radio"/logo/ && mkdir /home/$usuario/"G Radio"/logo && cp  -R ../logo/* /home/$usuario/"G Radio"/logo/
test ! -d /home/$usuario/"G Radio"/Intercultural/ && mkdir /home/$usuario/"G Radio"/Intercultural && cp -R ../Intercultural/* /home/$usuario/"G Radio"/Intercultural/

## Copia los archivos binarios
test -d /home/$usuario/.gradio/bin/ && mv /home/$usuario/.gradio/bin /home/$usuario/.gradio/bin-respaldo-"`date +%d-%m-%Y`"
cp -R ../bin /home/$usuario/.gradio

## Copia los archivos de datos
test -d /home/$usuario/.gradio/data/ && test ! -d /home/$usuario/.gradio/data/botonera/ && cp -R ../data/botonera  /home/$usuario/.gradio/data
test -d /home/$usuario/.gradio/data/ && test ! -d /home/$usuario/.gradio/data/eventos-espera/ && cp -R ../data/eventos-espera  /home/$usuario/.gradio/data
test ! -d /home/$usuario/.gradio/data/ && cp -R ../data /home/$usuario/.gradio

## Logo
mkdir /home/$usuario/.gradio/img
mkfifo /home/$usuario/.gradio/data/tmp/slave.txt
mkfifo /home/$usuario/.gradio/data/tmp/logo.fifo
cp  ../instalar/*png  /home/$usuario/.gradio/img


## Acceso Directo
test -d /home/$usuario/Desktop/ && escritorio="Desktop"
test -d /home/$usuario/Escritorio/ && escritorio="Escritorio"

touch /home/$usuario/$escritorio/"G Radio".desktop
echo "#!/usr/bin/env xdg-open" > /home/$usuario/$escritorio/"G Radio".desktop

echo "[Desktop Entry]" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Version=1.0" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Type=Application" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Terminal=false" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Icon[es_EC]=/home/$usuario/.gradio/img/gradio.png" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Name[es_EC]=G Radio" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Exec=/home/$usuario/.gradio/bin/lanzador.sh" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Comment[es_EC]=G Radio" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Name=G Radio" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Comment=G Radio" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Icon=/home/$usuario/.gradio/img/gradio.png" >> /home/$usuario/$escritorio/"G Radio".desktop
echo "Categories=AudioVideo;Audio" >> /home/$usuario/$escritorio/"G Radio".desktop
chown -R $usuario:$usuario /home/$usuario/.gradio
chmod -R 755 /home/$usuario/.gradio
chmod 755 /home/$usuario/$escritorio/"G Radio".desktop
test ! -d /home/$usuario/.local/share/applications && mkdir /home/$usuario/.local/share/applications
cp /home/$usuario/$escritorio/"G Radio".desktop /home/$usuario/.local/share/applications/"G Radio".desktop
zenity --error --title="Advertencia" --text "Es recomendable que instale YAD manualmente (http://sourceforge.net/projects/yad-dialog/), que tiene la opción incorporada de búsqueda de archivos" 

zenity --info --text "Ha concluido el proceso de instalar GR, para ejecutar Gradio haga doble click en el ícono G en su $escritorio"

