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
package com.asia3d.member.service.impl;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.asia3d.util.Log;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : SampleDAO.java
 * @Description : Sample DAO Class
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

@Repository("3dworld_memberDAO")
public class AjaxMemberDAO extends EgovAbstractDAO {

	private static final Logger LOGGER = LoggerFactory.getLogger(AjaxMemberDAO.class);
	
	/**
	 * 회원을 login_id를 통해 조회한다.
	 * @param vo - 조회할 정보가 담긴 HashMap
	 * @return 조회 결과
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectUser_by_p_login_id(HashMap<String, Object> vo) throws Exception {
		return (HashMap<String, Object>) select("3dworld_memberDAO.selectUser_by_p_login_id", vo);
	}
	
	
	/**
	 * 회원을 login_id를 통해 정보를 업데이트한다.
	 * @param vo - 업데이트할 정보가 담긴 HashMap
	 * @return  결과
	 * @exception Exception
	 */
	public int updateUser_by_p_login_id(HashMap<String, Object> update_map) {
		return update("3dworld_memberDAO.updateUser_by_p_login_id", update_map);
	}
	
	
	/**
	 * 회원을 등록한다.
	 * @param vo - 등록할 정보가 담긴 HashMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public int user_reg(HashMap<String, Object> vo) throws Exception {
		int new_user_uid = (int) insert("3dworld_memberDAO.user_reg", vo);
		Log.print(LOGGER, "user_reg new_user_uid=" + new_user_uid);
		return new_user_uid;
	}
	
	
	public void cuser_reg(HashMap<String, Object> map) {
		insert("3dworld_memberDAO.cuser_reg", map);
	}
	
	
}










