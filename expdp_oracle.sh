#!/bin/sh
#打印备份进度
echo "-----备份脚本开始启动-----------"
#加载oracle环境变量
source  /home/oracle/.bash_profile
#当前系统时间
dateTime=$(date +%Y%m%d)
#删除5天前的备份数据
days=5
date_tmp=$(date -d "${dateTime} $days days ago" "+%Y%m%d")
#修改备份存放路径,和数据泵路径一致即可
dump_dir=/home/oracle/dump 

#备份脚本，需按实际修改quant用户密码
echo "------开始quant用户备份-----"
expdp quant/quant@quant directory=dump_dir dumpfile=sse-quant$dateTime.dmp logfile=sse-quant$dateTime.log  schemas=quant

#进入备份目录
cd $dump_dir
#压缩dump文件
zip -r sse-quant$dateTime.zip sse-quant$dateTime.dmp
#删除备份的dump文件
rm -rf sse-quant$dateTime.dmp
echo '备份完成'

echo "-------开始清理历史备份数据--------"
rm -rf $dump_dir/sse-quant$date_tmp.zip
echo "rm -rf $dump_dir/sse-quant$date_tmp.zip"
rm -rf $dump_dir/sse-quant$date_tmp.log
echo "rm -rf $dump_dir/sse-quant$date_tmp.log"
echo "--------清理历史备份完成---------"
