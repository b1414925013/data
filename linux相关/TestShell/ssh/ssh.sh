#!/bin/bash

set ip 192.168.17.133
set user root
set password itcast
set timeout 5

spawn ssh $user@$ip

expect {
	"yes/no" { send "yes\r"; exp_continue }
	"password:" { send "$password\r" };
}

interact