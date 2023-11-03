#!/bin/bash
add_user=""
userdel -f -r $add_user
groupadd $add_user
useradd -g $add_user -s /bin/false -d /sftpalgo/$add_user $add_user
#echo "请输入 $add_user的密码"
passwd $add_user
mkdir -p /sftpalgo/$add_user
chown $add_user:$add_user /sftpalgo/$add_user
chmod 700 $add_user
echo "The $add_user user is created"