#!/bin/bash
function countdown
{
        local OLD_IFS="${IFS}"
        IFS=":"
        local ARR=( $1 )
        local SECONDS=$((  (`echo ${ARR[0]}|sed s/^0//g` * 60 * 60) + (`echo ${ARR[1]}|sed s/^0//g` * 60) + `echo ${ARR[2]}|sed s/^0//g`  ))
        local START=$(date +%s)
        local END=$((START + SECONDS))
        local CUR=$START

        while [[ $CUR -lt $END ]]
        do
                CUR=$(date +%s)
                LEFT=$((END-CUR))

                a=`printf "\r%02d:|%02d:|%02d" \
                        $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60))`
		echo $a|sed 's/ |/:/g' > ~/.gradio/data/tmp/avance
		web=`echo $a|sed 's/|/:/g'`
		echo "<font color='red' size='24'><b>$web</b></font>" > ~/.gradio/data/tmp/avanceweb
                sleep 1
        done
        IFS="${OLD_IFS}"
        echo "        "
}
contador=`cat ~/.gradio/data/tmp/duracion`
countdown "$contador"
#countdown "03:00:00"
