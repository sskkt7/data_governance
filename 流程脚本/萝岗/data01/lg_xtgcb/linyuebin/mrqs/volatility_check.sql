set mapreduce.map.memory.mb=6144;
set mapreduce.map.java.opts=-Xmx4608m;
set mapreduce.job.priority=HIGH;
select a.table_name,a.table_name_ch,a.table_classify,a.lessee,a.project_team,a.table_score,a.table_cnt,a.status,a.deduction_reason,b.table_score as table_score2,b.deduction_reason as deduction_reason2,a.dtime from 
(select *
from lg_dg_db01.ads_dg_quality_timeliness_core_di where dtime>=20250901 and dtime<=20250901 and  table_classify rlike '核心|宽表|埋点|标签' ) a
inner join 
(select * from  lg_dg_db01.ads_dg_quality_completenes_cntscore_di where dtime>=20250901 and dtime<=20250901 and  table_classify rlike '核心|宽表|埋点|标签' ) b
on a.table_name=b.table_name and a.dtime=b.dtime
