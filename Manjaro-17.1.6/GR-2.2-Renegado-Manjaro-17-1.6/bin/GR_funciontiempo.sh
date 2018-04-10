#!/bin/bash
mplayer -ao null -identify -frames 0 "$1" 2>&1 | grep ID_LENGTH|awk -F"=" {'print $2'}
