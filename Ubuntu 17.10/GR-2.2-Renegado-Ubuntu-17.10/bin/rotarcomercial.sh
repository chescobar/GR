#!/bin/bash
usuario=`whoami`
ultimo=`tail -n 1 /home/$usuario/.gradio/data/tmp/comercialeslist`
echo $ultimo
sed -i "1i $ultimo" /home/$usuario/.gradio/data/tmp/comercialeslist
sed -i '$d' /home/$usuario/.gradio/data/tmp/comercialeslist

ultimo=`tail -n 1 /home/$usuario/.gradio/data/tmp/comercialeslistweb`
sed -i "1i $ultimo" /home/$usuario/.gradio/data/tmp/comercialeslistweb
sed -i '$d'  /home/$usuario/.gradio/data/tmp/comercialeslistweb

ultimo=`tail -n 1 /home/$usuario/.gradio/data/tmp/comercialeslistwebg3`
sed -i "1i $ultimo" /home/$usuario/.gradio/data/tmp/comercialeslistwebg3
sed -i '$d' /home/$usuario/.gradio/data/tmp/comercialeslistwebg3
exit 0
