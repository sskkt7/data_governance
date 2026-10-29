#!/bin/bash

# 定义文件路径
A_FILE="a.txt"
B_FILE="text.txt"

# 创建临时文件用于存储匹配结果
TEMP_MATCHED_FILE=$(mktemp)

# 从 b.txt 中提取表名并匹配 a.txt 的内容
while IFS=',' read -r table_name data_count date; do
    # 去掉表名两端的空格
    table_name=$(echo "$table_name" | xargs)

    # 在 a.txt 中查找匹配的记录
    grep "^$table_name|" "$A_FILE" >> "$TEMP_MATCHED_FILE"
done < "$B_FILE"
rm -f TEMP_MATCHED_FILE2
# 拼接 SQL 查询语句
echo "生成的 SQL 查询语句如下："
while IFS='|' read -r table_name table_name_ch partition column_date; do
    echo "select '$table_name','$table_name_ch',count(1),$partition from $table_name where $partition=$column_date group by $partition union all" >> TEMP_MATCHED_FILE2
done < "$TEMP_MATCHED_FILE"
sed -i ':a;N;$!ba;s/\(.*\)union all/\1/' TEMP_MATCHED_FILE2 

# 清理临时文件
rm -f "$TEMP_MATCHED_FILE"
