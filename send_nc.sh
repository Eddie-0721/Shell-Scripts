#!/bin/bash
# 发送端

# 常量
readonly SCRIPT_NAME=$(basename "$0")
readonly LOG_PREFIX=$(date +"[%Y-%m-%d %H:%M:%S]")
readonly SERVER_IP="192.168.30.50"  # 接收端 IP 地址
readonly SERVER_PORT="16009"  # 接收端监听端口号

#tar -zcvf $LOG_PREFIX_dir.tgz $FILE_PATHS

file1= "/root/shell-tools/send_receive/cpxx_baseinfo/cpxx0201$(date '+%m%d').txt"
file2= "/root/shell-tools/send_receive/cpxx_baseinfo/baseinfo.txt"
#tgz1="$LOG_PREFIX_dir.tgz"
#echo $tgz1

readonly FILE_PATHS=(
  "/root/shell-tools/sed_receive/$file1"
  "/root/shell-tools/sed_receive/$file2"
)

#md5_1=$(md5sum "$FILE_PATHS" | awk '{print $1}')

# 函数
log() {
  local msg=$1
  local level=$2
  echo -e "$LOG_PREFIX [$level] $msg"
}

# 程序主逻辑
for file_path in "${FILE_PATHS[@]}"
do
  # 检查文件是否存在
  if [ ! -e "$file_path" ]
  then
    log "要发送的文件 $file_path 不存在！" "ERROR"
    continue
  fi

  # 开始发送文件
  sleep 10
  log "开始发送文件 $file_path..." "INFO"
  /usr/bin/nc "$SERVER_IP" "$SERVER_PORT" < "$file_path"

  # 检查发送结果是否成功
  if [ $? -eq 0 ]
  then
    log "文件 $file_path 发送成功！" "INFO"
    #log "MD5值=$md5_1" "INFO" 
  else
    log "文件 $file_path 发送失败！" "ERROR"
  fi
done
