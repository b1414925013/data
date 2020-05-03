#!/bin/bash

#$1 执行脚本的启动第一个参数
ping -c1 $1 &>/dev/null
#上一步的返回值是否为0（成功）
if [ $? -eq 0 ]
then
	echo "$1 is up."
else
    echo "$1 is down."
fi