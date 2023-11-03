#!/bin/bash

#接收端
log_date=$(date +%Y-%m-%d-%H:%M:%S)
#date_name="/home/algo/cpxx_dir/cpxx0201$(date '+%m%d').txt"
file_path_01="/home/algo/cpxx_dir/cpxx0201$(date '+%m%d').txt"
file_path_02="/home/algo/cpxx_dir/baseinfo.txt"

#sleep 5

/usr/bin/nc -l -p 16009 > $file_path_01
#sleep 10
/bin/cp -a $file_path_01 /home/algo/unily_share/unily_fenghe/initfiledir/
/bin/cp -a $file_path_01 /home/algo/unily_share/unily_zhiyuan/initfiledir/

scp $file_path_01 algo@192.168.30.3:/home/algo/StaticData
#if [ -e "$file_path_01" ] && [ -s "$file_path_01" ] then
#   echo "$log_date [INFO] $file_path_01 exist!"
#else
#   echo "$log_date [INFO] $file_path_01 nonexistence!"
#   exit 1
#fi


#if [ -e "$file_path_01" ] && [ -s "$file_path_01" ]
#then
#  echo "$log_date [INFO] $file_path_01 exist!"
#else
#  echo "$log_date [ERROR] $file_path_01 nonexistence!"
#fi

/usr/bin/nc -l -p 16010 > $file_path_02


#if [ -e "$file_path_02" ] && [ -s "$file_path_02" ] then
#   echo "$log_date [INFO] $file_path_02 exist!"
#else
#   echo "$log_date [INFO] $file_path_02 nonexistence!"
#   exit 1
#fi

if [ -e "$file_path_02" ] && [ -s "$file_path_02" ]
then
  echo "$log_date [INFO] $file_path_02 exist!"
else
  echo "$log_date [ERROR] $file_path_02 nonexistence!"
fi

pkill nc
