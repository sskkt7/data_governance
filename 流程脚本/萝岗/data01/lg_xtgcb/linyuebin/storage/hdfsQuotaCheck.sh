#!/bin/bash


hdfsPath=$1
if [ "$1" = "" ];then
  echo "you must execute like this : sh hdfsQuotaCheck.sh /tmp"
  exit 0
fi
alertValue=${2:-85}

result=`/usr/bch/3.0.1/hadoop/bin/hdfs dfs -count -q $hdfsPath`
if [ $? = 0 ];then
  #echo $result
  spaceQuota=`echo $result|awk '{print $3}'`
  spaceLeft=`echo $result|awk '{print $4}'`
  if [ "$spaceQuota" = "none" ];then
    #echo "unlimited,unlimited,0,0,space quota is unlimited..."
    fileCapacity=`echo $result|awk '{print $7}'`
    fileCapacity_G=`expr $fileCapacity / 1024 / 1024 / 1024 \* 3`
    echo "$fileCapacity_G G,0 G,100.00 %,1" 
  else
    echo "$spaceQuota $spaceLeft"|awk -va=$alertValue -ve=$spaceQuota -vf=$spaceLeft '{b=($1==0?0:(1-$2/$1)*100);c=a-b;if(c<0)printf("%d G,%d G,%.2f %,%d\n",e/1024/1024/1024,f/1024/1024/1024,b,1);else printf("%d G,%d G,%.2f %,%d\n",e/1024/1024/1024,f/1024/1024/1024,b,0)}'
    #echo "$spaceQuota $spaceLeft"|awk -va=$alertValue -ve=$spaceQuota -vf=$spaceLeft '{b=(1-$2/$1)*100;c=a-b;if(c<0)printf("%d G,%d G,%.2f %,%d\n",e/1024/1024/1024,f/1024/1024/1024,b,1);else printf("%d G,%d G,%.2f %,%d\n",e/1024/1024/1024,f/1024/1024/1024,b,0)}'
  fi
else 
  echo "0,0,0,when execute [\"hdfs dfs -count -q $hdfsPath\"] errors"
fi

