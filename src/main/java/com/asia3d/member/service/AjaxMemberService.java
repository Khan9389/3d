package com.asia3d.member.service;

import java.util.HashMap;
//import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.springframework.web.multipart.MultipartFile;

public interface AjaxMemberService {
	
	public Map<String, Object> user_login(HashMap<String, Object> jsonMap, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public Map<String, Object> sns_login(HashMap<String, Object> jsonMap, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
}
