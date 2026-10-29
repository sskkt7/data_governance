# -*- coding: utf-8 -*-
import smtplib
from email.mime.text import MIMEText
from email.header import Header

# 配置信息
smtp_server = "10.169.129.3"  # 替换为实际服务器地址
port = 2227                        # 替换为实际端口（如 465/587）
sender = "13160812824@139.com" # 发件人邮箱
password = "2843c270663cb6e53c00"        # 邮箱密码或授权码
receiver = "13160812824@139.com"  # 收件人邮箱

# 构造邮件内容
msg = MIMEText("这是一封自动发送的测试邮件。", "plain", "utf-8")
msg["From"] = Header("发件人名称 <%s>" % sender, "utf-8")  # 发件人显示名称
msg["To"] = Header("收件人名称 <%s>" % receiver, "utf-8")  # 收件人显示名称
msg["Subject"] = Header("Python 2 邮件测试", "utf-8")
# 提前声明 server 变量
server = None

try:
    # 根据端口选择加密方式
    if port == 2227:
        server = smtplib.SMTP_SSL(smtp_server, port)
    elif port == 587:
        server = smtplib.SMTP(smtp_server, port)
        server.starttls()  # 启用 TLS 加密
    else:
        server = smtplib.SMTP(smtp_server, port)

    # 登录邮箱
    server.login(sender, password)
    # 发送邮件
    server.sendmail(sender, [receiver], msg.as_string())
    print("邮件发送成功！")

except smtplib.SMTPException as e:
    print("发送失败，错误信息：", str(e))
finally:
    server.quit()  # 关闭连接
    # 确保 server 已定义后再调用 quit()
    if server is not None:
        server.quit()
