select "ydy_vogp_db01.ts_139mail_rfe_model_d",count(1) from ydy_vogp_db01.ts_139mail_rfe_model_d where p_day_id=from_unixtime(unix_timestamp("lastdaytime", 'yyyyMMdd') - 86400,'yyyyMMdd') union all
select "hly_bas.tar_detail_vgop_f_rfe_daily",count(1) from hly_bas.tar_detail_vgop_f_rfe_daily where replace(dt,'-','')=from_unixtime(unix_timestamp("lastdaytime", 'yyyyMMdd') - 86400,'yyyyMMdd')
