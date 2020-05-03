#!/bin/bash

#读取用户输入的值
read -p "Please input a ip: " ip

ping -c1 $ip &>/dev/null
#上一步的返回值是否为0（成功）
if [ $? -eq 0 ]
then
	echo "$ip is up."
else
    echo "$ip is down."
fi