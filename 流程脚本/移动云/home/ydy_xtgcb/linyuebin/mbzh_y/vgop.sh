#!/bin/bash

cd /home/ydy_xtgcb/linyuebin/mbzh_y/
bash /home/ydy_xtgcb/linyuebin/mbzh/mbzb.sh &
pid1=$!

bash /home/ydy_xtgcb/linyuebin/mbzh_y/mbzb.sh &
pid2=$!

# 只等待这两个特定的进程
wait $pid1 $pid2

bash /home/ydy_xtgcb/linyuebin/mbzh_y/vgop_rate.sh
