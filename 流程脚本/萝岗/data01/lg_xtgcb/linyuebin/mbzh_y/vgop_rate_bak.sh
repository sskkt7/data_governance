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
     mails="13160812824@139.com,chenhuiling@hantele.com,13825010309@139.com,zhanghuiguan@hantele.com,sunmingchao@hantele.com,lilingcong@hantele.com,xuzhimin@hantele.com,zhupengcheng@hantele.com,19802021025@139.com,19802021153@139.com"
        local mail_table="$1"
     #进入到发送邮件的目录下，指定邮件工具和内容发送
     cd /data01/lg_xtgcb/linyuebin/mbzh_y
     /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.169.129.3:2227 -u "萝岗vgop每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
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



# 定义输入文件和输出文件
T_FILE="/data01/lg_xtgcb/linyuebin/mbzh/merged_result_f.txt"
Y_FILE="/data01/lg_xtgcb/linyuebin/mbzh_y/merged_result_f.txt"
OUTPUT_FILE="/data01/lg_xtgcb/linyuebin/mbzh_y/vgop_rate_result.txt"

# 清空或创建输出文件
> "$OUTPUT_FILE"

# 写入表头
echo "表名,表中文名,业务,接口,波动率,当日数据量,昨日数据量,日期" > "$OUTPUT_FILE"

# 使用 awk 进行内关联匹配并计算 rate
awk '
BEGIN {
    FS=","; OFS=",";  # 设置字段分隔符为竖线
}
NR==FNR {             # 处理第一个文件 (merged_result_f_y.txt)
    y_table[$1] = $3; # 将 table_name 作为键，table_cnt 作为值存储到数组 y_table 中
    next;
}
$1 in y_table {       # 如果当前行的 table_name 存在于 y_table 中
    t_table_cnt = $3; # 获取 t_table_cnt
    y_table_cnt = y_table[$1]; # 获取 y_table_cnt
    if (y_table_cnt != 0) {    # 避免除以零错误
	rate = ((t_table_cnt - y_table_cnt) / y_table_cnt) ;
	rate_str = sprintf("%.2f%%", rate * 100); # 格式化为两位小数的百分比字符串    
} else {
        rate = "NaN";          # 如果 y_table_cnt 为 0，则 rate 设为 NaN
    }
    print $1, $2,$5,$6 ,rate,rate_str, t_table_cnt, y_table_cnt, $4 >> "'"$OUTPUT_FILE"'";
}
' "$Y_FILE" "$T_FILE"

echo "处理完成，结果已保存到 $OUTPUT_FILE"
##输出有问题数据

OUTPUT_FILE2="/data01/lg_xtgcb/linyuebin/mbzh_y/mail_table.html"
merged_result_vgop_f="/data01/lg_xtgcb/linyuebin/mbzh/merged_result_vgop_f.txt"
sssj="/data01/lg_xtgcb/linyuebin/ts_date/ts_vgop_$(date +"%Y$2%m$3%d").txt"
col_check_sql="/data01/lg_xtgcb/linyuebin/mbzh_y/col_check.sql"
##临时文件
TEMP_FILE="/data01/lg_xtgcb/linyuebin/mbzh_y/TEMP_FILE"

#标题，可以加多几个，也可以不加，格式：echo "<p>内容</p>" >>
echo "<p>巡检时间：$(date +"%Y-%m-%d %H:%M:%S")</p>" > "$OUTPUT_FILE2"
echo "<p>累计检测`wc -l $OUTPUT_FILE|  awk '{print $1 - 1}'`个vgop资产波动情况</p>" >> $OUTPUT_FILE2
echo "<p>VGOP接口数据波动情况--vgop波动超10%清单</p>" >> "$OUTPUT_FILE2"
awk -F',' '
BEGIN { OFS="," }
NR == 1 { print >> "'"$TEMP_FILE"'"; next }  # 打印表头到目标文件
{
    if ($5 != "" && $5 != "-1" && abs($5 + 0) > 0.1) {
        print $1,$2,$3,$4,$6,$7,$8,$9>> "'"$TEMP_FILE"'"
    }
}
function abs(x) { return (x < 0) ? -x : x }  # 定义绝对值函数
' $OUTPUT_FILE

file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}

echo "<p>VGOP接口数据波动情况--vgop未到大数据中心清单</p>" >> "$OUTPUT_FILE2"
awk -F',' '
BEGIN { OFS="," }
NR == 1 { print $1,$2,$3,$4,$6,$7,$8 >> "'"$TEMP_FILE"'"; next }  # 打印表头到目标文件
{
    if ($7 == 0 ) {
        print $1,$2,$3,$4,$7,$8,$9 >> "'"$TEMP_FILE"'"
    }
}
' $OUTPUT_FILE
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}

echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>VGOP基础数据监控情况（只展示数据未到情况）</p>" >> "$OUTPUT_FILE2"
echo "<p>累计检测`wc -l $merged_result_vgop_f| grep -o '^[0-9]\+'`个vgop资产完整性情况</p>"  >> $OUTPUT_FILE2
echo "表名,表中文名,数据量,日期,业务,接口" >> "$TEMP_FILE"
awk -F',' '
BEGIN { OFS="," }
{
    if ($3 == 0 ) {
        print >> "'"$TEMP_FILE"'"
    }
}
' $merged_result_vgop_f
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}

echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>实时监控情况</p>" >> "$OUTPUT_FILE2"
echo "表名,是否告警（0：告警，1：不告警）,查询时间" >> "$TEMP_FILE"
awk -F',' '
BEGIN { OFS="," }
{
    if ($2 == 1 || $2 == 0 ) {
        print >> "'"$TEMP_FILE"'"
    }
}
' $sssj
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}
echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>字段监控情况（只展示字段校验有问题情况）</p>" >> "$OUTPUT_FILE2"
echo "包含库名,表类型,接口编码,英文字段名,问题类型（1-空值问题，2-枚举值问题 3-字段格式问题 4-唯一性问题）,问题数量,总数量,查询时间,所属集群,数据日期" >> "$TEMP_FILE"
date=`run_hive_sql "$col_check_sql"`
echo "$date"  >> "$TEMP_FILE"
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}

send_mail "${OUTPUT_FILE2}"
