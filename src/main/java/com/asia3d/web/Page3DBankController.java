/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.asia3d.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.asia3d.util.Log;


/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class Page3DBankController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Ajax3DBankController.class);
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	// 메인
	@RequestMapping(value = "index.do")
	public String indexmain(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {
		
		return "redirect:/login.do";
	}

	// 로그인
	@RequestMapping(value = "/login.do")
	public String login(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status) {	

		return "template/login";
	}
	
	
	/**
	 * 네이버 로그인 콜백
	 * @param searchVO
	 * @param bindingResult
	 * @param model
	 * @param status
	 * @return
	 */
	@RequestMapping(value = "member/callback_naver.do")
	public String callback_naver(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status) {

		return "member/callback_naver";
	}
	
	@RequestMapping(value = "member/callback_google.do")
	public String callback_google(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status) {

		return "member/callback_google";
	}
	
	
	// logout
	@RequestMapping(value = "/logout.do", method = RequestMethod.POST)
	public String logout(HttpServletRequest request) {	
		// 로그아웃처리..
		if("true".equals(request.getParameter("logout"))) {
			request.getSession().invalidate();
		}
		
		return "redirect:/login.do";
	}
	
}











