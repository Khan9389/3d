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
package com.asia3d.contents.service.impl;

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
 * @ 2021.12.20           최초생성
 *
 * @author 3dBank 개발팀
 * @since 2021.12.20
 * @version 1.0
 * @see
 *
 *  
 */


@Repository("contentsDAO")
public class AjaxContentsDAO extends EgovAbstractDAO {

	private static final Logger LOGGER = LoggerFactory.getLogger(AjaxContentsDAO.class);
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////// TEMPLATE OPERATION //////////////////////////////////////////////////////////////////////
	
	/**
	 * 전시관 정보 등록
	 */
	public int insert_exh_tmpl_info(HashMap<String, Object> jsonMap) {
		int tmpl_uid = (int) insert("contentsDAO.insert_exh_tmpl_info", jsonMap);
		Log.print(LOGGER, ">>>>>>> insert_tmpl_info : tmpl_uid = " + tmpl_uid);
		return tmpl_uid;
	}
	
	
	/**
	 * 전시상품 정보 등록
	 */
	public void insert_exh_tmpl_prod(HashMap<String, Object> jsonMap) {
		insert("contentsDAO.insert_exh_tmpl_prod", jsonMap);
	}
	
	
	/**
	 * 전시파일 정보 등록
	 */
	public void insert_exh_tmpl_file(HashMap<String, Object> jsonMap) {
		insert("contentsDAO.insert_exh_tmpl_file", jsonMap);
	}
	
	
	public int select_exh_tmpl_list_total_cnt(HashMap<String, Object> jsonMap) {
		return (int) select("contentsDAO.select_exh_tmpl_list_total_cnt", jsonMap);
	}
	
	public List<?> select_exh_tmpl_list(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.select_exh_tmpl_list", jsonMap);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> select_exh_tmpl_info(HashMap<String, Object> jsonMap) {
		return (HashMap<String, Object>) select("contentsDAO.select_exh_tmpl_info", jsonMap);
	}
	
	public List<?> select_tmpl_prod_list(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.select_tmpl_prod_list", jsonMap); 
	}
	
	public List<?> select_tmpl_file_list(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.select_tmpl_file_list", jsonMap); 
	}
	
	public int update_tmpl_info(HashMap<String, Object> jsonMap) {
		return update("contentsDAO.update_tmpl_info", jsonMap);
	}
	
	public int delete_tmpl_file(HashMap<String, Object> jsonMap) {
		return delete("contentsDAO.delete_tmpl_file", jsonMap);
	}
	
	public int update_file_info(HashMap<String, Object> jsonMap) {
		return update("contentsDAO.update_file_info", jsonMap);
	} 
	
	public int update_exh_tmpl_prod(HashMap<String, Object> jsonMap) {  
		return update("contentsDAO.update_exh_tmpl_prod", jsonMap);
	} 
	
	public int delete_exh_tmpl_prod(HashMap<String, Object> jsonMap) {
		return delete("contentsDAO.delete_exh_tmpl_prod", jsonMap);
	}
	
	
	public int deleteTmpl(HashMap<String, Object> jsonMap) {
		return update("contentsDAO.deleteTmpl", jsonMap);
	}
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////// CONTENTS OPERATION ////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 콘텐츠 정보 등록
	 */
	public int insert_conts_info(HashMap<String, Object> jsonMap) {
		int conts_uid = (int) insert("contentsDAO.insert_conts_info", jsonMap);
		Log.print(LOGGER, ">>>>>>> insert_conts_info : conts_uid = " + conts_uid);
		return conts_uid;
	}
	
	
	/**
	 * 콘텐츠파일 정보 등록
	 */
	public int insert_conts_file(HashMap<String, Object> jsonMap) {
		return (int)insert("contentsDAO.insert_conts_file", jsonMap);
	}
	
	@SuppressWarnings("unchecked")
	public long selectContsList_TotalCnt(HashMap<String, Object> jsonMap) {
		HashMap<String, Object> map = (HashMap<String, Object>) select("contentsDAO.selectContsList_TotalCnt", jsonMap);
		Log.print(LOGGER, "selectContsList_TotalCnt map= " + map);
		return map == null ? 0 : (long) map.get("tot_count");
	}
	
	public int update_conts_thumb_info(HashMap<String, Object> jsonMap) {  
		return update("contentsDAO.update_conts_thumb_info", jsonMap);
	} 
	
	public List<?> selectContsList(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.selectContsList", jsonMap);
	}
	
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectContentsInfo(HashMap<String, Object> jsonMap) {
		// TODO Auto-generated method stub
		return (HashMap<String, Object>) select("contentsDAO.selectContentsInfo", jsonMap);
	}
	
	
	public List<?> selectContentsFileList(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.selectContentsFileList", jsonMap);
	}
	
