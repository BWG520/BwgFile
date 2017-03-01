#!/bin/bash
#
#

ip=$1

if [ "$ip" == "" ];then
	url="ip.cn"
else
	url="http://ip.cn/index.php?ip="$ip
fi


curl $url 
