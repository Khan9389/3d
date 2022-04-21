package com.asia3d.web;

import com.asia3d.util.Log;


public class DefineService {

	//
	public static Log log = null;
	
	/*
	 * Ajax3DBankController.java 에 정의된 내용과 일치시킨다.
	 */
	 public enum Service
	 {
		 exh_tmpl_reg,
		 exh_tmpl_list,
		 conts_info_reg,
		 conts_info_list,
		 exh_info_reg,
		 exh_info_list,
		 exh_view_info,
		 exh_info,
		 check_tmpl_delete,
		 tmpl_info,
		 check_conts_delete,
		 user_login
	 }

	// 한 페이지 당 출력될 개수
	public static int RE_LIST_CNT=1;
	

}
