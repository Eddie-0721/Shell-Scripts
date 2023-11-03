#!/bin/bash
current_dir=$(pwd)
back_file=$current_dir/ifconfig_$(date +%Y%m%d).txt
while true; do
    current_time=$(date +"%T")
    echo "Time：$current_time" >> $back_file
    /usr/sbin/ifconfig p2p1 >> $back_file
    /usr/sbin/ifconfig p2p2 >> $back_file
    sleep 300
done

