#/bin/bash
wget -O ~/.gradio/data/tmp/tiempo-clima http://www.accuweather.com/es/ec/tena/124695/daily-weather-forecast/124695?day=1 > /dev/null 2>&1
minimo=`grep "<strong class=\"temp\">"  ~/.gradio/data/tmp/tiempo-clima| sed s/'<strong class="temp">'//g|awk -F "<" {'print $7'}|head -n 1|sed s/"span>"//g|awk {'print $2'}`  
maximo=`grep "<strong class=\"temp\">"  ~/.gradio/data/tmp/tiempo-clima| sed s/'<strong class="temp">'//g|awk -F "<" {'print $1'}|head -n 1""|sed s/" "//g` 
clima="Temperatura en Tena-Ecuador: Mínimo "$minimo"°C  Máximo "$maximo"°C"

wget -O ~/.gradio/data/tmp/tiempo-clima http://www.accuweather.com/es/ec/quito/129846/weather-forecast/129846 > /dev/null 2>&1
sensacion=`grep RealFeel\&reg ~/.gradio/data/tmp/tiempo-clima |awk '{print $3}'|awk -F \& '{print $1}'`
climaq="Sensación térmica en Quito-Ecuador: "$sensacion"°C"
echo  "$clima ------ $climaq" |twidge update 
#twidge update unicode "$clima ------- $climaq" &

