#!/bin/bash

email="jacksoulmate@163.com"
interface="192.168.30.2"
cpxx_name="cpxx0201$(date '+%m%d').txt"
output="
###############Warning###############
告警主机: $interface
告警时间: $Time
告警等级: Warning
告警信息: [$cpxx_name 文件不存在！]
#####################################
"
cpxxpath="/home/algo/StaticData/cpxx0201$(date '+%m%d').txt"
sleep 30
Time=$(date "+[%Y-%m-%d %H:%M:%S]")
if [ -e "$cpxxpath" ]
then
   echo "$Time [INFO] [cpxxfile] The file $cpxx_name exists."
else
   echo "$Time [ERROR] [cpxxfile] The file $cpxx_name does not exist."
   echo -e "$output" | mail -s "The cpxx file does not exist" wenpeng.ouyang@infinitequant.cn yiming.sheng@infinitequant.cn zhidi.wang@infinitequant.cn sheng.wang@infinitequant.cn
fi

