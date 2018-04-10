#!/bin/bash
modo=`cat ~/.gradio/data/tmp/modo`
if [[ $modo = 1 ]]; then
~/.gradio/bin/siguiente.sh
else
b=`ps -e |grep playmancom.sh`
if [ "$b" = "" ]; then 
echo "0" > ~/.gradio/data/tmp/stopcomercial
~/.gradio/bin/playmancom.sh
else
echo "0" > ~/.gradio/data/tmp/stopcomercial
fi
fi
