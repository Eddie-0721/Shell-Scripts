#!/bin/bash

# 编写脚本测试 192.168.4.0/24 整个网段中哪些主机处于开机状态,哪些主机处于关机
# 状态(for 版本)
lan="192.168.30"

for i in {1..12}
do 
 # 每隔0.3秒ping一次，一共ping2次，并以1毫秒为单位设置ping的超时时间
 ping -c 2 -i 0.3 -W 1 $lan.$i &>/dev/null
     if [ $? -eq 0 ];then
 echo "$lan.$i is up"
 else 
 echo "$lan.$i is down"
 fi
done