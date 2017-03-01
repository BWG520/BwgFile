#!/bin/bash
#
#

#检测字段
#获取线上
mysql -h182.92.224.201   -uphy -p811261571a649efb48dc   -e "select TABLE_NAME,COLUMN_NAME from   information_schema.COLUMNS   where  TABLE_SCHEMA='scn'"   > /tmp/scn.txt
#获取测试12
mysql -udba -p -h192.168.0.12 -P3307  -p123456 -e "select TABLE_NAME,COLUMN_NAME from   information_schema.COLUMNS   where  TABLE_SCHEMA='scn'" > /tmp/test_nb.txt

#比较
echo  '测试多的字段'
diff /tmp/scn.txt /tmp/test_nb.txt  | grep '>'
echo 
echo

sleep 2

echo '线上多的字段'
diff /tmp/scn.txt /tmp/test_nb.txt  | grep '<'
echo 
echo

#检测表内容
mysql -h182.92.224.201   -uphy -p811261571a649efb48dc   -e "set names utf8;select  't_ac_menuitem',MI_AuthorityList,MI_Name   from scn.t_ac_menuitem " >/tmp/tab.txt
mysql -h182.92.224.201   -uphy -p811261571a649efb48dc   -e "set names utf8;select 't_og_personalauthoritymanagement',ID,OP_Name,OP_Code,FollowOpCode    from  scn.t_og_personalauthoritymanagement" >>/tmp/tab.txt
mysql -udba -p -h192.168.0.12 -P3307  -p123456 -e "set names utf8;select  't_ac_menuitem',MI_AuthorityList,MI_Name   from scn.t_ac_menuitem " >/tmp/tab_nb.txt
mysql -udba -p -h192.168.0.12 -P3307  -p123456 -e "set names utf8;select 't_og_personalauthoritymanagement',ID,OP_Name,OP_Code,FollowOpCode    from  scn.t_og_personalauthoritymanagement " >>/tmp/tab_nb.txt

echo '测试t_ac_menuitem，t_og_personalauthoritymanagement内容不同的'
diff /tmp/tab.txt /tmp/tab_nb.txt  | grep '>'
echo
echo

sleep 2

echo '线上t_ac_menuitem，t_og_personalauthoritymanagement内容不同的'
diff /tmp/tab.txt /tmp/tab_nb.txt  | grep '<'
echo
echo

rm -f /tmp/tab.txt   /tmp/tab_nb.txt /tmp/test_nb.txt /tmp/scn.txt
