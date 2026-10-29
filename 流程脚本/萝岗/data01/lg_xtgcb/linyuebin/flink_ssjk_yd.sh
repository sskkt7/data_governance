#!/bin/bash

get_hdfs_path_size_yd() {
    local hdfs_path=$1$(date -d "1 day ago" +"%Y$2%m$3%d")$4
    local table_name=$5


    local current_time=$(date +"%Y-%m-%d %H:%M:%S")
    local path_size=$(/usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path" 2>/dev/null| awk '{sum+=$1} END {print sum}' )
    /usr/bch/3.0.1/hadoop/bin/hdfs dfs  -du -s "$hdfs_path"

    if [ $? -ne 0 ]; then
        echo "连接错误或路径不存在"
        echo "$table_name,$hdfs_path,$path_size,连接错误或路径不存在,$current_time" >> /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date -d "1 day ago" +"%Y%m%d")_001.txt
        return 1 # 连接错误或路径不存在，返回非0值
    fi


    echo "$table_name,$hdfs_path,$path_size,返回正常,$current_time" >> /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date -d "1 day ago" +"%Y%m%d")_001.txt
        return 0
}


while IFS=',' read -r param1 param2 param3 param4 param5; do
        get_hdfs_path_size_yd "$param1" "$param2" "$param3" "$param4" "$param5"
done < /data01/lg_xtgcb/linyuebin/check_data_lx.txt



file_path="/data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date -d "15 day ago" +"%Y%m%d")_001.txt"
if [ -f "$file_path" ]; then
  echo "Found file: $file_path"
  rm "$file_path"
  echo "File deleted successfully."
else
  echo "File not found: $file_path"
fi

chmod 755 /data01/lg_xtgcb/linyuebin/date01/flink_ssjk_data_$(date -d "1 day ago" +"%Y%m%d")_001.txt
