#!/bin/bash
#Evalúa el tiempo acumulado de comerciales
hh=0
while [ $hh -le 23 ]; do
echo "0" > ~/.gradio/data/tmp/$hh
hh=$(($hh+1))
done

