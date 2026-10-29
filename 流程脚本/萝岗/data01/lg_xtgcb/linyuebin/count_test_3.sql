select "lg_fsxtzx_db01.ods_qqt_view_qqtqy",count(1),nowtime as htime from lg_fsxtzx_db01.ods_qqt_view_qqtqy where file_time=lastdaytime union all
select "lg_fsxtzx_db01.ods_ts_mk_order_main_d",count(1),nowtime as htime from lg_fsxtzx_db01.ods_ts_mk_order_main_d where file_time=lastdaytime union all
select "lg_caiyun_db1.ods_t_caiyunmarket_userdraw_df",count(1),nowtime as htime from lg_caiyun_db1.ods_t_caiyunmarket_userdraw_df where dtime=lastdaytime union all
select "lg_caiyun_db1.ods_mcloudwap_wcsp_user_visit_log",count(1),nowtime as htime from lg_caiyun_db1.ods_mcloudwap_wcsp_user_visit_log where timepartition=lastdaytime union all
select "lg_caiyun_db1.ods_mcloudwap_t_caiyunmarket_mcsspaceresult_df",count(1),nowtime as htime from lg_caiyun_db1.ods_mcloudwap_t_caiyunmarket_mcsspaceresult_df where dtime=lastdaytime union all
select "lg_caiyun_db1.ods_mas_t_user_activity_status_df",count(1),nowtime as htime from lg_caiyun_db1.ods_mas_t_user_activity_status_df where dtime=lastdaytime 
