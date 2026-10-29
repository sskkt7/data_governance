#!/bin/bash
kinit -kt /data01/lg_xtgcb/newkdc/lg_xtgcb_user02.keytab lg_xtgcb_user02@HLWKDC
export HADOOP_HOME=/usr/bch/3.0.1/hadoop

run_hive_sql() {

/usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://10.169.129.141:2181,10.169.129.142:2181,10.169.129.143:2181/default;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2;principal=hive/gzhlwtz@HLWKDC" \
-hiveconf mapreduce.job.queuename=root.bdoc.lg_xtgcb_yarn84 \
--silent=true --showHeader=false --outputformat=csv2 \
-f "$1"|grep -E "$(date -d "1 day ago"  +"%Y$2%m$3%d")|$(date -d "2 day ago"  +"%Y$2%m$3%d")|$(date -d "3 day ago"  +"%Y$2%m$3%d")"
}

send_mail(){
     #指定收件人信息
     mails="huangzhida@hantele.com,19802021525@139.com,maqicai@richstonedt.com,shangjianhua@hantele.com,19802021025@139.com,19802021153@139.com,13160812824@139.com,chenhuiling@hantele.com,13825010309@139.com,zhanghuiguan@hantele.com,lilingcong@hantele.com,zhupengcheng@hantele.com"
        local mail_table="$1"
        ##,19802021025@139.com,19802021153@139.com
     #进入到发送邮件的目录下，指定邮件工具和内容发送
     cd /data01/lg_xtgcb/linyuebin/mbzh_y
     /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.169.129.3:2227 -u "vgop每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
}
TEMP_FILE3=/data01/lg_xtgcb/linyuebin/mbzh_y/TEMP_FILE3

volatility_check_sql="/data01/lg_xtgcb/linyuebin/mbzh_y/volatility_check.sql"
date=`run_hive_sql "$volatility_check_sql"`
echo "$date" > "$TEMP_FILE3"
awk -F, '$7 == "异常数据" {print}' "$TEMP_FILE3"
