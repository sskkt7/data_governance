#!/bin/bash

# 自动获取今天日期
today=$(date +%Y%m%d)
# 获取星期 (1=周一, 2=周二, 3=周三, 4=周四, 5=周五, 6=周六,7=周日)
week=$(date +%u)

case $week in
    2|3|4)
        # 周二、三、四 → 本周一
        date=$(date -d "$today -$(($week-1)) days" +%Y%m%d)
        ;;
    5|6|7)
        # 周五、六、日 → 本周四
        date=$(date -d "$today -$(($week-4)) days" +%Y%m%d)
        ;;
    1)
        # 周一 → 上周四
        date=$(date -d "$today -4 days" +%Y%m%d)
        ;;
esac

# 输出结果
echo "今天日期：$today"
echo "ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_file_label_df|首页推荐|dtime|$date"
