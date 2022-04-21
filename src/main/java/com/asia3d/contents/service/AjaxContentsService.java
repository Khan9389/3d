package com.asia3d.contents.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

public interface AjaxContentsService {

	public Map<String, Object> exh_tmpl_reg(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) throws Exception;
	public Map<String, Object> exh_tmpl_list(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
	public Map<String, Object> conts_info_reg(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) throws Exception;
	public Map<String, Object> conts_info_list(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
	public Map<String, Object> exhInfoReg(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) throws Exception;
	public Map<String, Object> exhInfoList(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
	public Map<String, Object> exhibitionViewInfo(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
	public Map<String, Object> exhibitionInfo(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
	public Map<String, Object> checkTmplDelete(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
	public Map<String, Object> checkContsDelete(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
	public Map<String, Object> templateInfo(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception;
}