	public int delete_conts_file(HashMap<String, Object> jsonMap) {
		return delete("contentsDAO.delete_conts_file", jsonMap);
	}
	
	public int updateContsInfo(HashMap<String, Object> jsonMap) {  
		return update("contentsDAO.updateContsInfo", jsonMap);
	} 
	
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectContsVideoAndGlb(HashMap<String, Object> jsonMap) {
		// TODO Auto-generated method stub
		return (HashMap<String, Object>) select("contentsDAO.selectContsVideoAndGlb", jsonMap);
	}
	
	
	public List<?> selectContsImgs(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.selectContsImgs", jsonMap);
	}
	
	
	public int countContents(HashMap<String, Object> jsonMap) {
		return (int) select("contentsDAO.countContents", jsonMap);
	}
	
	
	public int deleteContentsInfo(HashMap<String, Object> jsonMap) {
		return update("contentsDAO.deleteContentsInfo", jsonMap);
	}
	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////// EXHIBITION OPERATION ///////////////////////////////////////////////////////////////////////
	
	/**
	 * 전시회 정보 등록
	 */
	public int insertExhInfo(HashMap<String, Object> jsonMap) {
		int exh_uid = (int) insert("contentsDAO.insert_exh_info", jsonMap);
		return exh_uid;
	}
	
	
	/**
	 * 전시회파일 정보 등록
	 */
	public int insertExhFile(HashMap<String, Object> jsonMap) {
		return (int)insert("contentsDAO.insert_exh_file", jsonMap);
	}
	
	
	public int updateExhThumbInfo(HashMap<String, Object> jsonMap) {  
		return update("contentsDAO.update_exh_thumb_info", jsonMap);
	} 
	
	public int insertExhMainConts(HashMap<String, Object> jsonMap) {
		return (int)insert("contentsDAO.insert_exh_main_conts", jsonMap);
	}
	
	@SuppressWarnings("unchecked")
	public long selectExhListTotalCnt(HashMap<String, Object> jsonMap) {
		HashMap<String, Object> map = (HashMap<String, Object>) select("contentsDAO.select_exh_list_total_cnt", jsonMap);
		Log.print(LOGGER, "select_exh_list_total_cnt map= " + map);
		return map == null ? 0 : (long) map.get("tot_count");
	}
	
	public List<?> selectExhList(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.select_exhibition_list", jsonMap);
	}
	
	
	/**
	 * 전시회 정보 
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectExhibitionInfo(HashMap<String, Object> jsonMap) {
		// TODO Auto-generated method stub
		return (HashMap<String, Object>) select("contentsDAO.selectExhibitionInfo", jsonMap);
	}
	
	
	public List<?> selectExhibitionFileList(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.selectExhibitionFileList", jsonMap);
	}
	
	
	public List<?> selectExhibitionContsList(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.selectExhibitionContsList", jsonMap);
	}
	
	
	public int deleteExhibitionFile(HashMap<String, Object> jsonMap) {
		return delete("contentsDAO.deleteExhibitionFile", jsonMap);
	}
	
	
	public int deleteExhMainConts(HashMap<String, Object> jsonMap) {
		return delete("contentsDAO.deleteExhMainConts", jsonMap);
	}
	
	public int updateExhMainConts(HashMap<String, Object> jsonMap) {  
		return update("contentsDAO.updateExhMainConts", jsonMap);
	} 
	
	
	public int updateExhibitionInfo(HashMap<String, Object> jsonMap) {  
		return update("contentsDAO.updateExhibitionInfo", jsonMap);
	}
	
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectExhibitionViewInfo(HashMap<String, Object> jsonMap) {
		// TODO Auto-generated method stub
		return (HashMap<String, Object>) select("contentsDAO.selectExhibitionViewInfo", jsonMap);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectMainExhibitionInfo(HashMap<String, Object> jsonMap) {
		// TODO Auto-generated method stub
		return (HashMap<String, Object>) select("contentsDAO.selectMainExhibitionInfo", jsonMap);
	}
	
	
	public List<?> selectExhibitionListByTmplUid(HashMap<String, Object> jsonMap) {
		return list("contentsDAO.selectExhibitionListByTmplUid", jsonMap);
	}
	
	
	public int deleteExhibitionInfo(HashMap<String, Object> jsonMap) {
		return update("contentsDAO.deleteExhibitionInfo", jsonMap);
	}
	
		
}











