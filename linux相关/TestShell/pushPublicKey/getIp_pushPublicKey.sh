#!/bin/bash

#覆盖（置空）文件内容
>ip.txt
password=itcast

#判断是否存在expect命令
rpm -q expect &>/dev/null
if [ $? -ne 0 ];then
	yum -y install expect
fi

#判断是否存在公匙
if [ ! -f ~/.ssh/id_rsa ];then
	ssh-keygen -P "" -f ~/.ssh/id_rsa
fi

#推送公匙
for i in {2..254}
do
	{
		ip=192.168.17.$i
		ping -c1 -W1 $ip &>/dev/null
		if [ $? -eq 0 ];then
			echo "$ip" >> ip.txt
			/usr/bin/expect <<-EOF
			set timeout 10
			spawn ssh-copy-id $ip
			expect {
				"yes/no" { send "yes\r"; exp_continue }
				"password:" { send "$password\r" }
			}
			expect eof
			EOF
		fi
	}&
done
wait
echo "finish...."
