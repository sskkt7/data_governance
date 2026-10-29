#!/bin/bash
send_mail(){
     #指定收件人信息
     mails="wangguozheng@hantele.com,15012416968@139.com,19700132569@139.com,15817096146@139.com,liuziwei@richstonedt.com,chendan@hantele.com,guoyancheng@hantele.com,17266972274@139.com,changzhenzong@hantele.com,yangxiongbro@139.com,13160812824@139.com,lilingcong@hantele.com,zhupengcheng@hantele.com,maqicai@richstonedt.com"
        local mail_table="$1"
        ##,19802021025@139.com,19802021153@139.com
     #进入到发送邮件的目录下，指定邮件工具和内容发送
     cd /data01/lg_xtgcb/linyuebin/mbzh_y
     /home/dwlinyuebin1/sendEmail-v1.56/sendEmail -o tls=no -f 13160812824@139.com -t "13160812824@139.com"  -s 10.169.129.3:2227 -u "vgop每日巡检情况" -cc "$mails" -o message-content-type=html -o message-charset=utf-8 -xu 13160812824@139.com -xp Lin5724045 -o message-file="${mail_table}"
}


send_mail mail_table.html
