#!/bin/bash
export HADOOP_HOME=/usr/bch/3.0.1/hadoop
run_hive_sql() {

        /usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://b27-gz3-sjjcpt-js-003:2181,b27-gz3-sjjcpt-js-004:2181,b27-gz3-sjjcpt-js-005:2181/ydy_tyrz_db03;principal=hive/gzydy@GZHLWYJQ;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" \
                -hiveconf mapreduce.job.queuename=root.bdoc.ydy_xtgcb_yarn06 \
                --silent=true --showHeader=false --outputformat=csv2 \
                -f "$1"|grep -E "$(date -d "1 day ago"  +"%Y$2%m$3%d")|$(date -d "2 day ago"  +"%Y$2%m$3%d")|$(date -d "3 day ago"  +"%Y$2%m$3%d")"
}


send_mail(){
        #指定收件人信息
        mails="13160812824@139.com,chenhuiling@hantele.com,13825010309@139.com,zhanghuiguan@hantele.com,sunmingchao@hantele.com,lilingcong@hantele.com,xuzhimin@hantele.com,zhupengcheng@hantele.com"
        ##19802021025@139.com,19802021153@139.com
        local mail_table="$1"
        #进入到发送邮件的目录下，指定邮件工具和内容发送
        cd /home/ydy_xtgcb/linyuebin/mbzh_y
      sudo /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.3.52.3:2227 -u "移动云vgop每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
}

file_html(){


        check_file_null=$(cat merged_result_f.txt  |grep "表格不存在"|wc -l)
        local mail_table="$1"
        local merged_result="$2"

        #表格头部
        echo "<table border="1">" >> ${mail_table}

        #遍历文件每列，将每列做成html格式
        while read htmlenv
        do
                echo "<tr>" >> ${mail_table}
                #通过awk拿出最后一行的行号，为后面for循环做循环次数。
                table_total_column=$(head -n 1 ${merged_result} |awk -F"," '{ print NF }')

                for i in `seq $table_total_column`
                do
                        #根据行号拿出对应的列的内容，然后生成html数据
                        table_line_value=$(echo $htmlenv |awk -v column=$i -F"," '{print $column}')
                        echo "<td>$table_line_value</td> " >> ${mail_table}
                done
                echo "</tr>" >> ${mail_table}

        done < ${merged_result}

        #表格尾部
        echo "</table>" >> ${mail_table}
        echo "</body> </html>" >> ${mail_table}
}




OUTPUT_FILE2="/home/ydy_xtgcb/linyuebin/mbzh_y/mail_table.html"
merged_result_vgop_f="/home/ydy_xtgcb/linyuebin/mbzh/merged_result_vgop_f.txt"
sssj="/home/ydy_xtgcb/linyuebin/ssjk/ts_date/ts_vgop_$(date +"%Y$2%m$3%d").txt"
storage="/home/ydy_xtgcb/linyuebin/storage/orgResult/ts_date/orgResult$(date +"%Y$2%m$3%d").csv"
col_check_sql="/home/ydy_xtgcb/linyuebin/mbzh_y/col_check.sql"
col_check_list_sql="/home/ydy_xtgcb/linyuebin/mbzh_y/col_check_list.sql"
volatility_month_sql="/home/ydy_xtgcb/linyuebin/mbzh_y/volatility_month.sql"
ts_date_rate="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/vgop_rate_result_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"
ts_date_merged="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/merged_result_vgop_f_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"
ts_date_sssj="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/ts_vgop_ydy_$(date +"%Y$2%m$3%d").txt"
ts_date_storage="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/ts_orgResult$(date +"%Y$2%m$3%d").csv"
col_check="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/col_check_ydy_$(date -d "1 day ago" +"%Y$2%m$3%d").txt"
col_check_list="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/col_check_list_ydy_$(date -d "1 day ago" +"%Y$2%m$3%d").txt"
volatility_month="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/volatility_month_$(date -d "1 day ago" +"%Y$2%m$3%d").txt"
monitor_result="/data01/ydy_xtgcb/script/monitor/monitor_result_$(date -d "+1 day" +"%Y$2%m$3%d").txt"
ts_monitor_result="/home/ydy_xtgcb/linyuebin/mbzh_y/ts_date/monitor_result_$(date -d "+1 day" +"%Y$2%m$3%d").txt"
##临时文件
TEMP_FILE="/home/ydy_xtgcb/linyuebin/mbzh_y/TEMP_FILE"



date=`run_hive_sql "$col_check_sql"`
echo "$date" > "$col_check"



##字段检测整体清单
date=`run_hive_sql "$col_check_list_sql"`
echo "$date" > "$col_check_list"

##月波动检测整体清单
date=`run_hive_sql "$volatility_month_sql"`
echo "$date" > "$volatility_month"

cat "$sssj" > "$ts_date_sssj"
cat "$storage" > "$ts_date_storage"
cat "$monitor_result" > "$ts_monitor_result"
