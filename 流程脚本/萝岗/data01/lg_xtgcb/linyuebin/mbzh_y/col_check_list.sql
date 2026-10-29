set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select distinct a.interface_code,a.associated_assets,b.table_name,interface_type,field_monitoring_status,date_format(date_sub(current_date,1),'yyyyMMdd') from
(select * from lg_dg_db01.ods_dg_completenes_interface 
where cluster_name='萝岗' and field_monitoring_status is not null 
and ((interface_type='月接口' and split(sla_timeliness,' ')[2]=date_format(date_sub(current_date,0),'d'))
or (interface_type='周接口' and split(sla_timeliness,' ')[4]=dayofweek(date_sub(current_date,0))-1)
or interface_type='日接口') ) a
left join
(
select * from lg_dg_db01.ods_dg_hive_warning_table_detail_rate_di where dtime>=date_format(date_sub(current_date,1),'yyyyMMdd') and table_name not in ('jingfen.ts_ydyp_data_space_day','jingfen.ts_ydyp_rfe_w') and cast(table_cnt as bigint)>0
union all
select * from lg_dg_db01.ods_dg_hive_warning_table_detail_rate_di where dtime=date_format(date_sub(current_date,2),'yyyyMMdd') and table_name in ('jingfen.ts_ydyp_data_space_day','jingfen.ts_ydyp_rfe_w')  and cast(table_cnt as bigint)>0
union all
select * from lg_dg_db01.ods_dg_hive_warning_table_detail_rate_di where dtime=date_format(add_months(current_date, -1), 'yyyyMM')  and cast(table_cnt as bigint)>0
) b on a.associated_assets=b.table_name and a.interface_code=b.interface_code
