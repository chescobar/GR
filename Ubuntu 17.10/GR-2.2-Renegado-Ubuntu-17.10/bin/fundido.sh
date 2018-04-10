#!/bin/bash
mix=`zenity --list  --title="Fundido" --width "25" --height "200" --text="Tiempo de fundido" --column="Segundos" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"|awk -F "|" '{print $1}'`

if [ "${mix:-NULL}" != "NULL" ]; then
#if [[ "$mix" != "" ]]; then
echo $mix > ~/.gradio/data/mix.txt
else
echo "0" > ~/.gradio/data/mix.txt
fi
