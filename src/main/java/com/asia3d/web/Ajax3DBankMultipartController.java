package com.asia3d.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.asia3d.contents.service.AjaxContentsService;
import com.asia3d.member.service.AjaxMemberService;
import com.asia3d.util.DateUtil;
import com.asia3d.util.Log;
import com.asia3d.util.StrUtil;

/**
 * @Class Name : Ajax3DBankMultipartController.java
 * @Description : Ajax3DBankMultipartController Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2021.12.20           최초생성
 *
 * @author 3dBank
 * @since 2021.12.20
 * @version 1.0
 * @see
 *
 *  Copyright (C) by (주)쓰리디뱅크 All right reserved.
 */

@Controller
public class Ajax3DBankMultipartController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Ajax3DBankMultipartController.class);
	
	@Autowired
	private  AjaxContentsService ajaxContentsService;
	
	//static String SEED = "PicketTown12345";
	
	
	@RequestMapping(value = "/exhibition/AjaxAirpassMultipartController.do", method = RequestMethod.POST )
	@ResponseBody
	public Object getBeaconMultipartControllerJSON(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, String> params) {
												
		String jsondata = params.get("jsondata");
				
		boolean log_write = true;


		long start_time = System.currentTimeMillis(); 

		Log.print(LOGGER, "=====================================================================");
		Log.print(LOGGER, "test /AjaxAirpassMultipartController.do 데이타수신 ");		
		Log.print(LOGGER, "=====================================================================");	
				
		ObjectMapper om = new ObjectMapper();
		
		Map<String, Object> resMap = new HashMap<String, Object>();
		
		try {
			jsondata = URLDecoder.decode(jsondata, "UTF-8");
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			Log.print(LOGGER, e2);
			resMap.put("retcode", "999");
			resMap.put("retmsg", "수신데이타 파싱에러:" + e2);
			return resMap;
		} 
		
		
		// 주석을 삭제한다.
		jsondata = StrUtil.removeComment(jsondata);
		jsondata = jsondata.replaceAll("”","\""); // 이상한 따옴표가...
		jsondata = jsondata.replaceAll("“","\""); // 이상한 따옴표가...

		if(log_write)
		{
			Log.print(LOGGER, " test [URLDecoder.decode후..]\n>jsondata=" +jsondata);
		}
		
		List<MultipartFile> aMultipartFile = new ArrayList();
		
		if (request instanceof MultipartHttpServletRequest)
		{
		   MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		   aMultipartFile.addAll(multipartRequest.getFiles("file[]"));

		   for(int i=0;i<aMultipartFile.size();i++)
		   {
			   if(aMultipartFile.get(i).getOriginalFilename() == null || 
					   aMultipartFile.get(i).getOriginalFilename().trim().length() == 0)
			   {
				   aMultipartFile.remove(i);
				   i --; // 이거 중요..
			   }
		   }
		   
		   // 디버깅
		   for(int i=0;i<aMultipartFile.size();i++) {
			   Log.print(LOGGER, "[" + i + "] >>>> getOriginalFilename()[" + aMultipartFile.get(i).getName() + "]:" + aMultipartFile.get(i).getOriginalFilename());
		   }
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
				
				/*
				 *	 전시관 정보 등록/조회/수정
				 */
		 		case exh_tmpl_reg :
		 			if((inputcheckret = check_intpufield(jsonMap,(new String[] {}))) != null) 
		 				break;
		 			resMap = ajaxContentsService.exh_tmpl_reg(jsonMap, aMultipartFile);
		 			break;	
		 			
		 			
				/*
				 *	 콘텐츠정보 등록/조회/수정
				 */
		 		case conts_info_reg :
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{	/* 공통부 */	"service_tp",
						/* 개별부 */	"crud_tp",
					}))) != null) break;
		 			if("c".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
		 				"conts_name","conts_tp", // 개별부
		 			}))) != null) break;
		 			if("r".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
			 			"conts_uid", // 개별부
			 		}))) != null) break;
		 			if("u".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
				 		"conts_uid", // 개별부
				 	}))) != null) break;
		 			if("d".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
				 		"conts_uid", // 개별부
				 		"del_yn",
				 	}))) != null) break;
		 			resMap = ajaxContentsService.conts_info_reg(jsonMap, aMultipartFile);
		 			break;
		 			
		 			
				/*
				 *	 전시회정보 등록/조회/수정
				 */
		 		case exh_info_reg :
					if((inputcheckret = check_intpufield(jsonMap,(new String[]
					{	/* 공통부 */	"service_tp",
						/* 개별부 */	"crud_tp",
					}))) != null) break;
		 			if("c".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
		 				"exh_main_conts","exh_tmpl_uid", // 개별부
		 			}))) != null) break;
		 			if("r".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
			 			"exh_uid", // 개별부
			 		}))) != null) break;
		 			if("u".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
				 		"exh_uid", // 개별부
				 	}))) != null) break;
		 			if("d".equals(jsonMap.get("crud_tp")) && (inputcheckret = check_intpufield(jsonMap,(new String[] {
					 	"exh_uid", // 개별부
					}))) != null) break;
		 			resMap = ajaxContentsService.exhInfoReg(jsonMap, aMultipartFile);
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
				resMap.put("retmsg", "시스템오류입니다.");
				
			} catch (Exception e1) {}
			
			System.out.println("JSONController error. : [" + e + "]");
			Log.print(LOGGER, "JSONController error...");
			Log.print(LOGGER, e);
		}
	
		resMap.put("service_tp", service_tp);
		
		String jsonString = null;
		try {
			jsonString = om.writeValueAsString(resMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonString = e.getMessage();
		}
		
		Log.print(LOGGER, "test 결과:" + jsonString + "");
		long end_time = System.currentTimeMillis(); 
		Log.print(LOGGER, "/Ajax3DBankMultipartController.do 결과전송, 처리시간(TimeMillis)=[" + (end_time-start_time) + "]");
		Log.print(LOGGER, "=====================================================================\n\r");
		
		return resMap;
	}

	
	private String check_intpufield(Map<String, Object>  jsonMap, String field[]) {

		String retmsg = null;
		
		for(int i=0;i<field.length;i++)
		{
			try
			{
				if(jsonMap.get(field[i]) == null ||String.valueOf(jsonMap.get(field[i])).trim().length() == 0)
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