#!/bin/bash
#
#mysql select count for zabbix 


#mysql -ucs -e "show global status where Variable_name in('com_select','com_insert','com_delete','com_update','uptime');"  
file="/tmp/selectForZabbix.txt"

#获取上次的查询次数和服务器运行时间
selectF=`grep  'Questions'  $file | awk '{print $2}'`
timeF=`grep  'Uptime'  $file | awk '{print $2}'`



if [ "$selectF" == ""  ];then
	echo 1
	mysql -ucs -e "show global status where Variable_name in('Questions','uptime');"   > $file
	exit
fi

mysql -ucs -e "show global status where Variable_name in('Questions','uptime');"   > $file


selectL=`grep  'Questions'  $file | awk '{print $2}'`
timeL=`grep  'Uptime'  $file | awk '{print $2}'`


#计算
select=`echo "scale=2;($selectL-$selectF-1)/($timeL-$timeF)"  | bc `
echo $select

#格式化输出
printf "%.2f" $select
