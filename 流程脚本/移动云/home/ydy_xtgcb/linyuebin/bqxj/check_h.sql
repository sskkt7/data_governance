set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select 
    a.table_name,
count(1) as total_cnt,
    count(if(table_cnt=0 or table_cnt is null,null,'1')) as valid_cnt,
    date_format(date_sub(current_date,1),'yyyyMMdd') as dtime
from
(
	    select * 
	    from ydy_dg_db01.dim_dg_public_organization  
	    where table_classify rlike '标签'
) a  
left join
(
	    select 
	        *,
		        ROW_NUMBER() over (partition by table_name,dtime order by htime desc) as rn 
			    from ydy_dg_db01.ods_dg_hive_table_cnt_hour_di
			    where dtime>=date_format(date_sub(current_date,16),'yyyyMMdd')
		) b 
		on a.table_name=b.table_name and b.rn=1 
		group by a.table_name 
		having count(if(table_cnt=0 or table_cnt is null,null,'1'))<=8;
