#!/bin/bash

#字体颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

#当前目录配置（可默认）
current_dir=$(pwd)
#总线跑批任务高收益券池目录(自行配置)
stock_dir="/home/algo/stockpool"

#SFTP服务器地址配置
url_sftp="https://222.71.222.250:65443"
params_sftp="--no-check-certificate --http-user=sftpalgo --http-passwd=hw2dBxzB"


#SFTP目录参数（按需打开）
######牛股王1003######
#sftp服务获取文件参数（sftp服务器文件目录）
ngw1003_sftpfile="/ngw1003/牛股王T0券池$(date +%Y%m%d).csv"
#算法商上传券池文件参数（获取到本地后原始算法商文件目录）
ngw1003_1="$current_dir/牛股王T0券池$(date +%Y%m%d).csv"
#总线获取算法商券池文件参数（最终总线获取文件目录）
ngw1003_2="$stock_dir/1003$(date +%Y%m%d).csv"

#获取算法商高收益券池
wget_sftfile(){
	#获取前清理算法商高收益券池文件
	#rm -rvf $ngw1003_1 $zc1005_1 $hx1006_1 $ngw1003_2 $zc1005_2 $hx1006_2

	######牛股王1003######
	/bin/wget $url_sftp$ngw1003_sftpfile $params_sftp
	echo "sftp wget file: $ngw1003_1 time: $(date "+%Y-%m-%d %H:%M:%S")"
}

#转换为总线可读取文件名格式的高收益券池文件
rename_sftpfile(){
	######牛股王1003######
        mv $ngw1003_1 $ngw1003_2 > /dev/null 2>&1
        rm -rvf $ngw1003_1
}

#判断总线可读取文件名是否存在总线配置目录（需与总线跑批任务配置保持一致）
if_sftpfile(){
	######牛股王1003######
	if [ -f "$ngw1003_2" ]; then
	  echo "local path: $ngw1003_2 exist!"
	  echo -e "${GREEN}Wget Successful!${NC}\n"
	else
	  echo -e "local path: $ngw1003_2 not exist!"
	  echo -e "${RED}Wget failed!${NC}\n"
	  exit 1
	fi
}

wget_sftfile
sleep 2
rename_sftpfile
if_sftpfile
