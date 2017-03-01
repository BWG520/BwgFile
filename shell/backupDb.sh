#!/bin/bash 
# This script run at 03:00
# db  replication delay 3 hours   
# date: 2015-06-04 by phy
# backup needs reload ,select  ,LOCK TABLES  privileges

BackupPath="/server/backup/db_backup/"

OldDbFile="$BackupPath"scn_$(date +%Y-%m-%d --date='10 days ago').tgz
NewDbFile="$BackupPath"scn_$(date +%Y-%m-%d).tgz

cd $BackupPath && mysqldump -ubackup -pbackupScn -P33060 -S /tmp/mysqld33060.sock  --databases scn > scn_$(date +%Y-%m-%d).sql
cd $BackupPath && tar czf ${NewDbFile} scn_$(date +%Y-%m-%d).sql

rm -f scn_$(date +%Y-%m-%d).sql
rm -f ${OldDbFile}




