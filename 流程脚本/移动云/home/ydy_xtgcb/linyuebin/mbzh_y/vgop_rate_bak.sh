#!/bin/bash
run_hive_sql() {

	/usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://b27-gz3-sjjcpt-js-003:2181,b27-gz3-sjjcpt-js-004:2181,b27-gz3-sjjcpt-js-005:2181/ydy_tyrz_db03;principal=hive/gzydy@GZHLWYJQ;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2" \
		-hiveconf mapreduce.job.queuename=root.bdoc.ydy_xtgcb_yarn06 \
		--silent=true --showHeader=false --outputformat=csv2 \
		-f "$1"|grep -E "$(date -d "2 day ago"  +"%Y$2%m$3%d")|$(date -d "3 day ago"  +"%Y$2%m$3%d")"
}
# 定义输入文件和输出文件
T_FILE="/home/ydy_xtgcb/linyuebin/mbzh/merged_result_f.txt"
Y_FILE="/home/ydy_xtgcb/linyuebin/mbzh_y/merged_result_f.txt"
OUTPUT_FILE="/home/ydy_xtgcb/linyuebin/mbzh_y/vgop_rate_result.txt"

# 清空或创建输出文件
> "$OUTPUT_FILE"

# 写入表头
echo "表名,表中文名,业务,接口,波动率,t+1数据量,t+2数据量,日期" > "$OUTPUT_FILE"

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
	rate = (t_table_cnt - y_table_cnt) / y_table_cnt;
} else {
rate = "NaN";          # 如果 y_table_cnt 为 0，则 rate 设为 NaN
}
print $1, $2,$5,$6 ,rate, t_table_cnt, y_table_cnt, $4 >> "'"$OUTPUT_FILE"'";
}
' "$Y_FILE" "$T_FILE"

echo "处理完成，结果已保存到 $OUTPUT_FILE"
##输出有问题数据
OUTPUT_FILE2="/home/ydy_xtgcb/linyuebin/mbzh_y/vgop_rate_error.txt"
merged_result_vgop_f="/home/ydy_xtgcb/linyuebin/mbzh/merged_result_vgop_f.txt"
sssj="/home/ydy_xtgcb/linyuebin/ssjk/ts_date/ts_vgop_$(date +"%Y$2%m$3%d").txt"
col_check_sql="/home/ydy_xtgcb/linyuebin/mbzh_y/col_check.sql"

echo "巡检时间：$(date +"%Y-%m-%d %H:%M:%S")" > "$OUTPUT_FILE2"
echo "VGOP接口数据波动情况--vgop波动超10%清单" >> "$OUTPUT_FILE2"
awk -F',' '
BEGIN { OFS="," }
NR == 1 { print >> "'"$OUTPUT_FILE2"'"; next }  # 打印表头到目标文件
{
	if ($5 != "" && $5 != "-1" && abs($5 + 0) > 0.1) {
		print >> "'"$OUTPUT_FILE2"'"
	}
}
function abs(x) { return (x < 0) ? -x : x }  # 定义绝对值函数
' $OUTPUT_FILE

echo "VGOP接口数据波动情况--vgop未到大数据清单" >> "$OUTPUT_FILE2"
awk -F',' '
BEGIN { OFS="," }
NR == 1 { print >> "'"$OUTPUT_FILE2"'"; next }  # 打印表头到目标文件
{
	if ($6 == 0 ) {
		print >> "'"$OUTPUT_FILE2"'"
	}
}
' $OUTPUT_FILE
echo "累计检测`wc -l $OUTPUT_FILE|  awk '{print $1 - 1}'`个vgop资产波动情况" >> $OUTPUT_FILE2

echo "VGOP基础数据监控情况" >> "$OUTPUT_FILE2"
echo "表名,表中文名,数据量,日期,业务,接口" >> "$OUTPUT_FILE2"
awk -F',' '
BEGIN { OFS="," }
{
	if ($3 == 0 ) {
		print >> "'"$OUTPUT_FILE2"'"
	}
}
' $merged_result_vgop_f
echo "累计检测`wc -l $merged_result_vgop_f| grep -o '^[0-9]\+'`个vgop资产完整性情况"  >> $OUTPUT_FILE2

echo "实时监控情况" >> "$OUTPUT_FILE2"
echo "表名,是否告警（0：告警，1：不告警）,查询时间" >> "$OUTPUT_FILE2"
awk -F',' '
BEGIN { OFS="," }
{
	if ($2 == 1 || $2 == 0 ) {
		print >> "'"$OUTPUT_FILE2"'"
	}
}
' $sssj

echo "字段监控情况" >> "$OUTPUT_FILE2"
echo "包含库名,表类型,接口编码,英文字段名,问题类型（1-空值问题，2-枚举值问题 3-字段格式问题 4-唯一性问题）,问题数量,总数量,问题占比,查询时间,所属集群,数据日期" >> "$OUTPUT_FILE2"
date=`run_hive_sql "$col_check_sql"`
echo "$date"  >> "$OUTPUT_FILE2"

