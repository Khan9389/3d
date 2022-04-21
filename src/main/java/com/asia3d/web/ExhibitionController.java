package com.asia3d.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.asia3d.util.Log;





@Controller
@RequestMapping(value = "/exhibition")
public class ExhibitionController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ajax3DBankController.class);
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	
	@RequestMapping(value = "/template/index.do")
	public String index(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {
		Log.print(LOGGER, "==============================session= " + session.getAttribute("p_login_id"));
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "template/index";
		else
			page = "redirect:/login.do";
		
		return page;
	} 
	
	
	@RequestMapping(value = "/template/write.do")
	public String templateWrite(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "template/write";
		else
			page = "redirect:/login.do";
		
		return page;
	} 
	
	
	@RequestMapping(value = "/template/edit.do")
	public String templateEdit(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "template/edit";
		else
			page = "redirect:/login.do";
		
		return page;
	} 
	
	
	@RequestMapping(value = "/product/index.do")
	public String productIndex(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {	
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "product/index";
		else
			page = "redirect:/login.do";
		
		return page;
	}
	

	@RequestMapping(value = "/product/write.do")
	public String productWrite(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {	
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "product/write";
		else
			page = "redirect:/login.do";
		
		return page;
	} 
	
	
	@RequestMapping(value = "/product/edit.do")
	public String productEdit(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {	
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "product/edit";
		else
			page = "redirect:/login.do";
		
		return page;
	}
		

	@RequestMapping(value = "/exhibition/index.do")
	public String exhibitionIndex(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {	
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "exhibition/index";
		else
			page = "redirect:/login.do";
		
		return page;
	}
	
		
	@RequestMapping(value = "/exhibition/write.do")
	public String exhibitionWrite(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {	
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "exhibition/write";
		else
			page = "redirect:/login.do";
		
		return page;
	}
	
	
	@RequestMapping(value = "/exhibition/edit.do")
	public String exhibitionEdit(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {	
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "exhibition/edit";
		else
			page = "redirect:/login.do";
		
		return page;
	}
	
	
	@RequestMapping(value = "/exhibition/view.do")
	public String exhibitionView(@ModelAttribute HashMap<Object, Object> searchVO, BindingResult bindingResult, Model model, SessionStatus status, HttpSession session) {	
		String page = null;
		if (session != null && session.getAttribute("p_login_id") != null) 
			page = "exhibition/view";
		else
			page = "redirect:/login.do";
		
		return page;
	}
}
