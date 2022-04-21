package com.asia3d.member.service.impl;

import java.io.*;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.asia3d.member.service.AjaxMemberService;
import com.asia3d.util.DateUtil;
import com.asia3d.util.DownUtil;
import com.asia3d.util.FileUtil;
import com.asia3d.util.KakaoThumnail;
import com.asia3d.util.Log;
import com.asia3d.util.PropertyUtil;
import com.asia3d.util.StrUtil;

@Service("ajaxMemberService")
public class AjaxMemberServiceImpl implements AjaxMemberService {

	private String PROP_FILE = "/property/3dbank.properties";

	private static final Logger LOGGER = LoggerFactory.getLogger(AjaxMemberServiceImpl.class);

	@Autowired
	private AjaxMemberDAO ajaxMemberDAO;

	@Resource(name = "messageSource")
	MessageSource messageSource;
	

	/*
	 * 로그인
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> user_login(HashMap<String, Object> jsonMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		PropertyUtil pl = new PropertyUtil(PROP_FILE);

		request.getSession().invalidate();

		HashMap<String, Object> map = ajaxMemberDAO.selectUser_by_p_login_id(jsonMap);

		Log.print(LOGGER, "ajaxMemberDAO.selectUser_by_p_login_id. map=" + map);
		if (map == null) {
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("retcode", "991");
			jsonMap.put("retmsg", "미등록된 로그인ID입니다.");
			return jsonMap;
		}

		if("Y".equals(map.get("del_yn"))) {
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("retcode", "992");
			jsonMap.put("retmsg", "삭제된 로그인ID입니다.");
			return jsonMap;
		}

		if (map.get("p_pswd") == null
				|| ((String) map.get("p_pswd")).length() == 0) {
			if (map.get("sns_tp") != null && ((String) map.get("p_pswd") == "null" || (String) map.get("p_pswd") == null)) {
				jsonMap = new HashMap<String, Object>();
				jsonMap.put("retcode", "993");
				jsonMap.put("retmsg", "SNS를 통해 가입된 사용자입니다.");
				return jsonMap;
			}
		}

		if (!jsonMap.get("p_pswd").equals(map.get("p_pswd"))
				&& !jsonMap.get("p_pswd").equals(map.get("corp_p_pswd"))) {
			System.out.println("map.get(p_pswd) = " + map.get("p_pswd"));
			System.out.println("map.get(corp_p_pswd) = "
					+ map.get("corp_p_pswd"));
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("retcode", "992");
			jsonMap.put("retmsg", "비밀번호가 틀렸습니다.");
			return jsonMap;
		}

		if (!"Y".equals((String) map.get("reg_cert_st"))) {
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("retcode", "993");
			jsonMap.put("retmsg", "아직 메일을 통해 인증받지 않은 사용자입니다..");
			return jsonMap;
		}

		// 회원정보업데이트
		HashMap<String, Object> update_map = new HashMap<String, Object>();
		update_map.put("p_login_id", map.get("p_login_id"));
		update_map.put("lst_login_dttm", DateUtil.getDateNTimeByForm("yyyyMMddHHmmss"));
		update_map.put("login_cnt", (map.get("login_cnt") == null ? 0 : (int) map.get("login_cnt")) + 1);
		update_map.put("email", map.get("p_login_id"));
		int upt = ajaxMemberDAO.updateUser_by_p_login_id(update_map);

		Log.print(LOGGER, "ajaxMemberDAO.updateUser_by_p_login_id upt=[" + upt + "]");

		jsonMap.put("retcode", "000");
		jsonMap.put("retmsg", "정상적으로 로그인되었습니다.");

		if (map.get("corp_p_login_id") == null) {
			map.put("corp_p_login_id", map.get("p_login_id"));
			map.put("corp_p_name", map.get("p_name"));
		}

		if ("000".equals(jsonMap.get("retcode"))) {
			Log.print(LOGGER, "login OK(4) : request.getSession().getId()=[" + request.getSession().getId() + "]");
			Log.print(LOGGER, "login OK map.get('user_uid'):" + map.get("user_uid"));

			if (map.get("user_uid") != null) {
				request.getSession().setAttribute("user_uid", String.valueOf(map.get("user_uid")));

				request.getSession().setAttribute("post_code", String.valueOf(map.get("post_code")));
				request.getSession().setAttribute("road_addr", String.valueOf(map.get("road_addr")));
				request.getSession().setAttribute("jibun_addr", String.valueOf(map.get("jibun_addr")));
				request.getSession().setAttribute("detail_addr", String.valueOf(map.get("detail_addr")));
				request.getSession().setAttribute("phone_num", String.valueOf(map.get("phone_num")));

				request.getSession().setAttribute("sns_id", String.valueOf(map.get("sns_id")));
				request.getSession().setAttribute("sns_tp", String.valueOf(map.get("sns_tp")));
				request.getSession().setAttribute("age", 	String.valueOf(map.get("age")));
				request.getSession().setAttribute("gender", String.valueOf(map.get("gender")));
				request.getSession().setAttribute("r_name", String.valueOf(map.get("r_name")));

				request.getSession().setAttribute("corp_p_login_id", map.get("corp_p_login_id"));
				request.getSession().setAttribute("corp_p_name", map.get("corp_p_name"));
				request.getSession().setAttribute("p_login_id", map.get("p_login_id"));
				request.getSession().setAttribute("p_name", map.get("p_name"));
				request.getSession().setAttribute("user_tp", map.get("user_tp"));
				request.getSession().setAttribute("compy_name", map.get("compy_name"));
				request.getSession().setAttribute("my_photo", map.get("my_photo"));
				request.getSession().setAttribute("lst_hit_dttm", DateUtil.getDateNTimeByForm("yyyyMMddHHmmss"));

				Log.print(LOGGER, "map=[" + map + "]");

				UUID randomeUUID = UUID.randomUUID();
				String token_uuid = randomeUUID.toString().replaceAll("-", "");
				response.addCookie(new Cookie("token_uuid", token_uuid + "_" + map.get("user_uid")));
				request.getSession().setAttribute("token_uuid", token_uuid + "_" + map.get("user_uid"));


				// 로그인후 응답에 셋팅
				jsonMap.put("token_uuid", 	token_uuid + "_" + map.get("user_uid"));

				jsonMap.put("phone_num",map.get("phone_num"));
				jsonMap.put("p_name", 	map.get("p_name"));
				jsonMap.put("user_tp", 	map.get("user_tp"));

				jsonMap.put("user_uid", map.get("user_uid"));
				jsonMap.put("p_login_id", map.get("p_login_id"));

				if(request.getSession().getAttribute("my_photo") != null) {
					if(request.getSession().getAttribute("my_photo") != null && ((String)request.getSession().getAttribute("my_photo")).indexOf("http") >= 0) {
						jsonMap.put("my_photo", request.getSession().getAttribute("my_photo"));
					}
					else {
						jsonMap.put("my_photo", pl.get("SITE_DOMAIN") + "/downStlImg.do?file=" + request.getSession().getAttribute("my_photo"));
						request.getSession().setAttribute("my_photo", jsonMap.get("my_photo"));
					}
				}
				else {
					jsonMap.put("my_photo", null);
				}
			}
		}
		map = jsonMap;
		return map;
	}
	
	
	
	/*
	 * SNS 로그인
	 */
	@Override
	public Map<String, Object> sns_login(HashMap<String, Object> jsonMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession().invalidate();


		String sns_profile_image = null;

		// 카카오 (sns_tp:'03')
		//[20220223 elmu 수정] 카카오 로그인시 프론트에서 서버로 전송되는 파라미터가 service.3dbank.xyz api 일관성이 없던 것을 통일시켰고, 이메일 기록을 추가하였다.
		if("03".equals(jsonMap.get("sns_tp"))) {
			HashMap kakao = (HashMap) jsonMap.get("kakao");
			jsonMap.put("p_login_id", "" + kakao.get("id"));
			jsonMap.put("p_pswd", "" + kakao.get("id"));

			HashMap kakao_properties = (HashMap) kakao.get("properties");
			jsonMap.put("p_name", kakao.get("id"));
			if(kakao_properties != null) {
				if (StrUtil.isNullLen(kakao_properties.get("nickname")) > 0)
					jsonMap.put("p_name", kakao_properties.get("nickname"));
				if (StrUtil.isNullLen(kakao_properties.get("profile_image")) > 0)
					jsonMap.put("my_photo", (String)kakao_properties.get("profile_image"));
			}

			HashMap kakao_account = (HashMap) kakao.get("kakao_account");
			if(kakao_account != null) {
				jsonMap.put("email", kakao_account.get("email"));
			}
		}
		//[20220223 elmu 추가] 네이버 로그인
		else if ("01".equals(jsonMap.get("sns_tp"))) {
			//네이버는 p_login_id를 네이버 ID로 하되 접두사 'N'을 붙여준다.
			HashMap naver = (HashMap) jsonMap.get("naver");
			jsonMap.put("p_login_id", "N" + naver.get("id"));
			jsonMap.put("p_pswd", "" + naver.get("id"));
			jsonMap.put("p_name", naver.get("nickname"));
			jsonMap.put("my_photo", naver.get("profile_image"));
			jsonMap.put("email", naver.get("email"));
			Log.print(LOGGER, "===================  in 1 =============" + jsonMap);
		}
		else {
			jsonMap.put("retcode", "999");
			jsonMap.put("retmsg", "지원하지 않는 소셜 로그인입니다.");
			return jsonMap;
		}

		PropertyUtil pl = new PropertyUtil(PROP_FILE);

		HashMap<String, Object> map = ajaxMemberDAO.selectUser_by_p_login_id(jsonMap);
		Log.print(LOGGER, "ajaxMemberDAO.selectUser_by_p_login_id map=" + map);

		if (map == null) {
			
			jsonMap.put("reg_cert_tp", "1");
			jsonMap.put("reg_cert_st", "Y");
			jsonMap.put("user_tp", "1");

			int min_level = 2;
			int newUid = ajaxMemberDAO.user_reg(jsonMap);
			Log.print(LOGGER, "===================  in 2 =============" + newUid);
			HashMap<String, Object> sns_map = new HashMap<String, Object>();
			sns_map.put("mb_id", jsonMap.get("p_login_id"));
			sns_map.put("mb_password", "_" + jsonMap.get("p_login_id"));
			sns_map.put("mb_nick", jsonMap.get("p_name"));
			sns_map.put("mb_email", jsonMap.get("p_login_id"));
			sns_map.put("mb_level", min_level);
			sns_map.put("mb_name", "");


			ajaxMemberDAO.cuser_reg(sns_map);

			map = ajaxMemberDAO.selectUser_by_p_login_id(jsonMap);
			
			Log.print(LOGGER, "===================  in 3 =============" + map);

		}
		HashMap<String, Object> update_map = new HashMap<String, Object>();
		update_map.putAll(jsonMap);

		// 회원정보업데이트
		update_map.put("p_login_id", map.get("p_login_id"));
		update_map.put("lst_login_dttm", DateUtil.getDateNTimeByForm("yyyyMMddHHmmss"));
		update_map.put("login_cnt", (map.get("login_cnt") == null ? 0 : (int) map.get("login_cnt")) + 1);

		int upt = ajaxMemberDAO.updateUser_by_p_login_id(update_map);
		Log.print(LOGGER, "ajax3DWorldMemberDAO.updateUser_by_p_login_id upt=[" + upt + "]");

		jsonMap.put("retcode", "000");
		jsonMap.put("retmsg", "정상적으로 로그인되었습니다.");

		if ("000".equals(jsonMap.get("retcode"))) {
			Log.print(LOGGER, "login OK(3) : request.getSession().getId()=[" + request.getSession().getId() + "]");
			
			if (map.get("user_uid") != null) {
				request.getSession().setAttribute("user_uid", String.valueOf(map.get("user_uid")));

				request.getSession().setAttribute("post_code", String.valueOf(map.get("post_code")));
				request.getSession().setAttribute("road_addr", String.valueOf(map.get("road_addr")));
				request.getSession().setAttribute("jibun_addr", String.valueOf(map.get("jibun_addr")));
				request.getSession().setAttribute("detail_addr", String.valueOf(map.get("detail_addr")));
				request.getSession().setAttribute("phone_num", String.valueOf(map.get("phone_num")));

				request.getSession().setAttribute("sns_id", String.valueOf(map.get("sns_id")));
				request.getSession().setAttribute("sns_tp", String.valueOf(map.get("sns_tp")));
				request.getSession().setAttribute("age", String.valueOf(map.get("age")));
				request.getSession().setAttribute("gender", String.valueOf(map.get("gender")));
				request.getSession().setAttribute("r_name", String.valueOf(map.get("r_name")));

				request.getSession().setAttribute("corp_p_login_id", map.get("corp_p_login_id"));
				request.getSession().setAttribute("corp_p_name", map.get("corp_p_name"));
				request.getSession().setAttribute("p_login_id", map.get("p_login_id"));
				request.getSession().setAttribute("p_name", map.get("p_name"));
				request.getSession().setAttribute("user_tp", map.get("user_tp"));
				request.getSession().setAttribute("compy_name",map.get("compy_name"));
				request.getSession().setAttribute("my_photo",map.get("my_photo"));
				request.getSession().setAttribute("lst_hit_dttm", DateUtil.getDateNTimeByForm("yyyyMMddHHmmss"));


				UUID randomeUUID = UUID.randomUUID();
				String token_uuid = randomeUUID.toString().replaceAll("-", "");
				response.addCookie(new Cookie("token_uuid", token_uuid + "_" + map.get("user_uid")));
				request.getSession().setAttribute("token_uuid", token_uuid + "_" + map.get("user_uid"));


				// 로그인후 응답에 셋팅
				jsonMap.put("token_uuid", 	token_uuid + "_" + map.get("user_uid"));


				jsonMap.put("phone_num",map.get("phone_num"));
				jsonMap.put("p_name", 	map.get("p_name"));
				jsonMap.put("user_tp", 	map.get("user_tp"));

				jsonMap.put("user_uid", map.get("user_uid"));
				jsonMap.put("p_login_id", map.get("p_login_id"));


				if(request.getSession().getAttribute("my_photo") != null) {
					if(map.get("my_photo") != null && ((String)map.get("my_photo")).indexOf("http") >= 0) {
						jsonMap.put("my_photo", map.get("my_photo"));
					}
					else {
						jsonMap.put("my_photo", pl.get("SITE_DOMAIN") + "/downStlImg.do?file=" + map.get("my_photo"));
						request.getSession().setAttribute("my_photo", jsonMap.get("my_photo"));
					}
				}
				else {
					jsonMap.put("my_photo", null);
				}

			}
		}
		
		Log.print(LOGGER, "===================  in 5 jsonMap =============" + jsonMap);

		return jsonMap;
	}
}
