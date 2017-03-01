#!/bin/bash
#
#自动拷贝日志执行
#2015-10-24 for data

Yesterday=`date +%Y%m%d`
Yesterday=`echo $Yesterday-1|bc`

scp  -i  /root/.ssh/op   wwapi:/server/logs/api/access_$Yesterday.log      /tmp/
scp  -i  /root/.ssh/op   /tmp/access_$Yesterday.log   wwzd1:/server/logs/api/
ssh -i /root/.ssh/op wwzd1 /server/phpfpm/bin/php /server/www/data.wanwu.com/script/apiLog.php
rm -f  /tmp/access_$Yesterday.log   
ssh -i /root/.ssh/op  wwzd1  rm -f   /server/logs/api/access_$Yesterday.log


scp  -i  /root/.ssh/op   wwdb1:/server/logs/mysql/slow_$Yesterday.log  /tmp/
scp  -i  /root/.ssh/op   /tmp/slow_$Yesterday.log   wwzd1:/server/logs/mysql/
ssh -i /root/.ssh/op wwzd1 /server/phpfpm/bin/php /server/www/data.wanwu.com/script/mysqlSlowLog.php
rm -f  /tmp/slow_$Yesterday.log
ssh -i /root/.ssh/op  wwzd1  rm -f   /server/logs/api/slow_$Yesterday.log




