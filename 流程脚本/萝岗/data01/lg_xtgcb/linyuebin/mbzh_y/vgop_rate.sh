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
     mails="wangguozheng@hantele.com,15012416968@139.com,19700132569@139.com,15817096146@139.com,liuziwei@richstonedt.com,chendan@hantele.com,guoyancheng@hantele.com,17266972274@139.com,13434272275@139.com,15918171822@139.com,13580515117@139.com,17329504279@139.com,yuhao.z@139.com,19700213173@139.com,13902220586@139.com,19802024056@139.com,19802021708@139.com,13802885304@139.com,19802021477@139.com,19802021776@139.com,19802021069@139.com,19802021310@139.com,19802021169@139.com,13902220379@139.com,19802021738@139.com,13802885408@139.com,13902220595@139.com,19802021360@139.com,19802024048@139.com,19802021025@139.com,19802021685@139.com,19802021952@139.com,huangzhida@hantele.com,19802021525@139.com,19854731620@139.com,shangjianhua@hantele.com,19802021025@139.com,19802021153@139.com,13160812824@139.com,13825010309@139.com,zhanghuiguan@hantele.com,zhupengcheng@hantele.com,13662420437@139.com"
        local mail_table="$1"
        ##,19802021025@139.com,19802021153@139.com
     #进入到发送邮件的目录下，指定邮件工具和内容发送
     cd /data01/lg_xtgcb/linyuebin/mbzh_y
     /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.169.129.3:2227 -u "vgop每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
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
orgResult="/data01/lg_xtgcb/linyuebin/storage/orgResult/ts_date/orgResult$(date +"%Y$2%m$3%d").csv"
col_check_sql="/data01/lg_xtgcb/linyuebin/mbzh_y/col_check.sql"
col_check_list_sql="/data01/lg_xtgcb/linyuebin/mbzh_y/col_check_list.sql"
volatility_check_sql="/data01/lg_xtgcb/linyuebin/mbzh_y/volatility_check.sql"
volatility_month_sql="/data01/lg_xtgcb/linyuebin/mbzh_y/volatility_month.sql"
monitor_result_lg="/data01/lg_xtgcb/script/monitor/monitor_result_$(date -d "+1 day"  +"%Y$2%m$3%d").txt"
##临时文件
TEMP_FILE="/data01/lg_xtgcb/linyuebin/mbzh_y/TEMP_FILE"
TEMP_FILE3="/data01/lg_xtgcb/linyuebin/mbzh_y/TEMP_FILE3"
# 等待的目标文件路径

file="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/col_check_ydy_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"
file1="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/merged_result_vgop_f_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"
file2="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/ts_vgop_ydy_$(date   +"%Y$2%m$3%d").txt"
file3="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/vgop_rate_result_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"
file4="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/col_check_list_ydy_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"
file5="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/ts_orgResult$(date  +"%Y$2%m$3%d").csv"
file6="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/volatility_month_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"
file7="/data01/lg_xtgcb/linyuebin/mbzh_y/js_date/monitor_result_$(date -d "+1 day"  +"%Y$2%m$3%d").txt"
# 最大等待循环次数
max_attempts=20

# 当前尝试次数
attempt=0

# 使用 while 循环检测文件是否存在，并限制最大尝试次数
while [ $attempt -lt $max_attempts ]; do
  if [ -f "$file" ] && [ -f "$file1" ] && [ -f "$file2" ] && [ -f "$file3" ] && [ -f "$file4" ] && [ -f "$file6" ] && [ -f "$file7" ]; then
    echo "文件 已经存在，继续执行后续操作..."
    break  # 如果文件存在，退出循环
  else
    echo "文件 尚未出现，正在等待...（第 $((attempt + 1)) 次尝试）"
    sleep 150  # 每隔 5 分钟检查一次
    attempt=$((attempt + 1))  # 增加尝试次数
  fi
done

#标题，可以加多几个，也可以不加，格式：echo "<p>内容</p>" >>
echo "<p>巡检时间：$(date +"%Y-%m-%d %H:%M:%S")</p>" > "$OUTPUT_FILE2"
echo "<p>累计检测`cat $OUTPUT_FILE $file3|wc -l|  awk '{print $1 - 1}'`个vgop资产波动情况</p>" >> $OUTPUT_FILE2
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
' $OUTPUT_FILE ${file3}


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
' $OUTPUT_FILE ${file3}
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}

echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>VGOP基础数据监控情况（只展示数据未到情况）</p>" >> "$OUTPUT_FILE2"
echo "<p>累计检测`cat $merged_result_vgop_f $file1|wc -l| grep -o '^[0-9]\+'`个vgop资产完整性情况</p>"  >> $OUTPUT_FILE2
echo "表名,表中文名,数据量,日期,业务,接口" >> "$TEMP_FILE"
awk -F',' '
BEGIN { OFS="," }
{
    if ($3 == 0 ) {
        print >> "'"$TEMP_FILE"'"
    }
}
' $merged_result_vgop_f $file1
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
' $sssj $file2
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}



echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>实时监控分区创建情况</p>" >> "$OUTPUT_FILE2"
echo "表名,账期,分区创建情况" >> "$TEMP_FILE"
cat "$file7" "$monitor_result_lg"  >> "$TEMP_FILE"
sed -i '/^$/d' "$TEMP_FILE"

file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}

echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>字段监控情况（只展示字段校验有问题情况）</p>" >> "$OUTPUT_FILE2"
##展示字段监控执行情况
date=`run_hive_sql "$col_check_list_sql"`
echo "$date" > "$TEMP_FILE"
cat "$file4" >> "$TEMP_FILE"
cat "$TEMP_FILE"
##echo "<p>目前已纳入字段检测接口总计：`wc -l "$TEMP_FILE"| grep -o '^[0-9]\+'`个，已完成日接口检测`awk -F, '$3 != "NULL" && $4 == "日接口" {print}' "$TEMP_FILE"|wc -l`个，剩余`awk -F, '$3 == "NULL" && $4 == "日接口" {print}' "$TEMP_FILE"|wc -l`个接口待检测;已完成月接口检测`awk -F, '$3 != "NULL" && $4 == "月接口" {print}' "$TEMP_FILE"|wc -l`个，剩余`awk -F, '$3 == "NULL" && $4 == "月接口" {print}' "$TEMP_FILE"|wc -l`个接口待检测;完成周接口检测`awk -F, '$3 != "NULL" && $4 == "周接口" {print}' "$TEMP_FILE"|wc -l`个，剩余`awk -F, '$3 == "NULL" && $4 == "周接口" {print}' "$TEMP_FILE"|wc -l`个接口待检测;完成季度接口检测`awk -F, '$3 != "NULL" && $4 == "季度接口" {print}' "$TEMP_FILE"|wc -l`个，剩余`awk -F, '$3 == "NULL" && $4 == "季度接口" {print}' "$TEMP_FILE"|wc -l`个接口待检测。</p>"  >> $OUTPUT_FILE2
echo "<p>今日字段检测接口总数`wc -l "$TEMP_FILE"| grep -o '^[0-9]\+'`个，已完成检测`awk -F, '$3 != "NULL" && $5 == "已上线" {print}' "$TEMP_FILE"|wc -l`个，空文件无需检测`awk -F, '$5 == "空文件" {print}' "$TEMP_FILE"|wc -l`个，待检测`awk -F, '$3 == "NULL" && $5 == "已上线" {print}' "$TEMP_FILE"|wc -l`个。</p>"  >> $OUTPUT_FILE2
rm -f "$TEMP_FILE"
echo "包含库名,表类型,接口编码,英文字段名,问题类型（1-空值问题，2-枚举值问题 3-字段格式问题 4-唯一性问题）,问题数量,总数量,查询时间,所属集群,数据日期" >> "$TEMP_FILE"
date=`run_hive_sql "$col_check_sql"`
echo "$date" >> "$TEMP_FILE"
cat "$file" >> "$TEMP_FILE"
cat "$TEMP_FILE"
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}


echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>vgop标准差波动情况监控情况（只展示超出两倍标准差的问题情况）</p>" >> "$OUTPUT_FILE2"
##展示字段监控执行情况
date=`run_hive_sql "$volatility_check_sql"`
echo "$date" > "$TEMP_FILE"
echo "<p>目前已纳入标准差波动检测接口总计：`wc -l "$TEMP_FILE"| grep -o '^[0-9]\+'`个，已完成接口标准差波动检测`awk -F, '$4 != "NULL" {print}' "$TEMP_FILE"|wc -l`个，剩余`awk -F, '$4 == "NULL"  {print}' "$TEMP_FILE"|wc -l`个接口待检测,其中存在`awk -F, '$4 == "0"  {print}' "$TEMP_FILE"|wc -l`个接口为空文件。</p>"  >> $OUTPUT_FILE2
rm -f "$TEMP_FILE"
echo "表名（包含库名）,业务,接口,数据量,近九十天数据量平均值,近九十天数据量标准差,昨日数据量,是否正常数据,数据日期" >> "$TEMP_FILE"
echo "$date" > "$TEMP_FILE3"
awk -F, '$8 == "异常数据" {print}' "$TEMP_FILE3" >> "$TEMP_FILE" 
awk -F, '$4 == "0" {print}' "$TEMP_FILE3" >> "$TEMP_FILE"
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}
rm -f ${TEMP_FILE3}

echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>月接口波动监控情况--vgop波动超10%清单（只展示波动校验有问题情况）</p>" >> "$OUTPUT_FILE2"
##展示字段监控执行情况
date=`run_hive_sql "$volatility_month_sql"`
echo "$date" > "$TEMP_FILE"
cat "$file6" >> "$TEMP_FILE"
cat "$TEMP_FILE"
sed -i '/^$/d' "$TEMP_FILE"

echo "<p>今日月接口波动检测接口总数`wc -l "$TEMP_FILE"| grep -o '^[0-9]\+'`个，已完成检测`awk -F, '$4 != "NULL"  {print}' "$TEMP_FILE"|wc -l`个，待检测`awk -F, '$4 == "NULL" {print}' "$TEMP_FILE"|wc -l`个。</p>"  >> $OUTPUT_FILE2

echo "表名（包含库名）,业务,接口,数据量,上月数据量,波动率,是否预警,数据日期" >> "$TEMP_FILE3"
##echo "$date" > "$TEMP_FILE3"
awk -F, '$7 == "0" {print}' "$TEMP_FILE" >> "$TEMP_FILE3"
file_html "${OUTPUT_FILE2}" "${TEMP_FILE3}"
rm -f ${TEMP_FILE}
rm -f ${TEMP_FILE3}


echo "<p>---------------------------------------</p>" >> "$OUTPUT_FILE2"
echo "<p>hdfs存储情况（只展示告警存储）</p>" >> "$OUTPUT_FILE2"
echo "租户,项目组,目录,配额,余量,使用情况,是否告警,租户管理员,电话,邮箱,日期,集群" >> "$TEMP_FILE"
awk -F',' '
BEGIN { OFS="," }
{
    if ($7 != 0 ) {
        print >> "'"$TEMP_FILE"'"
    }
}
' $orgResult $file5
file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}

send_mail "${OUTPUT_FILE2}"

