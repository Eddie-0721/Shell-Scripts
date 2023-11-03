#!/bin/bash

# 备份目录列表
backup_dirs=(
  #1.配置文件
  "/home/algo/unily_share/unily_fenghe_1/broker.json"
  "/home/algo/unily_share/unily_fenghe_1/sync.json"
  "/home/algo/unily_share/unily_fenghe_2/broker.json"
  "/home/algo/unily_share/unily_fenghe_2/sync.json"
  "/home/algo/unily_share/start_config.json"
  #2.二进制程序

  #3.bin目录
  "/home/algo/unily_share/control"

  #4.lib目录
  "/home/algo/unily_share/unily_fenghe/lib"
  "/home/algo/unily_share/unily_zhiyuan/lib"
  #5.config目录

  #6.脚本
)


# 备份主机
local_interface="192.168.30.2"
# 备份目标目录
#backup_dest=$(pwd)
backup_dest=/home/algo/auto_backups/$(date +%Y-%m-%d)
current_dir=$(pwd)
GREEN='\033[0;32m'
Red='\033[0;31m'
NC='\033[0m'


# 备份函数
backup_directory() {
  local dir_name=$(basename "$(dirname "${dir}")")
  local file_name=$(basename "${dir}")
  local backup_file="${backup_dest}/${dir_name}-${file_name}.tar.gz"
  echo "Current backup time: $(date "+%Y-%m-%d %H:%M:%S")"
  echo -e "back_path: ${dir}"
  echo "back_file: ${backup_file}"
  tar -zcvf "${backup_file}" -C "$(dirname "${dir}")" "$(basename "${dir}")"

  if [ -f "${backup_file}" ]; then
    echo -e "${GREEN}Backup successfully created!${NC}\n"
  else
    echo -e "${Red}Backup failure!${NC}\n"
    exit 1
  fi
}
echo "Create: $backup_dest"
echo "Local_Interface: $local_interface"
mkdir $backup_dest
for dir in "${backup_dirs[@]}"; do
  backup_directory "${dir}"
done
