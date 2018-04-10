#!/bin/bash

#############################################################################
#  Gradio un programa de Automatización de radio programado en bash  #
#	  Última actualización: 28-Jul-2011    #
#############################################################################
#	     Projecto iniciado el 16 de junio de 2011	        #
#############################################################################
#############################################################################
#                                                                           #
# This program is free software; you can redistribute it and/or modify it   #
# under the terms of the GNU General Public License as published by the     #
# Free Software Foundation; either version 2 of the License or any later    #
# version.    #
#	    #
# This program is distributed in the hope that it will useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or     #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License     #
# for more details.	    #
#	    #
############################################################################# 
cat /dev/null > ~/.gradio/data/tmp/comercialeslist
#cat /dev/null > ~/.gradio/data/tmp/playlist
#cat /dev/null > ~/.gradio/data/tmp/playlistweb
cat /dev/null > ~/.gradio/data/tmp/comercialeslistweb
cat /dev/null > ~/.gradio/data/tmp/comercialeslistwebg3
#cat /dev/null > ~/.gradio/data/tmp/playlistg3
#sed -i "1d" ~/.gradio/data/tmp/playlist
sed -i "1d" ~/.gradio/data/tmp/comercialeslist
#sed -i "1d" ~/.gradio/data/tmp/playlistweb
sed -i "1d" ~/.gradio/data/tmp/comercialeslistweb
sed -i "1d" ~/.gradio/data/tmp/comercialeslistwebg3
#sed -i "1d" ~/.gradio/data/tmp/playlistg3
sleep 1
exit 0
