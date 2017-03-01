#!/bin/bash

size=`mysql -e "select round(sum(data_length/1024/1024),2) as data_length_MB   from information_schema.tables where  table_schema='test'  and table_name = 'test';"  | grep -v data_length_MB`

if [ $size -gt 200 ] ;then 
	mysql -e  "delete from test.test  limit 20000"
fi

 

