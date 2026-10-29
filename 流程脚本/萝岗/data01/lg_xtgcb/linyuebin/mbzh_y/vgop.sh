#!/bin/bash

cd /data01/lg_xtgcb/linyuebin/mbzh_y/
sudo bash /data01/lg_xtgcb/linyuebin/mbzh/mbzb.sh &
pid1=$!

sudo bash /data01/lg_xtgcb/linyuebin/mbzh_y/mbzb.sh &
pid2=$!

# 只等待这两个特定的进程
wait $pid1 $pid2

sudo bash /data01/lg_xtgcb/linyuebin/mbzh_y/vgop_rate.sh
