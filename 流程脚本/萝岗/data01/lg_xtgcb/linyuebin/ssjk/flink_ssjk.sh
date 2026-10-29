#!/bin/bash

get_hdfs_path_size() {
    local hdfs_path=$1$(date -d "2 day ago" +"%Y$2%m$3%d")$4
    local table_name=$5


    local current_time=$(date +"%Y-%m-%d %H:%M:%S")
    local path_size=$(hadoop fs -du -s "$hdfs_path" 2>/dev/null|  awk '{sum+=$1} END {print sum}' )
    hadoop fs -du -s "$hdfs_path"

    if [ $? -ne 0 ]; then
        echo "连接错误或路径不存在"
        echo "$table_name,$hdfs_path,$path_size,连接错误或路径不存在,$current_time" >> /home/dwlinyuebin1/linyuebin/ssjk/date01/flink_ssjk_data_$(date  -d "2 day ago" +"%Y%m%d").txt
        return 1 # 连接错误或路径不存在，返回非0值
    fi


    echo "$table_name,$hdfs_path,$path_size,返回正常,$current_time" >> /home/dwlinyuebin1/linyuebin/ssjk/date01/flink_ssjk_data_$(date  -d "1 day ago" +"%Y%m%d").txt
        return 0
}


# 遍历文件的每一行
while IFS=',' read -r param1 param2 param3 param4 param5; do
        get_hdfs_path_size "$param1" "$param2" "$param3" "$param4" "$param5"
        if [ $? -ne 0 ]; then
           echo "函数错误"
        fi
done < /home/dwlinyuebin1/linyuebin/ssjk/check_data.txt
