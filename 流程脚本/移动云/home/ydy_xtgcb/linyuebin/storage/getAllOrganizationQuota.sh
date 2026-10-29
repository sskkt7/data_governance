#!/bin/bash

basePath=/home/ydy_xtgcb/linyuebin/storage
tmpFile=$basePath/orgResult/catalog.txt
[ -d $basePath/orgResult ] || mkdir -p $basePath/orgResult
csvFile=$basePath/orgResult/orgResult`date +%Y%m%d`.csv
echo $csvFile

alertValue=96
echo "租户,项目组,目录,配额,余量,使用情况,是否告警,租户管理员,电话,邮箱" > $csvFile

for i in `cat $tmpFile`
do
	orgName=`echo $i|awk -F, '{print $1}'`
	orgPath=`echo $i|awk -F, '{print $2}'`
	result=`sh $basePath/hdfsQuotaCheck.sh $orgPath $alertValue`
	username=`echo $i|awk -F, '{print $3}'`
	Telnum=`echo $i|awk -F, '{print $4}'`
	Email=`echo $i|awk -F, '{print $5}'`
	groupname=`echo $i|awk -F, '{print $6}'`
	rundate=`date "+%F %T"`
	datatime=`date +%Y%m%d`
	mem_peie=`echo $result | awk -F"," '{print $1}'`
	mem_use=`echo $result | awk -F"," '{print $2}'`
	utilization=`echo $result | awk -F"," '{print $3}'`

	echo $orgName,$groupname,$orgPath,$result,$username,$Telnum,$Email,$datatime,'ydy' >> $csvFile
done

cp $csvFile /home/ydy_xtgcb/linyuebin/storage/orgResult/ts_date/
