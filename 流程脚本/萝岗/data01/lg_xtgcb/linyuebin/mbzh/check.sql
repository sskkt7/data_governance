set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select table_name,table_name_ch,table_cnt,dtime from  lg_dg_db01.ads_dg_quality_completenes_cntscore_di where dtime =date_format(date_sub(current_date,1),'yyyyMMdd') and table_classify rlike '集团' and table_name not in ('jingfen.ts_ydyp_data_space_day','jingfen.ts_ydyp_rfe_w')
union all
select table_name,table_name_ch,table_cnt,dtime from  lg_dg_db01.ads_dg_quality_completenes_cntscore_di where dtime =date_format(date_sub(current_date,2),'yyyyMMdd') and table_classify rlike '集团' and table_name  in ('jingfen.ts_ydyp_data_space_day','jingfen.ts_ydyp_rfe_w')
