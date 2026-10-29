set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select a.table_name,
a.business_name,
a.interface_code,
a.table_cnt,
a.table_cnt_avg,
a.table_cnt_stddev,
b.table_cnt_y,
case when a.is_normal_data='异常数据' or b.is_normal_data='异常数据' then '异常数据' else '正常数据' end as  is_normal_data,
a.dtime from 
(select * from lg_dg_db01.dws_dg_vgop_quality_completeness_volatility_di where dtime=date_format(date_sub(current_date,1),'yyyyMMdd')) a 
left join 
(select * from lg_dg_db01.dws_dg_vgop_quality_completeness_dod_volatility_di  where dtime=date_format(date_sub(current_date,1),'yyyyMMdd')) b  on a.table_name=b.table_name and a.interface_code=b.interface_code 
