set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select a.table_name,a.table_name_ch,b.table_cnt,date_format(date_sub(current_date,1),'yyyyMMdd')  as dtime from 

(select * from ydy_dg_db01.dim_dg_public_organization  where table_classify rlike '标签' )  a   left join 
(
	                select *,ROW_NUMBER() over (partition by table_name order by htime desc) as rn from ydy_dg_db01.ods_dg_hive_table_cnt_hour_di where dtime=date_format(date_sub(current_date,1),'yyyyMMdd') 
			        ) b on a.table_name=b.table_name and b.rn=1
