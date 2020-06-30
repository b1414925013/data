#!/bin/bash
source_date=0
dest_date=0
main()
{
    if [ $# -eq 2 ]
    then
        echo "args cnt equal 2"
        # 格式 YYYYMMDDHH0000
        source_date=$1
        dest_date=$2
    fi
	copyTaskFile
}

copyTaskFile() 
{
	echo "111111"
	copyFile
}

copyFile()
{
	echo "222222"
}

main $@

# 方法调用demo