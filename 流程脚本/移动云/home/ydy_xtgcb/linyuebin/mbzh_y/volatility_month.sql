set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select associated_assets,a.business_name,a.interface_code,b.table_cnt,b.sequential_table_cnt,b.rate,b.is_alarm,date_format(date_sub(current_date,1),'yyyyMMdd')  as dtime from 
(
	select * from ydy_dg_db01.ods_dg_completenes_interface 
	where cluster_name='移动云' and field_monitoring_status is not null 
	and ((interface_type='月接口' and split(sla_timeliness,' ')[2]=date_format(date_sub(current_date,0),'d')) or 
	(interface_type='季度接口' and  split(sla_timeliness,' ')[2]=date_format(date_sub(current_date,0),'d') and split(sla_timeliness,' ')[2] in ('1','4','7','10') ))
) a
left join 
(
	select * from ydy_dg_db01.ods_dg_hive_completenes_warning_table_rate_di  where dtime=date_format(add_months(current_date, -1), 'yyyyMM') 
) b on a.interface_code=b.interface_code and a.associated_assets=concat(database_name,'.',table_name)
