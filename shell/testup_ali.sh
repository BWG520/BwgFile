WORK_PATH="./"
UPFILE_NAME="up_file.txt"
DATE=`date +%Y-%m-%d`
TIME=`date +%Y-%m-%d" "%H:%M:%S`
WEB_SERVERS="www1 www2 www3"
#WEB_SERVERS="192.168.10.101 192.168.10.107  "
LOCATE_DIR="/server/www/www9.quwan.com/"
SUB_STR="2013-08-03/"
UPFILE=`sed '/^$/d' ${WORK_PATH}${UPFILE_NAME}`



#scp -ir   /data/server/apache/htdocs/quwan.com/www2/index.html   www0.quwan.com:/server/apache/htdocs/quwan.com/www2/index.html
# 将需要上线的文件放到 up_file.txt 中， 每行一个文件，不要有空行，  有新目录上线时，需要手动到线上创建目录（注意权限）

WEB_SERVERS_NEW="quwanweb1.quwan.com quwanweb2.quwan.com  quwanweb3.quwan.com"
SERVER_DIR_NEW="/server/www/quwan.com/"

while read i 
do  
    if [ "/" = ${i:${#i}-1:1} ]
    then
        echo ${i} "上传文件列表中有为创建的文件夹"
        exit
    fi
	
    ver=`echo $i  | awk '{print $2}'`
	file=`echo ${i#*${SUB_STR}}  | awk '{print $1}'`
	if [ "$ver" == '' ];then
		svn up  ${LOCATE_DIR}$file
	else 
		svn up  ${LOCATE_DIR}$file  -r  $ver
	fi
done <  ${WORK_PATH}${UPFILE_NAME}

for j in $WEB_SERVERS_NEW
do
	while read i
    do
        if [ "/" = ${i:${#i}-1:1} ]
        then
            echo ${i} "上传文件列表中有为创建的文件夹"
            exit
        fi
		file=`echo ${i#*${SUB_STR}}  | awk '{print $1}'`
		scp -rp ${LOCATE_DIR}$file  ${j}:${SERVER_DIR_NEW}$file
    done  < ${WORK_PATH}${UPFILE_NAME}
done

WEB_SERVERS_NEW="quwanlb2.quwan.com"
SERVER_DIR_NEW="/backup/107/quwan_com/www1/public_html/"

for j in $WEB_SERVERS_NEW
do
	while read i
    do
        if [ "/" = ${i:${#i}-1:1} ]
        then
            echo ${i} "上传文件列表中有为创建的文件夹"
            exit
        fi
		file=`echo ${i#*${SUB_STR}}  | awk '{print $1}'`
		scp -rp ${LOCATE_DIR}$file  ${j}:${SERVER_DIR_NEW}$file
    done <  ${WORK_PATH}${UPFILE_NAME}
done


#刷新cdn
while read i
do  
    echo ${i#*${SUB_STR}} | grep  -Ei "txt|js|css|png|jpg|jpeg|gif|htm|html" &>/dev/null
	file=`echo ${i#*${SUB_STR}}  | awk '{print $1}'`
    if [ $? -eq 0 ]
    then
        /usr/local/qiniu/reflush.sh  $file
    fi
    
done  < ${WORK_PATH}${UPFILE_NAME}

