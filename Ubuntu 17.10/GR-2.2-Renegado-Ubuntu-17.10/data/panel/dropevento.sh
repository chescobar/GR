#!/bin/bash
usuario=`whoami`
tema=`cat /home/$usuario/.gradio/data/tmp/drop|awk -F '{print $1}'|sed s/'file\:\/\/'/""/g|sed s/\%20/\ /g|sed s/"%C3%91"/"Ñ"/g|sed s/"%C3%B1"/"ñ"/g|sed s/"%C2%B4"/\´/g|sed s/"%C2%AA"/"ª"/g`
#tema=$tema|sed -e s/file:\/\///g|sed -e s/%20/\ /g
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
echo comercialeslist: $comercialeslist
	echo $tema >> ~/.gradio/data/tmp/comercialeslist
	echo $nombrebase >> ~/.gradio/data/tmp/comercialeslistwebg3
	echo "<font size='1' color='green'><b>`echo $tema|awk -F/ '{print $NF}'`</b></font></br>" ~/.gradio/data/tmp/comercialeslistweb
fi
