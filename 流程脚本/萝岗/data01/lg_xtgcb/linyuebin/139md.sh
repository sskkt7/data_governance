#!/bin/bash
   send_mail(){
        #指定收件人信息
        mails="13160812824@139.com,chenhuiling@hantele.com,13825010309@139.com,zhanghuiguan@hantele.com,sunmingchao@hantele.com,lilingcong@hantele.com,xuzhimin@hantele.com,zhupengcheng@hantele.com"
        ##19802021025@139.com,19802021153@139.com
        local mail_table="$1"
        #进入到发送邮件的目录下，指定邮件工具和内容发送
        cd /home/ydy_xtgcb/linyuebin/mbzh_y
      sudo /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.3.52.3:2227 -u "移动云vgop每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
}

hdfs dfs -du -sh  hdfs://ns1/user/bdoc/33/hive/ydy_kb_db01/dwd_sjzt_hs_behavior_event_tracking_139mail_di/dtime=20251229 >  /home/ydy_xtgcb/linyuebin/139.txt

send_mail "/home/ydy_xtgcb/linyuebin/139.txt"
