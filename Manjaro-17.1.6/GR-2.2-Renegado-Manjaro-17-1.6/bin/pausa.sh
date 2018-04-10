#!/bin/bash
echo pause > ~/.gradio/data/tmp/slave.txt
kill -SIGSTOP `cat ~/.gradio/data/pid`
kill -SIGSTOP `pidof sleep`

