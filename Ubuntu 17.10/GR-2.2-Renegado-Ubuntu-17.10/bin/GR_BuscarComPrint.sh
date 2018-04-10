#!/bin/bash
# Establece el editor a usar
if [ -f /usr/bin/pluma ]
then
        EDITOR="pluma"
else
        if [ -f /usr/bin/leafpad ]
        then
                EDITOR="leafpad"
        else
		if [ -f /usr/bin/mousepad ]
		then
		        EDITOR="mousepad"
		else
                EDITOR="gedit"
		fi
        fi
fi

$EDITOR ~/.gradio/data/tmp/BuscarComSort

exit
