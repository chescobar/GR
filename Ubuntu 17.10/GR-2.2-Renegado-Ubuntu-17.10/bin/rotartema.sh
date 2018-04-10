#!/bin/bash
usuario=`whoami`
ultimo=`tail -n 1 /home/$usuario/.gradio/data/tmp/playlist`
echo $ultimo
sed -i "1i $ultimo" /home/$usuario/.gradio/data/tmp/playlist
sed -i '$d' /home/$usuario/.gradio/data/tmp/playlist

ultimo=`tail -n 1 /home/$usuario/.gradio/data/tmp/playlistweb`
sed -i "1i $ultimo" /home/$usuario/.gradio/data/tmp/playlistweb
sed -i '$d'  /home/$usuario/.gradio/data/tmp/playlistweb

ultimo=`tail -n 1 /home/$usuario/.gradio/data/tmp/playlistg3`
sed -i "1i $ultimo" /home/$usuario/.gradio/data/tmp/playlistg3
sed -i '$d' /home/$usuario/.gradio/data/tmp/playlistg3
/home/$usuario/.gradio/bin/cartucho.sh
exit 0
