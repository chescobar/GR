#!/bin/bash
usuario=`whoami`
sed -i '$d' /home/$usuario/.gradio/data/tmp/comercialeslist
sed -i '$d' /home/$usuario/.gradio/data/tmp/comercialeslistweb
sed -i '$d' /home/$usuario/.gradio/data/tmp/comercialeslistwebg3
exit 0
