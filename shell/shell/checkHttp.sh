#!/bin/bash
#
#
#$1 is url  $2 is content
now=`date "+%Y-%m-%d %H:%M:%S"`
curl $1 &>/dev/null

if [ $? -ne 0 ];then
	/usr/bin/sendmail "$2 $1 http warning" 285059204@qq.com "$now"
	/usr/bin/sendmail "$2 $1 http warning" penghaiyang@quwan.com "$now"
fi
