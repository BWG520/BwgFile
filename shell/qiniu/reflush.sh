#!/bin/bash
#
# 刷新七牛cdn 
# $1 为文件名
bin_path="/root/shell/qiniu/"

$bin_path/qrsctl    login   system@quwan.com    PcxE8fqHjPFVt7L
$bin_path/qrsctl   del   quwan $1

for i in `seq  1 7`;do
	$bin_path/qrsctl cdn/refresh quwan  http://i$i.quwan.com/$1
done

$bin_path/qrsctl cdn/refresh quwan  http://7xitbf.com2.z0.glb.qiniucdn.com/$1


