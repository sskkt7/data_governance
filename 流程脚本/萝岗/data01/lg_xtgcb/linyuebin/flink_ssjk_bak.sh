#!/bin/bash

get_hdfs_path_size() {
    local hdfs_path=$1$(date +"%Y$2%m$3%d")
    local table_name=$4


    local current_time=$(date +"%Y-%m-%d %H:%M:%S")
    local path_size=$(/usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path" 2>/dev/null| awk '{print $1}' )
    /usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path"

    if [ $? -ne 0 ]; then
        echo "连接错误或路径不存在"
        echo "$table_name,$hdfs_path,$path_size,连接错误或路径不存在,$current_time" >> /data/lg_hive/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt
        return 1 # 连接错误或路径不存在，返回非0值
    fi


    echo "$table_name,$hdfs_path,$path_size,返回正常,$current_time" >> /data/lg_hive/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt
        return 0
}
get_hdfs_path_size_yd() {
    local hdfs_path=$1$(date -d "1 day ago" +"%Y$2%m$3%d")
    local table_name=$4


    local current_time=$(date +"%Y-%m-%d %H:%M:%S")
    local path_size=$(/usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path" 2>/dev/null| awk '{print $1}' )
    /usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path"

    if [ $? -ne 0 ]; then
        echo "连接错误或路径不存在"
        echo "$table_name,$hdfs_path,$path_size,连接错误或路径不存在,$current_time" >> /data/lg_hive/linyuebin/date01/flink_ssjk_data_$(date -d "1 day ago" +"%Y%m%d").txt
        return 1 # 连接错误或路径不存在，返回非0值
    fi


    echo "$table_name,$hdfs_path,$path_size,返回正常,$current_time" >> /data/lg_hive/linyuebin/date01/flink_ssjk_data_$(date -d "1 day ago" +"%Y%m%d").txt
        return 0
}

# 遍历文件的每一行
while IFS=',' read -r param1 param2 param3 param4; do
        get_hdfs_path_size "$param1" "$param2" "$param3" "$param4"
	get_hdfs_path_size_yd "$param1" "$param2" "$param3" "$param4"
done < /data/lg_hive/linyuebin/check_data.txt

while IFS=',' read -r param1 param2 param3 param4; do
        get_hdfs_path_size_yd "$param1" "$param2" "$param3" "$param4"
done < /data/lg_hive/linyuebin/check_data_lx.txt

chmod 755 /data/lg_hive/linyuebin/date01/flink_ssjk_data_$(date +"%Y%m%d").txt
