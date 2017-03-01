#!/bin/bash
#
#

num=$1

if [ "$num" == "" ];then
	num=16
fi
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c $num| xargs
