#!/bin/bash

get_hdfs_path_size() {
    local hdfs_path=$1$(date +"%Y$2%m$3%d")
    local table_name=$4


    local current_time=$(date +"%Y-%m-%d %H:%M:%S")
    local path_size=$(/usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path" 2>/dev/null| awk '{print $1}' )
    /usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path"

    if [ $? -ne 0 ]; then
        echo "连接错误或路径不存在"
        echo "$table_name,$hdfs_path,$path_size,连接错误或路径不存在,$current_time" >> /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt
        return 1 # 连接错误或路径不存在，返回非0值
    fi


    echo "$table_name,$hdfs_path,$path_size,返回正常,$current_time" >> /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt
        return 0
}


# 遍历文件的每一行
while IFS=',' read -r param1 param2 param3 param4; do
        get_hdfs_path_size "$param1" "$param2" "$param3" "$param4"
done < /data01/lg_xtgcb/linyuebin/check_data.txt
##推送zb
cr_filename="/data01/lg_xtgcb/linyuebin/contrast/cr_$(date +"%Y%m%d").txt"
ls_filename="/data01/lg_xtgcb/linyuebin/contrast/ls_$(date +"%Y%m%d").txt"
ts_filename="/data01/lg_xtgcb/linyuebin/ts_date/ts_vgop_$(date +"%Y%m%d").txt"



# 获取文件行数
lines=$(wc -l /data01/lg_xtgcb/linyuebin/check_data.txt | awk '{print $1}')
 # 获取文件总行数
total_lines=$(wc -l < /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt)
# 计算倒数38行和倒数19行的行号
start_line=$((total_lines - lines*2+1))
end_line=$((total_lines - lines))


##取当前一次周期数据
tail -n $lines /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt|awk -v FS="," '{print $1,$3}' > $cr_filename
##取前一次周期数据
##tail -n $((lines*2)) /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt|head -n $lines|awk -v FS=","  '{print $1,$3}' > $ls_filename
awk -v start=$start_line -v end=$end_line 'NR >= start && NR <= end' /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt|awk -v FS=","  '{print $1,$3}\' > $ls_filename
##对比两次差值，1为正常，0为不正常
awk -v date="$(date +"%Y-%m-%d %H:%M:%S")" -v OFS="," 'FNR==NR{a[$1]=$2;next} {print $1,($2-a[$1])!=0?1:0,date}' $ls_filename $cr_filename > $ts_filename


chmod 755 /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt

