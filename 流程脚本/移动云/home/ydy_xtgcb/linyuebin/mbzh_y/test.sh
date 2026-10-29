#!/bin/bash
export HADOOP_HOME=/usr/bch/3.0.1/hadoop
run_hive_sql() {

	        /usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://b27-gz3-sjjcpt-js-003:2181,b27-gz3-sjjcpt-js-004:2181,b27-gz3-sjjcpt-js-005:2181/ydy_tyrz_db03;principal=hive/gzydy@GZHLWYJQ;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" \
			                -hiveconf mapreduce.job.queuename=root.bdoc.ydy_xtgcb_yarn06 \
					                --silent=true --showHeader=false --outputformat=csv2 \
							                -f "$1"|grep -E "$(date -d "1 day ago"  +"%Y$2%m$3%d")|$(date -d "2 day ago"  +"%Y$2%m$3%d")|$(date -d "3 day ago"  +"%Y$2%m$3%d")"
	}

	col_check_list_sql="/home/ydy_xtgcb/linyuebin/mbzh_y/col_check_list.sql"


	##字段检测整体清单
	date=`run_hive_sql "$col_check_list_sql"`
	echo "$date" 
