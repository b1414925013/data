#!/bin/bash
ip=10.18.42.1

ping -c1 $ip &>/dev/null
#上一步的返回值是否为0（成功）
if [ $? -eq 0 ]
then
	echo "$ip is up."
else
    echo "$ip is down."
fi