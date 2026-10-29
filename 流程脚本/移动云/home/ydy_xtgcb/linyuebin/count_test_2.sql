insert into table  ydy_dg_db01.ods_dg_hive_table_cnt_hour_di partition(dtime=lastdaytime,htime=nowtime)
select * from (
	select "ydy_ydrz_szr_db01.ods_ydrz_szr_user_tag_df",count(1) from ydy_ydrz_szr_db01.ods_ydrz_szr_user_tag_df where dtime=lastdaytime union all
	select "ydy_ydrz_szr_db01.ods_ydrz_szr_user_info_df",count(1) from ydy_ydrz_szr_db01.ods_ydrz_szr_user_info_df where dtime=lastdaytime union all
	select "ydy_ydrz_szr_db01.ods_ydrz_szr_digit_auth_user_info_df",count(1) from ydy_ydrz_szr_db01.ods_ydrz_szr_digit_auth_user_info_df where dtime=lastdaytime union all
	select "ydy_ydrz_szr_db01.ods_ydrz_szr_user_sdk_call_log_di",count(1) from ydy_ydrz_szr_db01.ods_ydrz_szr_user_sdk_call_log_di where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_general_event_tracking_di",count(1) from ydy_kb_db01.dwd_ydrz_szr_general_event_tracking_di where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_general_event_tracking_value_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_general_event_tracking_value_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_general_event_tracking_vlevel_di",count(1) from ydy_kb_db01.dwd_ydrz_szr_general_event_tracking_vlevel_di where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_avatar_category_rel_product_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_avatar_category_rel_product_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_avatar_order_item_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_avatar_order_item_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_avatar_pay_info_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_avatar_pay_info_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_avatar_order_main_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_avatar_order_main_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_avatar_product_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_avatar_product_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_avatar_product_category_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_avatar_product_category_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_avatar_product_type_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_avatar_product_type_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_base_data_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_base_data_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_bis_ap_id_info_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_bis_ap_id_info_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_bis_app_configure_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_bis_app_configure_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_bis_app_info_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_bis_app_info_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_cloud_avatar_category_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_cloud_avatar_category_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_cloud_avatar_item_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_cloud_avatar_item_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_cloud_user_active_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_cloud_user_active_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_user_sign_in_record_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_user_sign_in_record_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_user_tag_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_user_tag_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_user_info_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_user_info_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_digit_auth_user_info_df",count(1) from ydy_kb_db01.dwd_ydrz_szr_digit_auth_user_info_df where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydrz_szr_user_sdk_call_log_di",count(1) from ydy_kb_db01.dwd_ydrz_szr_user_sdk_call_log_di where dtime=lastdaytime union all
	select "ydy_vogp_db01.ts_gsm_brand_active_d",count(1) from ydy_vogp_db01.ts_gsm_brand_active_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.ts_gsm_exclusive_service_d",count(1) from ydy_vogp_db01.ts_gsm_exclusive_service_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.ts_public_welfare_d",count(1) from ydy_vogp_db01.ts_public_welfare_d where p_day_id=lastdaytime union all
	select "hly_bas.tar_detail_vgop_f_ord_daily",count(1) from hly_bas.tar_detail_vgop_f_ord_daily where replace(dt,'-','')=lastdaytime union all
	select "ydy_vogp_db01.tw_cloud_phone_17202",count(1) from ydy_vogp_db01.tw_cloud_phone_17202 where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.tw_cloud_phone_access_17205",count(1) from ydy_vogp_db01.tw_cloud_phone_access_17205 where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.tw_cloud_phone_serial_flow_17206_d",count(1) from ydy_vogp_db01.tw_cloud_phone_serial_flow_17206_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.tw_ydyp_ysj_dggm_d",count(1) from ydy_vogp_db01.tw_ydyp_ysj_dggm_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.tw_ydyp_ysj_dggm_active_d",count(1) from ydy_vogp_db01.tw_ydyp_ysj_dggm_active_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.tw_cloud_phone_20013_day",count(1) from ydy_vogp_db01.tw_cloud_phone_20013_day where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.tw_cloud_phone_key_monit_17101_d",count(1) from ydy_vogp_db01.tw_cloud_phone_key_monit_17101_d where p_day_id=lastdaytime union all
	select "ydy_kb_db01.dwd_zjh_ebpt_ytx_voicelog_di",count(1) from ydy_kb_db01.dwd_zjh_ebpt_ytx_voicelog_di where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_yzd_ysj_std_cloud_phone_online_time_span_di",count(1) from ydy_kb_db01.dwd_yzd_ysj_std_cloud_phone_online_time_span_di where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_yzd_ysj_std_user_cloud_phone_di",count(1) from ydy_kb_db01.dwd_yzd_ysj_std_user_cloud_phone_di where dtime=lastdaytime union all
	select "ydy_kb_db01.dwd_ydyp_oceanbase_group_info_df",count(1) from ydy_kb_db01.dwd_ydyp_oceanbase_group_info_df where dtime=lastdaytime union all
	select "hly_bas.tar_detail_vgop_i_bound_daily",count(1) from hly_bas.tar_detail_vgop_i_bound_daily where replace(dt,'-','')=lastdaytime union all
	select "hly_bas.tar_detail_vgop_i_login_daily",count(1) from hly_bas.tar_detail_vgop_i_login_daily where replace(dt,'-','')=lastdaytime union all
	select "hly_bas.tar_detail_vgop_i_sk_daily",count(1) from hly_bas.tar_detail_vgop_i_sk_daily where replace(dt,'-','')=lastdaytime union all
	select "hly_bas.tar_detail_vgop_i_operate_daily",count(1) from hly_bas.tar_detail_vgop_i_operate_daily where replace(dt,'-','')=lastdaytime union all
	select "hly_bas.tar_detail_vgop_f_usb_daily",count(1) from hly_bas.tar_detail_vgop_f_usb_daily where replace(dt,'-','')=lastdaytime union all
	select "hly_bas.tar_detail_vgop_i_msg_daily",count(1) from hly_bas.tar_detail_vgop_i_msg_daily where replace(dt,'-','')=lastdaytime union all
	select "ydy_vogp_db01.ts_hdh_car2_user_24207_d",count(1) from ydy_vogp_db01.ts_hdh_car2_user_24207_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.ts_hdh_business_monitor_index_24101_d",count(1) from ydy_vogp_db01.ts_hdh_business_monitor_index_24101_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.dim_hdh_business_type_24301_d",count(1) from ydy_vogp_db01.dim_hdh_business_type_24301_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.dim_hdh_user_account_open_24302_d",count(1) from ydy_vogp_db01.dim_hdh_user_account_open_24302_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.dim_hdh_deputy_shutdown_sign_24303_d",count(1) from ydy_vogp_db01.dim_hdh_deputy_shutdown_sign_24303_d where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.dim_hdh_user_type_24304_d",count(1) from ydy_vogp_db01.dim_hdh_user_type_24304_d where p_day_id=lastdaytime union all
	select "hly_bas.tar_detail_vgop_i_mango_daily",count(1) from hly_bas.tar_detail_vgop_i_mango_daily where replace(dt,'-','')=lastdaytime union all
	select "hly_bas.rpt_vgop_business_daily",count(1) from hly_bas.rpt_vgop_business_daily where replace(report_date,'-','')=lastdaytime union all
	select "ydy_vogp_db01.tr_ydyp_cloud_succ_record",count(1) from ydy_vogp_db01.tr_ydyp_cloud_succ_record where p_day_id=lastdaytime union all
	select "ydy_vogp_db01.ts_ysj_qpjl_d",count(1) from ydy_vogp_db01.ts_ysj_qpjl_d where p_day_id=lastdaytime union all
       select "ydy_kb_db01.dwd_hly_tar_detail_vgop_f_ord_daily_df",count(1) from ydy_kb_db01.dwd_hly_tar_detail_vgop_f_ord_daily_df where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_hly_tar_detail_vgop_f_usb_daily_df",count(1) from ydy_kb_db01.dwd_hly_tar_detail_vgop_f_usb_daily_df where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_hly_tar_detail_vgop_i_login_daily_di",count(1) from ydy_kb_db01.dwd_hly_tar_detail_vgop_i_login_daily_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_hly_tar_detail_vgop_i_operate_daily_di",count(1) from ydy_kb_db01.dwd_hly_tar_detail_vgop_i_operate_daily_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_hly_tar_detail_vgop_i_bound_daily_di",count(1) from ydy_kb_db01.dwd_hly_tar_detail_vgop_i_bound_daily_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_hly_tar_detail_vgop_i_msg_daily_di",count(1) from ydy_kb_db01.dwd_hly_tar_detail_vgop_i_msg_daily_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_hly_tar_detail_vgop_i_sk_daily_di",count(1) from ydy_kb_db01.dwd_hly_tar_detail_vgop_i_sk_daily_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_cjsim_tb_mobile_sign_job_log_df",count(1) from ydy_kb_db01.dwd_cjsim_tb_mobile_sign_job_log_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_139mail_dim_market_opr_key_df",count(1) from ydy_sjznew_db01.imp_139mail_dim_market_opr_key_df  union all
select "ydy_sjznew_db01.imp_139mail_mail_dw_dwd_check_pe_user_install_detail_all_01_df",count(1) from ydy_sjznew_db01.imp_139mail_mail_dw_dwd_check_pe_user_install_detail_all_01_df  union all
select "ydy_sjznew_db01.imp_139mail_mail_dw_dwd_log_imap_mail_detail_d_di",count(1) from ydy_sjznew_db01.imp_139mail_mail_dw_dwd_log_imap_mail_detail_d_di where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_139mail_mail_ods_dim_write_oper_actions_df",count(1) from ydy_sjznew_db01.imp_139mail_mail_ods_dim_write_oper_actions_df union all
select "ydy_sjznew_db01.imp_139mail_mail_ods_t_dc_deliverorder_df",count(1) from ydy_sjznew_db01.imp_139mail_mail_ods_t_dc_deliverorder_df  union all
select "ydy_sjznew_db01.imp_139mail_ods_user_domain_user_privacy_di",count(1) from ydy_sjznew_db01.imp_139mail_ods_user_domain_user_privacy_di where concat(year,month,day)=lastdaytime union all
select "ydy_sjznew_db01.imp_5ginfo_hfx_kr_ts_rhtx_5gms_lingxi_zndh_userqa_log_qingxi_day_di",count(1) from ydy_sjznew_db01.imp_5ginfo_hfx_kr_ts_rhtx_5gms_lingxi_zndh_userqa_log_qingxi_day_di where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_5ginfo_hfx_ods_tr_5gms_sc_zaowanan_user_info_d_df",count(1) from ydy_sjznew_db01.imp_5ginfo_hfx_ods_tr_5gms_sc_zaowanan_user_info_d_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_mail139_mail_dw_dwd_service_mail_deliver_detail_cd",count(1) from ydy_sjznew_db01.imp_mail139_mail_dw_dwd_service_mail_deliver_detail_cd where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ods_ccop_t_content_df",count(1) from ydy_sjznew_db01.imp_ods_ccop_t_content_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ods_cloudphone_product_item_specification_df",count(1) from ydy_sjznew_db01.imp_ods_cloudphone_product_item_specification_df  union all
select "ydy_sjznew_db01.imp_ods_okr_cloudphone_pay_df",count(1) from ydy_sjznew_db01.imp_ods_okr_cloudphone_pay_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ads_market_act_unsubscribe_df",count(1) from ydy_sjznew_db01.imp_ydyp_ads_market_act_unsubscribe_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_dim_asset_contenttype_df",count(1) from ydy_sjznew_db01.imp_ydyp_dim_asset_contenttype_df  union all
select "ydy_sjznew_db01.imp_ydyp_dw_dwd_share_interface_log_d_di",count(1) from ydy_sjznew_db01.imp_ydyp_dw_dwd_share_interface_log_d_di where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_dw_dwm_indicator_user_type_d_di",count(1) from ydy_sjznew_db01.imp_ydyp_dw_dwm_indicator_user_type_d_di where concat(year,month,day)=lastdaytime  union all
select "ydy_sjznew_db01.imp_ydyp_dw_ispace_outerlink_shared_servnumber_di",count(1) from ydy_sjznew_db01.imp_ydyp_dw_ispace_outerlink_shared_servnumber_di where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_album_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_album_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_file_label_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_file_label_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_global_config_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_ablum_saas_pro_photo_global_config_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_ccop_t_category_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_ccop_t_category_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_ccop_t_content_file_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_ccop_t_content_file_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_dynamic_comment_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_dynamic_comment_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_dynamic_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_dynamic_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_info_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_info_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_member_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_hcyqz_pro_group_member_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mas_t_caiyunmarket_prizepool_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mas_t_caiyunmarket_prizepool_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mas_t_caiyunmarket_userdraw_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mas_t_caiyunmarket_userdraw_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mas_t_cloud_record_2025_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mas_t_cloud_record_2025_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mas_t_clouduser_2025_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mas_t_clouduser_2025_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mas_t_sms_reply_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mas_t_sms_reply_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mas_t_user_activity_status_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mas_t_user_activity_status_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mas_u_business_roster_black_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mas_u_business_roster_black_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_mcloudwap_t_caiyunmarket_mcsspaceresult_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_mcloudwap_t_caiyunmarket_mcsspaceresult_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_member_product_prod_t_goods_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_member_product_prod_t_goods_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_member_vip_sub_t_invite_relation_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_member_vip_sub_t_invite_relation_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_orddb_ord_t_user_info_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_orddb_ord_t_user_info_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_user_domain_user_info_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_user_domain_user_info_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_yp_interface_log_di",count(1) from ydy_sjznew_db01.imp_ydyp_ods_yp_interface_log_di where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_yun_member_vsbo_grp_t_benefit_order_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_yun_member_vsbo_grp_t_benefit_order_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_ods_yun_share_share_open_link_record_df",count(1) from ydy_sjznew_db01.imp_ydyp_ods_yun_share_share_open_link_record_df where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_push_reach_situation_new_di",count(1) from ydy_sjznew_db01.imp_ydyp_push_reach_situation_new_di where dtime=lastdaytime union all
select "ydy_sjznew_db01.imp_ydyp_tmp_ghz_test_ghz_0205_1_du",count(1) from ydy_sjznew_db01.imp_ydyp_tmp_ghz_test_ghz_0205_1_du union all
select "ydy_sjznew_db01.imp_ydyp_tmp_ljl_activity_type_du",count(1) from ydy_sjznew_db01.imp_ydyp_tmp_ljl_activity_type_du  union all
select "ydy_sjznew_db01.imp_ydyp_tmp_lry_member_grade_type_20250414_du",count(1) from ydy_sjznew_db01.imp_ydyp_tmp_lry_member_grade_type_20250414_du  union all
select "ydy_sjznew_db01.imp_yzd_ysj_tb_dws_kpi_dailyreport_offer_cde_l_df",count(1) from ydy_sjznew_db01.imp_yzd_ysj_tb_dws_kpi_dailyreport_offer_cde_l_df where dtime=lastdaytime union all
select "ydy_dim_db01.dim_app_list_remake",count(1) from ydy_dim_db01.dim_app_list_remake where dt=lastdaytime union all
select "ydy_dim_db01.dim_behavior_category_full",count(1) from ydy_dim_db01.dim_behavior_category_full  union all
select "ydy_dim_db01.dim_behavior_category_full_v2",count(1) from ydy_dim_db01.dim_behavior_category_full_v2  union all
select "ydy_dim_db01.dim_chinese_city_level_2024_full",count(1) from ydy_dim_db01.dim_chinese_city_level_2024_full  union all
select "ydy_dim_db01.dim_ydyp_mcloud_behavior",count(1) from ydy_dim_db01.dim_ydyp_mcloud_behavior union all
select "ydy_kb_db01.dwd_hdh_grbhdh_mcn_user_minor_df",count(1) from ydy_kb_db01.dwd_hdh_grbhdh_mcn_user_minor_df where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_hdh_yhszd_mcn_ckuser_minor_df",count(1) from ydy_kb_db01.dwd_hdh_yhszd_mcn_ckuser_minor_df where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_sjzt_hs_behavior_event_tracking_ydyp_di_view",count(1) from ydy_kb_db01.dwd_sjzt_hs_behavior_event_tracking_ydyp_di_view where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_ydyp_oceanbase_group_dynamic_assets_df",count(1) from ydy_kb_db01.dwd_ydyp_oceanbase_group_dynamic_assets_df where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_ydyp_ods_subdb_sub_t_rights_package_df",count(1) from ydy_kb_db01.dwd_ydyp_ods_subdb_sub_t_rights_package_df where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_yzd_ysj_kp_freetraffic_order_df",count(1) from ydy_kb_db01.dwd_yzd_ysj_kp_freetraffic_order_df where dtime=lastdaytime union all
select "ydy_sjz_db01.lg_dxzt_db01_dxzt_139mail_freq_cnt",count(1) from ydy_sjz_db01.lg_dxzt_db01_dxzt_139mail_freq_cnt where day_time=lastdaytime union all
select "ydy_sjz_db01.dw_dwd_huadan_note_user_act_d",count(1) from ydy_sjz_db01.dw_dwd_huadan_note_user_act_d where concat(year,month,day)=lastdaytime union all
select "ydy_sjz_db01.eds_tw_term_sc_portrait_m_new",count(1) from ydy_sjz_db01.eds_tw_term_sc_portrait_m_new  union all
select "ydy_sjz_db01.eds_tw_waters_travel_off_ident_m_new",count(1) from ydy_sjz_db01.eds_tw_waters_travel_off_ident_m_new  union all
select "ydy_sjz_db01.imp_mail_dw_dwm_check_active_user_detail_cd_01_di",count(1) from ydy_sjz_db01.imp_mail_dw_dwm_check_active_user_detail_cd_01_di where dtime=lastdaytime union all
select "ydy_sjz_db01.imp_ydyp_ods_mas_t_fissonactivity_invite",count(1) from ydy_sjz_db01.imp_ydyp_ods_mas_t_fissonactivity_invite  union all
select "ydy_sjz_db01.imp_ydyp_ods_mas_t_fissonactivity_invite_detail",count(1) from ydy_sjz_db01.imp_ydyp_ods_mas_t_fissonactivity_invite_detail  union all
select "ydy_sjz_db01.lg_dxzt_db01_dxzt_xysm_black_info",count(1) from ydy_sjz_db01.lg_dxzt_db01_dxzt_xysm_black_info where day_time=lastdaytime union all
select "ydy_sjz_db01.lg_hcyyx_db01_dwd_business_roster_area",count(1) from ydy_sjz_db01.lg_hcyyx_db01_dwd_business_roster_area  union all
select "ydy_sjz_db01.lg_hcyyx_db01_ods_u_bding_info",count(1) from ydy_sjz_db01.lg_hcyyx_db01_ods_u_bding_info where dtime=lastdaytime union all
select "ydy_sjz_db01.ods_click_event_log_d",count(1) from ydy_sjz_db01.ods_click_event_log_d where p_day_id=lastdaytime union all
select "ydy_sjz_db01.ods_mas_t_caiyunmarket_userdraw_day",count(1) from ydy_sjz_db01.ods_mas_t_caiyunmarket_userdraw_day where concat(year,month,day)=lastdaytime union all
select "ydy_sjz_db01.lg_ysj_db01_tr_ysj_app_usage_d",count(1) from ydy_sjz_db01.lg_ysj_db01_tr_ysj_app_usage_d where p_day_id=lastdaytime union all
select "ydy_sjznew_db01.imp_mc_number_portability_detail_df",count(1) from ydy_sjznew_db01.imp_mc_number_portability_detail_df where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_jfpt_stage_ts_openbccs_ability_np_di",count(1) from ydy_kb_db01.dwd_jfpt_stage_ts_openbccs_ability_np_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_cjsim_shb_tml_sup_sim_silver_hair_guardian_log_report_day_di",count(1) from ydy_kb_db01.dwd_cjsim_shb_tml_sup_sim_silver_hair_guardian_log_report_day_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_5ginfo_sjpt_sc_mt_chan_mt_message_log_di",count(1) from ydy_kb_db01.dwd_5ginfo_sjpt_sc_mt_chan_mt_message_log_di where dtime=lastdaytime union all
select "ydy_kb_db01.dwd_yzd_ysj_std_subs_login_lock_day_df",count(1) from ydy_kb_db01.dwd_yzd_ysj_std_subs_login_lock_day_df where dtime=20260713 union all 
select "ydy_sim_db01.tml_auth_sup_sim_guardian_relationship_day",count(1) from ydy_sim_db01.tml_auth_sup_sim_guardian_relationship_day where p_day_id=lastdaytime union all 
select "ydy_sim_db01.tw_auth_sim_simquick_users_his_day_new",count(1) from ydy_sim_db01.tw_auth_sim_simquick_users_his_day_new where p_day_id=lastdaytime union all 
select "ydy_sim_db01.tr_hair_goods_code_order_usr",count(1) from ydy_sim_db01.tr_hair_goods_code_order_usr where p_day_id=lastdaytime union all 
select "ydy_sim_db01.op_maiby_lihua_info_bushan",count(1) from ydy_sim_db01.op_maiby_lihua_info_bushan where p_day_id=lastdaytime union all 
select "ydy_sim_db01.ts_cj_sim_goods_code_order_d",count(1) from ydy_sim_db01.ts_cj_sim_goods_code_order_d where p_day_id=lastdaytime union all 
select "ydy_sim_db01.tw_auth_sim_user_person_his_day_new",count(1) from ydy_sim_db01.tw_auth_sim_user_person_his_day_new where p_day_id=lastdaytime union all 
select "ydy_sim_db01.ttt_hair_goods_code_active_zifa_month",count(1) from ydy_sim_db01.ttt_hair_goods_code_active_zifa_month where p_day_id=lastdaytime union all 
select "ydy_sim_db01.tw_hair_goods_code_active_usr_day",count(1) from ydy_sim_db01.tw_hair_goods_code_active_usr_day where p_day_id=lastdaytime union all 
select "ydy_sim_db01.tmp_leiy_shb_op_code_info",count(1) from ydy_sim_db01.tmp_leiy_shb_op_code_info where p_day_id=lastdaytime 
) a distribute by lastdaytime
