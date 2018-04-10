#!/bin/bash
killall -9 countdown.sh
~/.gradio/bin/countdown.sh &
mplayer -fs -geometry 1500 -vf bmovl=0:0:~/.gradio/data/tmp/logo.fifo  -sub /home/cescobar/.gradio/data/tmp/teletexto.srt -ass-color BF5C00 -ass-border-color FFFFFF00   -af volnorm "/home/cescobar/Vídeos/videoclips/HD/Calle 13 - El Aguante.mp4"
sleep 0.5
echo 0 > ~/.gradio/data/tmp/repitiendo
