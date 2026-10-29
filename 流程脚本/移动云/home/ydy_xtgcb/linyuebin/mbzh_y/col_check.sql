set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select table_name,table_type,interface_code,col_name,warning_type,warning_cnt,table_cnt,update_time,cluster_name,date_format(date_sub(current_date,1),'yyyyMMdd') from (
	        select *,ROW_NUMBER() over (partition by table_name,interface_code,col_name,warning_type order by update_time desc ) as rn from  ydy_dg_db01.ods_dg_hive_warning_table_detail_rate_di where dtime=date_format(date_sub(current_date,1),'yyyyMMdd')
	) a  where (warning_cnt>0 or cast(warning_cnt as int) is null) and  rn=1
	union all 
	select table_name,table_type,interface_code,col_name,warning_type,warning_cnt,table_cnt,update_time,cluster_name,date_format(date_sub(current_date,1),'yyyyMMdd') from (
		        select *,ROW_NUMBER() over (partition by table_name,interface_code,col_name,warning_type order by update_time desc ) as rn from  ydy_dg_db01.ods_dg_hive_warning_table_detail_rate_di where dtime=date_format(add_months(current_date, -1), 'yyyyMM')
		) a  where (warning_cnt>0 or cast(warning_cnt as int) is null) and  rn=1
