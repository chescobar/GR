#!/bin/bash
usuario=`whoami`
tema=`cat /home/$usuario/.gradio/data/tmp/drop|awk -F '{print $1}'|sed s/'file\:\/\/'/""/g|sed s/\%20/\ /g|sed s/"%C3%91"/"Ñ"/g|sed s/"%C3%B1"/"ñ"/g|sed s/"%C2%B4"/\´/g|sed s/"%C2%AA"/"ª"/g`
echo "tema:" $tema
        case $? in
                 0)
                        echo "\"$tema\" seleccionado.";;
                 1)
                        echo "No ha seleccionado ningún archivo.";;
		
                -1)
                        echo "No ha seleccionado ningún archivo.";;
        esac
comercialeslist=$((`grep -c $ ~/.gradio/data/tmp/comercialeslist`*1))

extension="${tema##*.}"
validado=`grep -i $extension ~/.gradio/data/extensiones`
if [ "$validado" != "" ]; then
comercialeslist=$((`grep -c $ ~/.gradio/data/tmp/comercialeslist`*1))
nombrebase=`echo "$tema" |awk -F/ '{print $NF}'`
                duracion=`mplayer -ao null -identify -frames 0 "$tema" 2>&1 | grep ID_LENGTH|awk -F"=" '{print $2}'|awk -F "." '{print $1}'`
                duracionview=$(printf '%dh:%dm:%ds\n' $(($duracion/3600)) $(($duracion%3600/60)) $(($duracion%60)))
echo comercialeslist: $comercialeslist
	echo "$tema" >> ~/.gradio/data/tmp/comercialeslist
	echo "$nombrebase" "[""$duracionview""]" >> ~/.gradio/data/tmp/comercialeslistwebg3
	echo "<font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" ~/.gradio/data/tmp/comercialeslistweb
fi
