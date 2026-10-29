#!/bin/bash
export HADOOP_HOME=/usr/bch/3.0.1/hadoop

send_mail(){
        #指定收件人信息
        mails="13160812824@139.com"
        ##19802021025@139.com,19802021153@139.com
        local mail_table="$1"
        #进入到发送邮件的目录下，指定邮件工具和内容发送
        cd /home/ydy_xtgcb/linyuebin/bqxj
      sudo /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.3.52.3:2227 -u "宽表每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
}

file_html(){


        ##check_file_null=$(cat merged_result_f.txt  |grep "表格不存在"|wc -l)
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


run_hive_sql() {

        /usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://b27-gz3-sjjcpt-js-003:2181,b27-gz3-sjjcpt-js-004:2181,b27-gz3-sjjcpt-js-005:2181/ydy_tyrz_db03;principal=hive/gzydy@GZHLWYJQ;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" \
                -hiveconf mapreduce.job.queuename=root.bdoc.ydy_xtgcb_yarn06 \
                --silent=true --showHeader=false --outputformat=csv2 \
                -f "$1"|grep -E "$(date -d "1 day ago"  +"%Y$2%m$3%d")|$(date -d "2 day ago"  +"%Y$2%m$3%d")"
}

OUTPUT_FILE2="/home/ydy_xtgcb/linyuebin/kbxj/mail_table.html"
TEMP_FILE="/home/ydy_xtgcb/linyuebin/kbxj/TEMP_FILE"

##集团清单
A_FILE="/home/ydy_xtgcb/linyuebin/kbxj/kb_list.txt"
##集团vgop数据情况
B_FILE="/home/ydy_xtgcb/linyuebin/kbxj/check.txt"
##剩余跑数清单
C_FILE="/home/ydy_xtgcb/linyuebin/kbxj/check2.txt"

check_sql="/home/ydy_xtgcb/linyuebin/kbxj/check.sql"

D_FILE="/home/ydy_xtgcb/linyuebin/kbxj/merged_result.txt"
E_FILE="/home/ydy_xtgcb/linyuebin/kbxj/merged_result_f.txt"
G_FILE="/home/ydy_xtgcb/linyuebin/kbxj/bk_f_list.txt"
H_FILE="/home/ydy_xtgcb/linyuebin/kbxj/merged_result_vgop_f.txt"

# 检查文件是否存在
if [ ! -f "$H_FILE" ]; then
    echo "文件不存在，继续执行后续命令"
else
    # 检查文件第三列是否有任何不为0的值
    if awk -F, '$3 == "0" { found=1; exit } END { if (found) exit 0; else exit 1 }' "$H_FILE"; then
        echo "文件第三列存在0值，继续执行后续命令"
       ## exit 0
    else
        echo "文件存在且第三列没有0值，退出脚本"
        exit 1
    fi
fi

##跑完整性表当前集团vgop数据情况
date=`run_hive_sql "$check_sql"`
echo "$date"  > "$B_FILE"



# 创建临时文件用于存储匹配结果
TEMP_MATCHED_FILE=/home/ydy_xtgcb/linyuebin/kbxj/TEMP_MATCHED_FILE
TEMP_MATCHED_FILE2=/home/ydy_xtgcb/linyuebin/kbxj/TEMP_MATCHED_FILE2

# 从 b.txt 中提取表名并匹配 a.txt 的内容
while IFS=',' read -r table_name table_name_ch data_count date; do
        # 去掉表名两端的空格
        table_name=$(echo "$table_name" | xargs)


        # 检查 data_count 是否为 0
        if [[ "$data_count" -eq 0 || "$data_count" == "NULL" || "$data_count" == "null"  ]]; then
                        # 在 a.txt 中查找匹配的记录
                                grep "^$table_name|" "$A_FILE" >> "$TEMP_MATCHED_FILE"
                        fi
                done < "$B_FILE"
# 获取check.txt的行数
line_count=$(wc -l < "$B_FILE")

# 判断行数是否小于或等于1
if [ "$line_count" -le 1 ]; then
            # 如果条件满足，执行grep命令
                cat "$A_FILE" > "$TEMP_MATCHED_FILE"
fi

                # 拼接 SQL 查询语句
                echo "生成的 SQL 查询语句如下："
                echo "set mapreduce.map.memory.mb=6144;" >> "$TEMP_MATCHED_FILE2"
                echo "set mapreduce.map.java.opts=-Xmx4608m;" >> "$TEMP_MATCHED_FILE2"
                echo "set mapreduce.job.priority=HIGH;" >> "$TEMP_MATCHED_FILE2"
                while IFS='|' read -r table_name table_name_ch partition column_date; do
                        echo "select '$table_name','$table_name_ch',count(1),$column_date from $table_name where $partition=$column_date  union all" >> "$TEMP_MATCHED_FILE2"
                done < "$TEMP_MATCHED_FILE"
                perl -0777 -pi -e 's/union all\s*$//' "$TEMP_MATCHED_FILE2"
                date2=`run_hive_sql $TEMP_MATCHED_FILE2`
                 echo "$date2" > "$C_FILE"
# 判断行数是否小于或等于1
if [ "$line_count" -le 1 ]; then
            # 如果条件满足，执行grep命令
                cat "$C_FILE" > "$B_FILE"
        fi

                ##整合两次查询结果内容
                awk -F',' '
                BEGIN { OFS="," }
                NR==FNR { check2[$1]=$0; next }  # 将 check2.txt 的内容存入数组 check2
                {
                        if ($1 in check2) {
                                print check2[$1]  # 如果 check.txt 的 table_name 在 check2.txt 中找到，则输出 check2.txt 的内容
                        } else {
                        print $0  # 如果未找到，则输出 check.txt 的内容
                }
        }
        ' "$C_FILE" "$B_FILE" > "$D_FILE"




##与集团清单的整合inner join
awk -F',' '
BEGIN { OFS="," }
NR==FNR {
split($0, fields, ",");  # 将 check2.txt 的内容按竖线分隔
check2[fields[1]] = $2 "," $3;  # 使用第一列（table_name）作为键，整行作为值存入数组 check2
next
}
{
if ($1 in check2) {
print $0,check2[$1]
        }
}
' "$G_FILE" "$D_FILE" > "$H_FILE"



echo "<p>宽表基础数据监控情况（只展示数据未到情况）</p>" > "$OUTPUT_FILE2"
echo  "<p>截至巡检时间：$(date +"%Y-%m-%d %H:%M:%S")，累计检测`wc -l $H_FILE| grep -o '^[0-9]\+'`个标签资产完整性情况，其中存在`awk -F, '$3 == '0'  {print}' "$H_FILE"|wc -l`资产当日数据未达到大数据中心，请留意数据使用情况</p>"  >> $OUTPUT_FILE2

echo "包含库名,表中文名,总数量,数据日期,业务" >> "$TEMP_FILE"

awk -F',' '
BEGIN { OFS="," }
{
        if ($3 == 0 ) {
                print >> "'"$TEMP_FILE"'"
        }
}
' $H_FILE

file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"

rm -f ${TEMP_FILE}

send_mail "${OUTPUT_FILE2}"

# 清理临时文件
rm -f "$TEMP_MATCHED_FILE2"
rm -f "$TEMP_MATCHED_FILE"
