package com.asia3d.web;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.asia3d.contents.service.AjaxContentsService;
import com.asia3d.member.service.AjaxMemberService;
import com.asia3d.util.DateUtil;
import com.asia3d.util.Log;
import com.asia3d.util.StrUtil;
import com.asia3d.util.PropertyUtil;
//guava
//import com.google.common.io.ByteStreams;

/**
 * @Class Name : Ajax3DBankController.java
 * @Description : Ajax3DBankController Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2021.12.23           최초생성
 *
 * @author 3dBank
 * @since 2021.12.23
 * @version 1.0
 * @see
 *
 *  Copyright (C) by (주)쓰리디뱅크 All right reserved.
 */

@Controller
public class Ajax3DBankController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Ajax3DBankController.class);
	
	private String PROP_FILE = "/property/3dbank.properties";
	
	@Autowired
	private  AjaxMemberService ajaxMemberService;

	@Autowired
	private  AjaxContentsService ajaxContentsService;
	
	static String SEED = "PicketTown12345";
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/exhibition/AjaxAirpassController.do", method = RequestMethod.POST )
	@ResponseBody
	public Object get3DBankControllerJSON(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> params) {
		
		String jsondata = params.get("jsondata");
				
		boolean log_write = true;

		long start_time = System.currentTimeMillis(); 

		Log.print(LOGGER, "=====================================================================");
		Log.print(LOGGER, "/AjaxAirpassController.do 데이타수신 ");	
		Log.print(LOGGER, "=====================================================================");	
				
		ObjectMapper om = new ObjectMapper();
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		try {
			jsondata = URLDecoder.decode(jsondata, "UTF-8");
			Log.print(LOGGER, "[URLDecoder.decode후(1)..]>jsondata=" +jsondata);
		} catch (Exception e2) {
			Log.print(LOGGER, e2);
			resMap.put("retcode", "999");
			resMap.put("retmsg", "수신데이타 파싱에러:" + e2);
			return resMap;
		} 
		
		
		// 주석을 삭제한다.
		if(jsondata.indexOf("http:") < 0 && jsondata.indexOf("https:") < 0) 
		{
			jsondata = StrUtil.removeComment(jsondata);
		}
		jsondata = jsondata.replaceAll("”","\""); // 이상한 따옴표가...
		jsondata = jsondata.replaceAll("“","\""); // 이상한 따옴표가...

		if(log_write)
		{
			Log.print(LOGGER, "[URLDecoder.decode후(2)..]>jsondata=" +jsondata);
		}
		
		
		String service_tp = null;
		try {

        	ObjectMapper mapper = new ObjectMapper();
        	HashMap<String, Object>  jsonMap  = mapper.readValue(jsondata, HashMap.class);
        	service_tp = (String) jsonMap.get("service_tp");
        	
        	Log.print(LOGGER, "service_tp=[" +service_tp +"]");
  		
     
			String inputcheckret = null;
			//getService_tp 값에 따른 case 처리 
			switch (DefineService.Service.valueOf(service_tp))
			{
	 			case exh_tmpl_list:
	 				if((inputcheckret = check_intpufield(jsonMap,(new String[] {"service_tp"}))) != null) 
	 					break;
	 			
	 				resMap = ajaxContentsService.exh_tmpl_list(jsonMap, request);
	 				break;
	 				
					/*
					 *	 3D콘텐츠정보 리스트
					 */
		 		case conts_info_list:
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{	/* 공통부 */	"service_tp",
						/* 개별부 */	"page_num"
					}))) != null) break;

					resMap = ajaxContentsService.conts_info_list(jsonMap, request);
					break;
					
					/*
					 *	 전시회정보 리스트
					 */
		 		case exh_info_list:
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{	/* 공통부 */	"service_tp",
						/* 개별부 */	"page_num"
					}))) != null) break;

					resMap = ajaxContentsService.exhInfoList(jsonMap, request);
					break;
					
		 		case exh_view_info:
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{	/* 공통부 */	"service_tp",
						/* 개별부 */	"exh_uid"
					}))) != null) break;

					resMap = ajaxContentsService.exhibitionViewInfo(jsonMap, request);
					break;
					
		 		case exh_info:
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{	/* 공통부 */	"service_tp",
						/* 개별부 */	"exh_uid"
					}))) != null) break;

					resMap = ajaxContentsService.exhibitionInfo(jsonMap, request);
					break;
					
		 		case tmpl_info:
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{	/* 공통부 */	"service_tp",
						/* 개별부 */	"exh_tmpl_uid"
					}))) != null) break;

					resMap = ajaxContentsService.templateInfo(jsonMap, request);
					break;
					
		 		case check_tmpl_delete:
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{ 
						/* 개별부 */	"exh_tmpl_uid"
					}))) != null) break;

					resMap = ajaxContentsService.checkTmplDelete(jsonMap, request);
					break;
					
		 		case check_conts_delete:
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{ 
						/* 개별부 */	"conts_uid"
					}))) != null) break;

					resMap = ajaxContentsService.checkContsDelete(jsonMap, request);
					break;
					
				
				/*
				 *	일반회원 로그인
				 */
		 		case user_login:

					// 일반로드인
					if(jsonMap.get("sns_tp") == null || ((String)jsonMap.get("sns_tp")).length() == 0 || StrUtil.parseInt((String)jsonMap.get("sns_tp")) == 0)
					{
						if((inputcheckret = check_intpufield(jsonMap,(new String[]
								{	/* 공통부 */	"service_tp","p_login_id",
									/* 개별부 */
								}))) != null) break;

						resMap = ajaxMemberService.user_login( jsonMap, request, response);
					}
					else { // sns로그인
						resMap = ajaxMemberService.sns_login( jsonMap, request, response);
					}

					break;
		 		
				default :
					resMap.put("retcode", "991");
					resMap.put("retmsg", "알수없는 구분값임.service_tp=[" +service_tp+ "]");
					break;
			}
			
			if(inputcheckret != null)
			{
				resMap.put("retcode", "992");
				resMap.put("retmsg", inputcheckret);
			}

		} catch (Exception e) {
			
			Log.print(LOGGER, "error jsondata 수신=" + jsondata);
			
			try {
				resMap.put("retcode", "999");
				resMap.put("retmsg", "시스템오류입니다.[" + e.getMessage()+ "]");
				Log.print(LOGGER, "error 시스템오류입니다 " + e);
			} catch (Exception e1) {}
			
			Log.print(LOGGER, "error 'AjaxAirpassController.do', jsondata=" + jsondata);
			Log.print(LOGGER, e);
		}
		
		resMap.put("service_tp", service_tp);
		
		response.setHeader("retcode", (String)resMap.get("retcode"));
		response.setHeader("retmsg", (String)resMap.get("retmsg"));
		
		String jsonString = null;
		try {
			jsonString = om.writeValueAsString(resMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonString = e.getMessage();
		}
		
		Log.print(LOGGER, "결과:" + jsonString + "");
		long end_time = System.currentTimeMillis(); 
		Log.print(LOGGER, "/Ajax3DBankController.do 결과전송, 처리시간(TimeMillis)=[" + (end_time-start_time) + "]");
		Log.print(LOGGER, "=====================================================================\n\r");
		

		return resMap;
	}
	
	
	
	@RequestMapping(value = "/exhibition/downThumbImg.do", method = RequestMethod.GET)
	public ModelAndView downThumbImg(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> params) throws Exception {

		Log.print(LOGGER, "## downThumbImg.do:" + params);

		// 모바일 웹에서 캐시를 이용하는 경우 "params:{conts_uid=7946, file=3dbts000701P.jpg?1560998341519}" 넘어오는 경우가 생긴다.
		if(params != null && params.get("file") != null) {
			String file = params.get("file");
			if(file.indexOf("?") > 0) {
				params.put("file", file.substring(0, file.indexOf("?")));
				Log.print(LOGGER, "## ModelAndView downStlSpriteImg2 params(2):" + params);
			}
		} 
		
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		String file_dir = null;
		if(params != null && params.get("dir") != null && params.get("dir").equals("tmpl")) {
			file_dir = pl.get("IMG_UPLOAD_EXHIBITION_PATH") + "tmpl_uid_" + params.get("tmpl_uid") + "/";
		} else if(params != null && params.get("dir") != null && params.get("dir").equals("exh")) {
			file_dir = pl.get("IMG_UPLOAD_EXHIBITION_MAIN_PATH") + "exh_uid_" + params.get("exh_uid") + "/";
		} else {
			file_dir = pl.get("IMG_UPLOAD_CONTENTS_PATH") + "conts_uid_" + params.get("conts_uid") + "/";
		}

		Log.print(LOGGER, "## File direction ===> :  " + file_dir);
		
		request.setAttribute("fileName", params.get("file"));   //다운 받을 시 이름을 결정합니다. 빼게되면 기존에 저장된 이름으로 받습니다.
		String name = "test";
		// 캐시정보추가
		response.setHeader("Cache-Control", "max-age=31536000, immutable");
		//response.setHeader("Conent-Disposition", "attachment); filename=\"" + fileName + "\";");
		//response.setHeader("Content-Disposition", "attachment;filename=" + name + ";");
		

		File file = new File(file_dir, params.get("file"));

		return new ModelAndView("fileDownloadView","fileDownload", file);
	 }
	
	

	private String check_intpufield(Map<String, Object>  jsonMap, String field[]) {

		String retmsg = null;
		for(int i=0;i<field.length;i++)
		{
			try
			{
				if(jsonMap.get(field[i]) == null || String.valueOf(jsonMap.get(field[i])).trim().length() == 0)
				{
					retmsg = "입력필드를 확인하세요. 필드[" + field[i] + "]가 없거나 데이타가 셋팅이 안되어있음.";
					break;
				}
			}catch(Exception ee)
			{
				Log.print(LOGGER, ee);
			}
			
			if(field[i].equals("inq_start_date") || field[i].equals("inq_end_date"))
			{
				if(!DateUtil.checkDateFormat((String) jsonMap.get(field[i]), "yyyyMMdd"))
				{
					retmsg = "inq_start_date/inq_end_date는 yyyyMMdd 형식입니다. ";
					break;
				}
				
				if(StrUtil.bigCompareTo((String) jsonMap.get("inq_start_date"), (String) jsonMap.get("inq_end_date")) > 0)
				{
					retmsg = "시작날짜가 종료날짜보다 큽니다.";
					break;
				}
			}
		}
		return retmsg;
	}
}
