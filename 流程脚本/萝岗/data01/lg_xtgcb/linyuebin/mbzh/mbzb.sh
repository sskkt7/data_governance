#!/bin/bash
kinit -kt /data01/lg_xtgcb/newkdc/lg_xtgcb_user02.keytab lg_xtgcb_user02@HLWKDC
export HADOOP_HOME=/usr/bch/3.0.1/hadoop

run_hive_sql() {

/usr/bch/3.0.1/hive/bin/beeline -u "jdbc:hive2://10.169.129.141:2181,10.169.129.142:2181,10.169.129.143:2181/default;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2;principal=hive/gzhlwtz@HLWKDC" \
-hiveconf mapreduce.job.queuename=root.bdoc.lg_xtgcb_yarn84 \
--silent=true --showHeader=false --outputformat=csv2 \
-f "$1"|grep -E "$(date -d "1 day ago"  +"%Y$2%m$3%d")|$(date -d "2 day ago"  +"%Y$2%m$3%d")"
}

##集团清单
A_FILE="/data01/lg_xtgcb/linyuebin/mbzh/jt_list.txt"
##集团vgop数据情况
B_FILE="/data01/lg_xtgcb/linyuebin/mbzh/check.txt"
##剩余跑数清单
C_FILE="/data01/lg_xtgcb/linyuebin/mbzh/check2.txt"

check_sql="/data01/lg_xtgcb/linyuebin/mbzh/check.sql"

D_FILE="/data01/lg_xtgcb/linyuebin/mbzh/merged_result.txt"
E_FILE="/data01/lg_xtgcb/linyuebin/mbzh/merged_result_f.txt"
F_FILE="/data01/lg_xtgcb/linyuebin/mbzh/rate_list.txt"
G_FILE="/data01/lg_xtgcb/linyuebin/mbzh/vgop_list.txt"
H_FILE="/data01/lg_xtgcb/linyuebin/mbzh/merged_result_vgop_f.txt"
##跑完整性表当前集团vgop数据情况
date=`run_hive_sql "$check_sql"`
echo "$date"  > "$B_FILE"



# 创建临时文件用于存储匹配结果
TEMP_MATCHED_FILE=/data01/lg_xtgcb/linyuebin/mbzh/TEMP_MATCHED_FILE
TEMP_MATCHED_FILE2=/data01/lg_xtgcb/linyuebin/mbzh/TEMP_MATCHED_FILE2


# 清理临时文件
rm -f "$TEMP_MATCHED_FILE2"
rm -f "$TEMP_MATCHED_FILE"

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

##防止元数据表没数据
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
##与波动率清单的整合inner join 
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
' "$F_FILE" "$D_FILE" > "$E_FILE"

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


