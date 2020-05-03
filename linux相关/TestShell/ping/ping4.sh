#!/bin/bash

#如果用户没有加参数就提示
if [ $# -eq 0 ]
then
	echo "usage: `basename $0` file"
	exit
fi
#如果参数不是文件就提示
if [ ! -f $1 ]
then
	echo "error file!"
	exit
fi

for ip in `cat $1`
do
	ping -c1 $ip &>/dev/null
	#上一步的返回值是否为0（成功）
	if [ $? -eq 0 ]
	then
		echo "$ip is up."
	else
		echo "$ip is down."
	fi
done 