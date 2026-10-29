#!/bin/bash
kinit -kt /data01/lg_xtgcb/newkdc/lg_xtgcb_user02.keytab lg_xtgcb_user02@HLWKDC
export HADOOP_HOME=/usr/bch/3.0.1/hadoop

run_hive_sql() {

/usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://10.169.129.141:2181,10.169.129.142:2181,10.169.129.143:2181/default;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2;principal=hive/gzhlwtz@HLWKDC" \
-hiveconf mapreduce.job.queuename=root.bdoc.lg_xtgcb_yarn84 \
--silent=true --showHeader=false --outputformat=csv2 \
-f "$1"|grep -E "$(date -d "1 day ago"  +"%Y$2%m$3%d")|$(date -d "2 day ago"  +"%Y$2%m$3%d")|$(date -d "3 day ago"  +"%Y$2%m$3%d")"
}

volatility_check_sql="/data01/lg_xtgcb/linyuebin/mrqs/volatility_check.sql"
TEMP_FILE="/data01/lg_xtgcb/linyuebin/mrqs/TEMP_FILE"


date=`run_hive_sql "$volatility_check_sql"`
echo "$date" > "$TEMP_FILE"
