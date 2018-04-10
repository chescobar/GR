#!/bin/bash
usuario=`whoami`
sed -i '$d' /home/$usuario/.gradio/data/tmp/playlist
sed -i '$d' /home/$usuario/.gradio/data/tmp/playlistweb
sed -i '$d' /home/$usuario/.gradio/data/tmp/playlistg3
/home/$usuario/.gradio/bin/cartucho.sh
exit 0
