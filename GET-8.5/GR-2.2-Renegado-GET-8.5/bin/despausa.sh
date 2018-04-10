#!/bin/bash
echo pause > ~/.gradio/data/tmp/slave.txt
kill -SIGCONT `cat ~/.gradio/data/pid`
kill -SIGCONT `pidof sleep`

