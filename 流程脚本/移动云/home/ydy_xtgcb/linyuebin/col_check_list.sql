select '1',count(1) from ydy_139_db01.ods_139mail_139qymail_outgoing_traffic_di where dtime>20260825 group by dtime union all
select '2',count(1) from ydy_139_db01.ods_139mail_139qymail_spam_di where dtime>20260825 group by dtime  union all
select '3',count(1) from ydy_139_db01.ods_139mail_139qymail_content_audit_wgmx_di where dtime>20260825 group by dtime  union all
select '4',count(1) from ydy_139_db01.ods_139mail_139qymail_content_audit_yhyj_di  where dtime>20260825 group by dtime union all
select '5',count(1) from ydy_139_db01.ods_139mail_139qymail_qy_manager_changenum3_bghmrz_di where dtime>20260825 group by dtime  union all
select '6',count(1) from ydy_139_db01.ods_139mail_139qymail_qy_manager_changenum3_xzqys_di where dtime>20260825 group by dtime  union all
select '7',count(1) from ydy_139_db01.ods_139mail_139qymail_login_fail_dlrz_di where dtime>20260825 group by dtime  union all
select '8',count(1) from ydy_139_db01.ods_139mail_139qymail_login_fail_dsfdlrz where dtime>20260825 group by dtime 
