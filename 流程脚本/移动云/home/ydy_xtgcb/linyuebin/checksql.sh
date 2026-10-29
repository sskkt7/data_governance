#!/bin/bash
export HADOOP_HOME=/usr/bch/3.0.1/hadoop
run_hive_sql() {

        /usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://b27-gz3-sjjcpt-js-003:2181,b27-gz3-sjjcpt-js-004:2181,b27-gz3-sjjcpt-js-005:2181/ydy_tyrz_db03;principal=hive/gzydy@GZHLWYJQ;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" \
                -hiveconf mapreduce.job.queuename=root.bdoc.ydy_xtgcb_yarn06 \
                --silent=true --showHeader=false --outputformat=csv2 \
                -f "$1"
}

col_check_list_sql="/home/ydy_xtgcb/linyuebin/col_check_list.sql"

run_hive_sql "$col_check_list_sql"
