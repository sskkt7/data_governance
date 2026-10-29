#!/bin/bash
export HADOOP_HOME=/usr/bch/3.0.1/hadoop

send_mail(){
#指定收件人信息
mails="19700132569@139.com,15817096146@139.com,15012416968@139.com,liuziwei@richstonedt.com,17266972274@139.com,15918171822@139.com,13434272275@139.com,13160812824@139.com,zhupengcheng@hantele.com,19802021916@139.com,18819122115@139.com,13726863597@139.com,huangzhida@hantele.com,maqicai@richstonedt.com,19700213173@139.com,changzhenzong@hantele.com"
##zhupengcheng@hantele.com,19802021916@139.com,18819122115@139.com,13726863597@139.com,huangzhida@hantele.com,maqicai@richstonedt.com,19700213173@139.com,changzhenzong@hantele.com
##19802021025@139.com,19802021153@139.com
local mail_table="$1"
#进入到发送邮件的目录下，指定邮件工具和内容发送
cd /home/ydy_xtgcb/linyuebin/sytj
sudo /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.3.52.3:2227 -u "首页推荐每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
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
-f "$1"|grep -E "$(date -d "1 day ago"  +"%Y$2%m$3%d")|$(date -d "2 day ago"  +"%Y$2%m$3%d")|$(date -d "3 day ago"  +"%Y$2%m$3%d")|$(date -d "4 day ago"  +"%Y$2%m$3%d")|$(date -d "5 day ago"  +"%Y$2%m$3%d")|$(date -d "0 day ago"  +"%Y$2%m$3%d")"
}

##集团清单
A_FILE="/home/ydy_xtgcb/linyuebin/sytj/jt_list.txt"

today=$(date +%Y%m%d)
# 获取星期 (1=周一, 2=周二, 3=周三, 4=周四, 5=周五, 6=周六,7=周日)
week=$(date +%u)

case $week in
    2|3|4)
        # 周二、三、四 → 本周一
        col_date=$(date -d "$today -$(($week-1)) days" +%Y%m%d)
        ;;
    5|6|7)
        # 周五、六、日 → 本周四
        col_date=$(date -d "$today -$(($week-4)) days" +%Y%m%d)
        ;;
    1)
        # 周一 → 上周四
        col_date=$(date -d "$today -4 days" +%Y%m%d)
        ;;
esac

sed -i '/ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_file_label_df/d' "$A_FILE"
echo "ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_file_label_df|首页推荐|dtime|'$col_date'" >>  "$A_FILE"

##剩余跑数清单
C_FILE="/home/ydy_xtgcb/linyuebin/sytj/ts_data/check2_$(date -d "1 day ago"  +"%Y$2%m$3%d").txt"




TEMP_FILE="/home/ydy_xtgcb/linyuebin/sytj/TEMP_FILE"

# 创建临时文件用于存储匹配结果
TEMP_MATCHED_FILE2=/home/ydy_xtgcb/linyuebin/sytj/TEMP_MATCHED_FILE2

OUTPUT_FILE2="/home/ydy_xtgcb/linyuebin/sytj/mail_table.html"

# 单文件处理（替换filename为实际文件名）
if [ $(wc -l < ${C_FILE}) -lt 18 ]; then
       	echo "文件不足19行，已删除"
	rm ${C_FILE}
fi


# 检查文件是否存在
if [ ! -f "$C_FILE" ]; then
    echo "文件不存在，继续执行后续命令"
else
    # 检查文件第三列是否有任何不为0的值
    if awk -F, '$3 == "0" { found=1; exit } END { if (found) exit 0; else exit 1 }' "$C_FILE"; then
        echo "文件第三列存在0值，继续执行后续命令"
       ## exit 0
    else
        echo "文件存在且第三列没有0值，退出脚本"
	exit 1
    fi
fi

# 后续命令放在这里
echo "执行后续命令..."
# 请在这里添加您需要执行的后续命令


# 拼接 SQL 查询语句
echo "生成的 SQL 查询语句如下："
echo "set mapreduce.map.memory.mb=6144;" > "$TEMP_MATCHED_FILE2"
echo "set mapreduce.map.java.opts=-Xmx4608m;" >> "$TEMP_MATCHED_FILE2"
echo "set mapreduce.job.priority=HIGH;" >> "$TEMP_MATCHED_FILE2"
while IFS='|' read -r table_name table_name_ch partition column_date; do
echo "select '$table_name','$table_name_ch',count(1),$column_date from $table_name where $partition=$column_date  union all" >> "$TEMP_MATCHED_FILE2"
done < "$A_FILE"
perl -0777 -pi -e 's/union all\s*$//' "$TEMP_MATCHED_FILE2"
date2=`run_hive_sql $TEMP_MATCHED_FILE2`

if [ $? -ne 0 ] || [ -z "$date2" ]; then
	    date2="流程转ec中，暂不支持查询"
    fi

echo "$date2" > "$C_FILE"



echo "<p>---------------------------------------</p>" > "$OUTPUT_FILE2"
echo "<p>首页推荐基础数据监控情况</p>" >> "$OUTPUT_FILE2"
echo "<p>累计检测`wc -l ${C_FILE}| grep -o '^[0-9]\+'`个首页资产完整性情况</p>"  >> $OUTPUT_FILE2
echo "表名,表中文名,数据量,日期" >> "$TEMP_FILE"
awk -F',' '
BEGIN { OFS="," }
{
if ($3 == 0 ) {
print >> "'"$TEMP_FILE"'"
}
else 
{
print >> "'"$TEMP_FILE"'"
}
}
' ${C_FILE}

file_html "${OUTPUT_FILE2}" "${TEMP_FILE}"
rm -f ${TEMP_FILE}
send_mail "${OUTPUT_FILE2}"


# 清理临时文件
rm -f "$TEMP_MATCHED_FILE2"
