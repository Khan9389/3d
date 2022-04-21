package com.asia3d.contents.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.asia3d.contents.service.AjaxContentsService;
import com.asia3d.util.FileUtil;
import com.asia3d.util.Log;
import com.asia3d.util.PropertyUtil;
import com.asia3d.web.DefineService;


@Service("ajaxContentsService")
public class AjaxContentsServiceImpl implements AjaxContentsService {
	
	private String PROP_FILE = "/property/3dbank.properties";
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AjaxContentsServiceImpl.class);
	
	/*@Autowired
	private AjaxMemberDAO ajaxMemberDAO;*/
	
	@Autowired
	private AjaxContentsDAO ajaxContentsDAO;
		
	@Resource(name = "messageSource")
	MessageSource messageSource;
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////// TEMPLATE OPERATION //////////////////////////////////////////////////////////////////////
	
	/**
	 * 3D전시 등록/수정/조회/삭제
	 */
	@Override
	public Map<String, Object> exh_tmpl_reg(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) throws Exception {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
				
		if ("c".equals(jsonMap.get("crud_tp"))) {
			
			int exh_tmpl_uid = ajaxContentsDAO.insert_exh_tmpl_info(jsonMap);
			
			PropertyUtil pl = new PropertyUtil(PROP_FILE);
			String exh_tmpl_data_path = pl.get("IMG_UPLOAD_EXHIBITION_PATH") + "tmpl_uid_" + exh_tmpl_uid + File.separator;

			ArrayList prod_list = (ArrayList)jsonMap.get("tmplProdList");
			for(int i=0; i < prod_list.size(); i++) { 
				HashMap<String, Object> exh_tmpl_prod = (HashMap<String, Object>) prod_list.get(i);
				exh_tmpl_prod.put("exh_tmpl_uid", exh_tmpl_uid);
				ajaxContentsDAO.insert_exh_tmpl_prod(exh_tmpl_prod);
			}
			
			ArrayList exh_tmpl_file = (ArrayList) jsonMap.get("exh_tmpl_file");			
			int fileIndex = 0;
			for(int i=0; i<exh_tmpl_file.size(); i++) {
				HashMap<String, Object>  exhMap = (HashMap<String, Object>) exh_tmpl_file.get(i);
				exhMap.put("exh_tmpl_uid", exh_tmpl_uid);
				if(exhMap.get("file_name") != null && ((String)exhMap.get("file_name")).length() > 0) {
					// 업로드된 파일명과 동일한지 체크

					if("file[]".equals(aMultipartFile.get(fileIndex).getName())) {
						FileUtil.makeDir(exh_tmpl_data_path);
						String save_name = FileUtil.uploadFile(exh_tmpl_data_path, aMultipartFile.get(fileIndex));
						exhMap.put("save_name", save_name);	
						
						String fileName = (String)exhMap.get("file_name");
				        String extName = fileName.substring(fileName.lastIndexOf('.') + 1);
				        if(isStringUpperCase(extName)){
				        	extName = extName.toLowerCase();
				        	fileName = fileName.substring(0, fileName.lastIndexOf('.')+1) + extName;
				        	exhMap.put("file_name", fileName);
				        }
						fileIndex ++;
					}
				}
				ajaxContentsDAO.insert_exh_tmpl_file(exhMap);
			}
			
			returnMap.put("retcode", 	"000");
			returnMap.put("retmsg",	"정상적으로 등록되었습니다.");
					
		} else if ("r".equals(jsonMap.get("crud_tp"))) {
			Log.print(LOGGER, "crud type read jsonMap >>>>>>>>>>>>>    " + jsonMap);
			returnMap = ajaxContentsDAO.select_exh_tmpl_info(jsonMap);

			if (returnMap == null || returnMap.size() <= 0) {
				returnMap = new HashMap<String, Object>();
				returnMap.put("retcode", 	"991");
				returnMap.put("retmsg",	"존재하지 않는 데이타입니다.");			
				return returnMap;
			}			
			Log.print(LOGGER, "crud type read returnMap >>>>>>>>>>>>>    " + returnMap);
			
			List<?> listTmplProd = ajaxContentsDAO.select_tmpl_prod_list(jsonMap);
			returnMap.put("list_tmpl_prod", listTmplProd);

			
			List<?> listTmplFile = ajaxContentsDAO.select_tmpl_file_list(jsonMap);
			
			if(listTmplFile == null) { listTmplFile = new ArrayList();  } 
			for(int i=0; i < listTmplFile.size(); i++) {
				HashMap<String, Object>  file = (HashMap<String, Object>) listTmplFile.get(i);
				String uptDttm = file.get("upt_date").toString();
				uptDttm = uptDttm.replaceAll("\\s+","");
				uptDttm = uptDttm.replaceAll("-","");
				uptDttm = uptDttm.replaceAll(":","");
				uptDttm = uptDttm.replaceAll("\\.","");
				file.put("upt_date", uptDttm);
			}
			
			returnMap.put("list_tmpl_file", listTmplFile);

			
			returnMap.put("retcode", 	"000");
			returnMap.put("retmsg",	"정상적으로 조회되었습니다.");
			
		} else if ("u".equals(jsonMap.get("crud_tp"))) {
			ajaxContentsDAO.update_tmpl_info(jsonMap);
			PropertyUtil pl = new PropertyUtil(PROP_FILE);
			String exh_tmpl_data_path = pl.get("IMG_UPLOAD_EXHIBITION_PATH") + "tmpl_uid_" + jsonMap.get("exh_tmpl_uid") + File.separator;
			
			ArrayList del_file = (ArrayList) jsonMap.get("arrayDelName");
			ArrayList ins_file = (ArrayList) jsonMap.get("arrayInsName");
			ArrayList upt_file = (ArrayList) jsonMap.get("arrayUpdateFl");
			
			if(del_file == null) { del_file = new ArrayList();  }
			if(ins_file == null) { ins_file = new ArrayList();  }
			if(upt_file == null) { upt_file = new ArrayList();  }
		
			Log.print(LOGGER, "del_file=[" +del_file +"]");
			Log.print(LOGGER, "ins_file=[" +ins_file +"]");
			Log.print(LOGGER, "upt_file=[" +upt_file +"]");
			
			for(int i=0; i<del_file.size(); i++) {
				jsonMap.put("save_name", del_file.get(i));
				
				// db에서 삭제
				int ret = ajaxContentsDAO.delete_tmpl_file(jsonMap);
				// 실제 물리파일 삭제
				FileUtil.deleteFile(exh_tmpl_data_path, (String) del_file.get(i)); 
			}
			
			
			for (int i = 0; i < upt_file.size(); i++) {
				HashMap<String, Object>  fileMap = (HashMap<String, Object>) upt_file.get(i);
				ajaxContentsDAO.update_file_info(fileMap);
			}
			
			ArrayList tmpl_file = (ArrayList) jsonMap.get("tmpl_file");
			if(tmpl_file == null) 
				tmpl_file = new ArrayList();

			for(int j=0; j<tmpl_file.size(); j++) {
				HashMap<String, Object>  tmplMap = (HashMap<String, Object>) tmpl_file.get(j);
				
				if(tmplMap.get("file_name") != null && ((String)tmplMap.get("file_name")).length() > 0) {
					for(int i=0;i<ins_file.size();i++) {
						for(int k=0; k < aMultipartFile.size();k++) {
							// 업로드된 파일명과 동일한지 체크한다.
							if(tmplMap.get("file_name").equals(ins_file.get(i)) && tmplMap.get("file_name").equals(aMultipartFile.get(k).getOriginalFilename())) {
								Log.print(LOGGER, "업로드할 파일명=[" +ins_file.get(i) +"]");
								String save_name = FileUtil.uploadFile(exh_tmpl_data_path, aMultipartFile.get(k));
								String fileName = (String)ins_file.get(i);
								String extName = fileName.substring(fileName.lastIndexOf('.') + 1);
						        if(isStringUpperCase(extName)){
						        	extName = extName.toLowerCase();
						        	fileName = fileName.substring(0, fileName.lastIndexOf('.')+1) + extName;
						        }
								jsonMap.put("file_tp", tmplMap.get("file_tp"));
								jsonMap.put("file_size", tmplMap.get("file_size"));
								jsonMap.put("save_name", save_name);
								jsonMap.put("file_name", fileName);

								ajaxContentsDAO.insert_exh_tmpl_file(jsonMap);
							}
						}
					}
				}
			}
			
			ArrayList del_prod_list = (ArrayList) jsonMap.get("del_prod_list");
			if(del_prod_list == null) 
				del_prod_list = new ArrayList();
			
			for (int i = 0; i < del_prod_list.size(); i++) {
				HashMap<String, Object> del_prod = new HashMap<String, Object>();
				del_prod.put("exh_tmpl_prod_uid", del_prod_list.get(i));
				ajaxContentsDAO.delete_exh_tmpl_prod(del_prod);
			}
			
			ArrayList upt_prod_list = (ArrayList) jsonMap.get("upt_prod_list");
			if(upt_prod_list == null) 
				upt_prod_list = new ArrayList();
			
			for (int i = 0; i < upt_prod_list.size(); i++) {
				HashMap<String, Object>  prodMap = (HashMap<String, Object>) upt_prod_list.get(i);
				if (prodMap.get("prod_uid").equals("newProd")) {
					prodMap.put("exh_tmpl_uid", jsonMap.get("exh_tmpl_uid"));
					ajaxContentsDAO.insert_exh_tmpl_prod(prodMap);
				} else {
					ajaxContentsDAO.update_exh_tmpl_prod(prodMap);
				}
			}

			returnMap.put("retcode", "000");
			returnMap.put("retmsg", "정상적으로 업데이트 되었습니다.");
			
		} else if("d".equals(jsonMap.get("crud_tp"))) {
			int delTmpl = ajaxContentsDAO.deleteTmpl(jsonMap);
			if (delTmpl == 0) {
				returnMap.put("retcode", "999");
				returnMap.put("retmsg", "조건에 맞는 데이타가 없습니다.");
				return returnMap;
			}
			returnMap.put("retcode", "000");
			returnMap.put("retmsg", "정상적으로 삭제 되었습니다.");
		}
		
		return returnMap;
	}
	
	
	@Override
	public Map<String, Object> exh_tmpl_list(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		int totalCnt = ajaxContentsDAO.select_exh_tmpl_list_total_cnt(jsonMap);

		if (totalCnt <= 0) {
			jsonMap.put("retcode", 	"991");
			jsonMap.put("retmsg",	"데이타가 존재하지 않습니다.");	
			return jsonMap;
		}

		returnMap.put("total_cnt", totalCnt);
		
		int max_ret_count = jsonMap.get("max_ret_count") != null ? Integer.parseInt((String) jsonMap.get("max_ret_count")) : 18;
		int pageNum = Integer.parseInt((String) jsonMap.get("page_num"));
		int start_index = (pageNum - 1) * max_ret_count;
		
		jsonMap.put("start_index", start_index);
		jsonMap.put("max_ret_count", max_ret_count);
		
		List<?> exh_tmpl_list = ajaxContentsDAO.select_exh_tmpl_list(jsonMap);
		returnMap.put("exh_tmpl_list", exh_tmpl_list);
		returnMap.put("retcode", 	"000");
		returnMap.put("retmsg",	"정상적으로 조회되었습니다.");
		
		return returnMap;
	}
	
	
	@Override
	public Map<String, Object> checkTmplDelete(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		List<?> exhList = ajaxContentsDAO.selectExhibitionListByTmplUid(jsonMap);
		if (exhList.size() == 0) {
			retMap.put("retcode", "000");
			retMap.put("retmsg", "true");
			return retMap;
		}

		retMap.put("retcode", "000");
		retMap.put("retmsg", "false");
		return retMap;
	}
	
	@Override
	public Map<String, Object> templateInfo(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		
		HashMap<String, Object> tmplMap = new HashMap<String, Object>(); 
		HashMap<String, Object> retMap = new HashMap<String, Object>();
	
		tmplMap = ajaxContentsDAO.select_exh_tmpl_info(jsonMap);
		if (tmplMap == null || tmplMap.size() <= 0) {
			retMap.put("retcode", 	"991");
			retMap.put("retmsg",	"존재하지 않는 데이타입니다.");			
			return retMap;
		}			
		
		List<?> listTmplFile = ajaxContentsDAO.select_tmpl_file_list(jsonMap);
		
		for (int i = 0; i < listTmplFile.size(); i++) {
			HashMap<String, Object>  file = (HashMap<String, Object>) listTmplFile.get(i);
			if((Integer)file.get("file_tp") == 1) {
				retMap.put("url_file", "exhibition/downThumbImg.do?tmpl_uid="+file.get("exh_tmpl_uid")+"&dir=tmpl&file="+file.get("save_name"));
				retMap.put("url_base", pl.get("API_HOST"));
				break;
			}
		}

		
		retMap.put("retcode", 	"000");
		retMap.put("retmsg", "정상적으로 조회되었습니다.");
		
		return retMap;
	}
	
	

	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////// CONTENTS OPERATION ////////////////////////////////////////////////////////////////////////////////
	
	
	/*
	 * 콘텐츠정보 등록/조회/수정/삭제
	 */
	@Override
	public Map<String, Object> conts_info_reg(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile)throws Exception { 
		
		HashMap<String, Object> jsonRetMap = new HashMap();
		
		if("c".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = conts_info_reg_c(jsonMap, aMultipartFile);
		}		
		if ("r".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = conts_info_reg_r(jsonMap);
			return jsonRetMap;
		}			
		if ("u".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = conts_info_reg_u(jsonMap, aMultipartFile);
			return jsonRetMap;
		}
		if ("d".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = conts_info_reg_d(jsonMap);
			return jsonRetMap;
		}
		
		
		return jsonRetMap;
	}
	
	
	/*
	 * 3D콘텐츠정보 등록
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> conts_info_reg_c(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) {	
		// making return map
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		// inserting contents info and get conts uid
		int conts_uid = ajaxContentsDAO.insert_conts_info(jsonMap);
		
		// making upload file path
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		String file_upload_path = pl.get("IMG_UPLOAD_CONTENTS_PATH") + "conts_uid_" + conts_uid + File.separator;
		
		// print out about file name
		for (int j = 0; j < aMultipartFile.size(); j++) {
			Log.print(LOGGER, "업로드할 파일[" + j + "]=[" + aMultipartFile.get(j).getOriginalFilename() + "]");
		}
		
		
		// inserting file info into DB and upload files into folder
		ArrayList conts_file_list = (ArrayList) jsonMap.get("arr_conts_file");
		int fileIndex = 0;
		int thumbFileSeq = -1;
		for(int i=0; i < conts_file_list.size(); i++) {
			HashMap<String, Object>  contsMap = (HashMap<String, Object>) conts_file_list.get(i);
			contsMap.put("conts_uid", conts_uid);
			
			if(contsMap.get("file_name") != null && ((String)contsMap.get("file_name")).length() > 0) {
				
				// 업로드된 파일명과 동일한지 체크
				if("file[]".equals(aMultipartFile.get(fileIndex).getName())) {
					FileUtil.makeDir(file_upload_path);
					String save_name;
					try {
						save_name = FileUtil.uploadFile(file_upload_path, aMultipartFile.get(fileIndex));
						contsMap.put("save_name", save_name);
						String fileName = (String)contsMap.get("file_name");
				        String extName = fileName.substring(fileName.lastIndexOf('.') + 1);
				        if(isStringUpperCase(extName)){
				        	extName = extName.toLowerCase();
				        	fileName = fileName.substring(0, fileName.lastIndexOf('.')+1) + extName;
				        	contsMap.put("file_name", fileName);
				        }
					} catch (Exception e) {
						jsonMap.put("retcode", 	"991");
						jsonMap.put("retmsg",	"파일를 UPLOAD 할 수 없습니다.");	
						return jsonMap;
					}
					
					fileIndex ++;
				}
			}
			
			int fileSeq = ajaxContentsDAO.insert_conts_file(contsMap);
			
			if((Boolean)contsMap.get("isThumb")) { thumbFileSeq = fileSeq; }
			
		}
		
		// update contents thumbnail info
		HashMap<String, Object>  thumbMap = new HashMap<String, Object>();
		thumbMap.put("thumb_file_seq", thumbFileSeq);
		thumbMap.put("conts_uid", conts_uid);
		ajaxContentsDAO.update_conts_thumb_info(thumbMap);
		
		returnMap.put("retcode", "000");
		returnMap.put("retmsg",	"정상적으로 등록되었습니다.");
		
		return returnMap;
	}
	
	
	
	/*
	 * 콘텐츠정보 조회
	 */
	public HashMap<String, Object> conts_info_reg_r(HashMap<String, Object> jsonMap) throws Exception {

		HashMap<String, Object> select_map = ajaxContentsDAO.selectContentsInfo(jsonMap);

		if (select_map == null) {
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("retcode", "991");
			jsonMap.put("retmsg", "존재하지 않는 데이타입니다.");
			return jsonMap;
		}
		
		Log.print(LOGGER, "select_map" + select_map);

		List<HashMap> contsfile_list = (List<HashMap>) ajaxContentsDAO.selectContentsFileList(jsonMap);
		select_map.put("conts_file", contsfile_list);
		
		Log.print(LOGGER, "contsfile_list" + contsfile_list);

		select_map.put("retcode", "000");
		select_map.put("retmsg", "정상적으로 조회되었습니다.");

		return select_map;
	}
	
	
	
	/*
	 * [20220110 ELMU] 콘텐츠정보 업데이트
	 */
	public HashMap<String, Object> conts_info_reg_u(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) throws Exception {

		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		String conts_file_path = pl.get("IMG_UPLOAD_CONTENTS_PATH") + "conts_uid_" + jsonMap.get("conts_uid") + File.separator;
		Log.print(LOGGER, "conts_file_path ==>  " + conts_file_path);
		HashMap<String, Object> jsonRetMap = new HashMap();

		HashMap<String, Object> conts_info = ajaxContentsDAO.selectContentsInfo(jsonMap);
		if (conts_info == null) {
			jsonRetMap.put("retcode", "991");
			jsonRetMap.put("retmsg", "존재하지 않는 Contents입니다.");
			return jsonRetMap;
		}

		
		ArrayList del_file = (ArrayList) jsonMap.get("arrayDelName");
		ArrayList ins_file = (ArrayList) jsonMap.get("arrayInsName");
		
		if(del_file == null) { del_file = new ArrayList();  }
		if(ins_file == null) { ins_file = new ArrayList();  }
		
		Log.print(LOGGER, "del_file=[" +del_file +"]");
		Log.print(LOGGER, "ins_file=[" +ins_file +"]");
		
		for(int i=0; i < del_file.size(); i++) {
			jsonMap.put("conts_save_name", del_file.get(i));
			
			// db에서 삭제
			int ret = ajaxContentsDAO.delete_conts_file(jsonMap);
			// 실제 물리파일 삭제
			FileUtil.deleteFile(conts_file_path, (String) del_file.get(i)); 
		}
		
		
		ArrayList conts_file = (ArrayList) jsonMap.get("arr_conts_file");
		if(conts_file == null) 
			conts_file = new ArrayList();
		
		int thumbFileSeq = -1;
		for(int j = 0; j < conts_file.size(); j++) {			
			HashMap<String, Object>  fileMap = (HashMap<String, Object>) conts_file.get(j);			
			if(fileMap.get("file_name") != null && ((String)fileMap.get("file_name")).length() > 0) {
				for(int i=0;i < ins_file.size();i++) {
					for(int k=0; k < aMultipartFile.size();k++) {
						// 업로드된 파일명과 동일한지 체크한다.
						if(fileMap.get("file_name").equals(ins_file.get(i)) && fileMap.get("file_name").equals(aMultipartFile.get(k).getOriginalFilename())) {
							Log.print(LOGGER, "업로드할 파일명=[" +ins_file.get(i) +"]");
							String save_name = FileUtil.uploadFile(conts_file_path, aMultipartFile.get(k));
							String fileName = (String)ins_file.get(i);
					        String extName = fileName.substring(fileName.lastIndexOf('.') + 1);
					        if(isStringUpperCase(extName)){
					        	extName = extName.toLowerCase();
					        	fileName = fileName.substring(0, fileName.lastIndexOf('.')+1) + extName;
					        }
							jsonMap.put("file_size", fileMap.get("file_size"));
							jsonMap.put("save_name", save_name);
							jsonMap.put("file_name", fileName);

							int fileSeq = ajaxContentsDAO.insert_conts_file(jsonMap);
							if((Boolean)fileMap.get("isThumb")) { thumbFileSeq = fileSeq; }
						}
					}
				}
			}
		}
		
		if(jsonMap.get("thumbnail_file_seq").equals("0")) {
			jsonMap.put("thumbnail_file_seq", thumbFileSeq);
		}
		ajaxContentsDAO.updateContsInfo(jsonMap);

		jsonRetMap.put("retcode", "000");
		jsonRetMap.put("retmsg", "정상적으로 업데이트 되었습니다.");
		return jsonRetMap;
	}
	
	
	
	/*
	 * [20220207 ELMU] 콘텐츠정보 업데이트
	 */
	public HashMap<String, Object> conts_info_reg_d(HashMap<String, Object> jsonMap) throws Exception {

		HashMap<String, Object> jsonRetMap = new HashMap();

		int delConts = ajaxContentsDAO.deleteContentsInfo(jsonMap);
		if (delConts == 0) {
			jsonRetMap.put("retcode", "999");
			jsonRetMap.put("retmsg", "조건에 맞는 데이타가 없습니다.");
			return jsonRetMap;
		}


		jsonRetMap.put("retcode", "000");
		jsonRetMap.put("retmsg", "정상적으로 삭제 되었습니다.");
		return jsonRetMap;
	}
	
	
	
	@Override
	public Map<String, Object> conts_info_list(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		
		int max_ret_count = jsonMap.get("max_ret_count") != null ? Integer.parseInt((String) jsonMap.get("max_ret_count")) : 12;
		int pageNum = Integer.parseInt((String) jsonMap.get("page_num"));
		int start_index = (pageNum - 1) * max_ret_count;
		
		jsonMap.put("start_index", start_index);
		jsonMap.put("max_ret_count", max_ret_count);
		
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		retMap.put("page_num", pageNum);
		retMap.put("max_ret_count", max_ret_count);
		retMap.put("start_index", start_index);
		retMap.put("total_count", ajaxContentsDAO.selectContsList_TotalCnt(jsonMap));
		
		List<?> conts_list = ajaxContentsDAO.selectContsList(jsonMap);
		retMap.put("return_list_count", conts_list.size());
		if (conts_list.size() == 0) {
			retMap.put("retcode", "999");
			retMap.put("retmsg", "조건에 맞는 데이타가 없습니다.");
			return retMap;
		}
		
		retMap.put("conts_list", conts_list);
		retMap.put("retcode", "000");
		retMap.put("retmsg", "정상적으로 조회되었습니다.");
		
		return retMap;
	}
	
	
	
	@Override
	public Map<String, Object> checkContsDelete(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		int cntContents = ajaxContentsDAO.countContents(jsonMap);
		if (cntContents == 0) {
			retMap.put("retcode", "000");
			retMap.put("retmsg", "true");
			return retMap;
		}

		retMap.put("retcode", "000");
		retMap.put("retmsg", "false");
		return retMap;
	}
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////// EXHIBITION OPERATION ///////////////////////////////////////////////////////////////////////
	
	/*
	 * 전시회정보 등록/조회/수정
	 */
	@Override
	public Map<String, Object> exhInfoReg(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile)throws Exception { 
		
		HashMap<String, Object> jsonRetMap = new HashMap();
		
		if("c".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = exhInfoReg_c(jsonMap, aMultipartFile);
		}		
		if ("r".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = exhInfoReg_r(jsonMap);
			return jsonRetMap;
		}			
		if ("u".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = exhInfoReg_u(jsonMap, aMultipartFile);
			return jsonRetMap;
		}
		if ("d".equals(jsonMap.get("crud_tp"))) {
			jsonRetMap = exhInfoReg_d(jsonMap);
			return jsonRetMap;
		}
			
		return jsonRetMap;
	}
	
	
	/*
	 * 전시회정보 등록
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> exhInfoReg_c(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) {	
		// making return map
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		// inserting exhibition info and get exhibition uid
		int exh_uid = ajaxContentsDAO.insertExhInfo(jsonMap);
				
		// making upload file path
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		String file_upload_path = pl.get("IMG_UPLOAD_EXHIBITION_MAIN_PATH") + "exh_uid_" + exh_uid + File.separator;
		
		// print out about file name
		for (int j = 0; j < aMultipartFile.size(); j++) {
			Log.print(LOGGER, "업로드할 파일[" + j + "]=[" + aMultipartFile.get(j).getOriginalFilename() + "]");
		}
		
		
		// inserting file info into DB and upload files into folder
		ArrayList exh_file_list = (ArrayList) jsonMap.get("arr_exh_file");
		int fileIndex = 0;
		int thumbFileSeq = -1;
		for(int i=0; i < exh_file_list.size(); i++) {
			HashMap<String, Object>  exhMap = (HashMap<String, Object>) exh_file_list.get(i);
			exhMap.put("exh_uid", exh_uid);
			
			if(exhMap.get("file_name") != null && ((String)exhMap.get("file_name")).length() > 0) {
				
				// 업로드된 파일명과 동일한지 체크
				if("file[]".equals(aMultipartFile.get(fileIndex).getName())) {
					FileUtil.makeDir(file_upload_path);
					String save_name= null;
					try {
						save_name = FileUtil.uploadFile(file_upload_path, aMultipartFile.get(fileIndex));
						String fileName = (String)exhMap.get("file_name");
						String extName = fileName.substring(fileName.lastIndexOf('.') + 1);
				        if(isStringUpperCase(extName)){
				        	extName = extName.toLowerCase();
				        	fileName = fileName.substring(0, fileName.lastIndexOf('.')+1) + extName;
				        	exhMap.put("file_name", fileName);
				        }
						exhMap.put("save_name", save_name);
					} catch (Exception e) {
						jsonMap.put("retcode", 	"991");
						jsonMap.put("retmsg",	"파일를 UPLOAD 할 수 없습니다.");	
						return jsonMap;
					}
					
					fileIndex ++;
				}
			}
			
			int fileSeq = ajaxContentsDAO.insertExhFile(exhMap);
			
			if((Boolean)exhMap.get("isThumb")) { thumbFileSeq = fileSeq; }
			
		}
		
		// update exhibition thumbnail info
		HashMap<String, Object>  thumbMap = new HashMap<String, Object>();
		thumbMap.put("thumb_file_seq", thumbFileSeq);
		thumbMap.put("exh_uid", exh_uid);
		ajaxContentsDAO.updateExhThumbInfo(thumbMap);
		
		
		// inserting exhibition conts info into DB
		ArrayList exhMainConts = (ArrayList) jsonMap.get("exh_main_conts");		
		for(int i=0; i < exhMainConts.size(); i++) {
			HashMap<String, Object>  contentsMap = (HashMap<String, Object>) exhMainConts.get(i);
			contentsMap.put("exh_uid", exh_uid); 
			ajaxContentsDAO.insertExhMainConts(contentsMap);
		}
		
		returnMap.put("retcode", "000");
		returnMap.put("retmsg",	"정상적으로 등록되었습니다.");
		
		return returnMap;
	}
	
	
	/*
	 * 전시회정보 조회
	 */
	public HashMap<String, Object> exhInfoReg_r(HashMap<String, Object> jsonMap) throws Exception {

		// select exhibition info
		HashMap<String, Object> select_map = ajaxContentsDAO.selectExhibitionInfo(jsonMap);
		if (select_map == null) {
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("retcode", "991");
			jsonMap.put("retmsg", "존재하지 않는 데이타입니다.");
			return jsonMap;
		}		
		Log.print(LOGGER, "select_map" + select_map);
		
		// select exhibition file list
		List<HashMap> exhFileList = (List<HashMap>) ajaxContentsDAO.selectExhibitionFileList(jsonMap);
		select_map.put("exh_file", exhFileList);		
		Log.print(LOGGER, "Exhibition File List ==>  " + exhFileList);
		
		// select exhibition contents list
		List<HashMap> exhContsList = (List<HashMap>) ajaxContentsDAO.selectExhibitionContsList(jsonMap);
		select_map.put("exh_conts", exhContsList);		
		Log.print(LOGGER, "Exhibition Contents List ==>  " + exhContsList);
		
		// select template contents list
		jsonMap.put("exh_tmpl_uid", select_map.get("exh_tmpl_uid"));
		List<?> tmplContsList = ajaxContentsDAO.select_tmpl_prod_list(jsonMap);
		select_map.put("tmpl_conts_list", tmplContsList);

		select_map.put("retcode", "000");
		select_map.put("retmsg", "정상적으로 조회되었습니다.");

		return select_map;
	}
	
	
	
	/*
	 * 전시회정보 update
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> exhInfoReg_u(HashMap<String, Object> jsonMap, List<MultipartFile> aMultipartFile) {	
		// Print Exhibition Json Info
		Log.print(LOGGER, "Exhibition Update Json Info (jsonMap) ==>  " + jsonMap);
		for (int j = 0; j < aMultipartFile.size(); j++) {
			Log.print(LOGGER, "업로드할 파일[" + j + "]=[" + aMultipartFile.get(j).getOriginalFilename() + "]");
		}
		
		// making return map
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
						
		// making upload file path
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		String file_upload_path = pl.get("IMG_UPLOAD_EXHIBITION_MAIN_PATH") + "exh_uid_" + jsonMap.get("exh_uid") + File.separator;
		Log.print(LOGGER, "Exhibition Upload Path ==>  " + file_upload_path);
		
		// select exhibition info
		HashMap<String, Object> select_map = ajaxContentsDAO.selectExhibitionInfo(jsonMap);
		if (select_map == null) {
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("retcode", "991");
			jsonMap.put("retmsg", "존재하지 않는 데이타입니다.");
			return jsonMap;
		}
		
		
		// Upload Exhibition file info
		ArrayList deleteFile = (ArrayList) jsonMap.get("arrayDelName");
		ArrayList insertFile = (ArrayList) jsonMap.get("arrayInsName");
		
		if(deleteFile == null) { deleteFile = new ArrayList();  }
		if(insertFile == null) { insertFile = new ArrayList();  }
		
		for(int i=0; i < deleteFile.size(); i++) {
			jsonMap.put("exh_save_name", deleteFile.get(i));
			
			// db에서 삭제
			int ret = ajaxContentsDAO.deleteExhibitionFile(jsonMap);
			// 실제 물리파일 삭제
			FileUtil.deleteFile(file_upload_path, (String) deleteFile.get(i)); 
		}
		
		
		ArrayList newExhFileList = (ArrayList) jsonMap.get("newExhFileList");
		if(newExhFileList == null) 
			newExhFileList = new ArrayList();
		
		int thumbFileSeq = -1;
		for(int j = 0; j < newExhFileList.size(); j++) {			
			HashMap<String, Object>  fileMap = (HashMap<String, Object>) newExhFileList.get(j);			
			if(fileMap.get("file_name") != null && ((String)fileMap.get("file_name")).length() > 0) {
				for(int i=0;i < insertFile.size();i++) {
					for(int k=0; k < aMultipartFile.size();k++) {
						// 업로드된 파일명과 동일한지 체크한다.
						if(fileMap.get("file_name").equals(insertFile.get(i)) && fileMap.get("file_name").equals(aMultipartFile.get(k).getOriginalFilename())) {
							Log.print(LOGGER, "업로드할 파일명=[" +insertFile.get(i) +"]");
							String save_name = null;
							String fileName = (String)insertFile.get(i);
					        String extName = fileName.substring(fileName.lastIndexOf('.') + 1);
					        if(isStringUpperCase(extName)){
					        	extName = extName.toLowerCase();
					        	fileName = fileName.substring(0, fileName.lastIndexOf('.')+1) + extName;
					        }
					        
							try {
								save_name = FileUtil.uploadFile(file_upload_path, aMultipartFile.get(k));
								
							} catch (Exception e) {
								jsonMap = new HashMap<String, Object>();
								jsonMap.put("retcode", "991");
								jsonMap.put("retmsg", "파일를 업로드할 수 없습니다.");
								return jsonMap;
							}
							jsonMap.put("file_size", fileMap.get("file_size"));
							jsonMap.put("save_name", save_name);
							jsonMap.put("file_name", fileName);

							int fileSeq = ajaxContentsDAO.insertExhFile(jsonMap);
							if((Boolean)fileMap.get("isThumb")) { thumbFileSeq = fileSeq; }
						}
					}
				}
			}
		}
		
		
		// Update Main Contents Info
		ArrayList newMainConts = (ArrayList) jsonMap.get("newMainConts");
		ArrayList updateMainConts = (ArrayList) jsonMap.get("updateMainConts");
		ArrayList delMainConts = (ArrayList) jsonMap.get("delMainConts");
		
		if(newMainConts == null) { newMainConts = new ArrayList();  }
		if(updateMainConts == null) { updateMainConts = new ArrayList();  }
		if(delMainConts == null) { delMainConts = new ArrayList();  }
		
		for(int i=0; i < delMainConts.size(); i++) {
			jsonMap.put("main_conts_uid", delMainConts.get(i));			
			// db에서 삭제
			ajaxContentsDAO.deleteExhMainConts(jsonMap);
		}
		
		for(int i=0; i < updateMainConts.size(); i++) {
			HashMap<String, Object>  contsUpdateMap = (HashMap<String, Object>) updateMainConts.get(i);		
			ajaxContentsDAO.updateExhMainConts(contsUpdateMap);
		}
		
		for(int i=0; i < newMainConts.size(); i++) {
			HashMap<String, Object>  contentsMap = (HashMap<String, Object>) newMainConts.get(i);
			contentsMap.put("exh_uid", jsonMap.get("exh_uid")); 
			ajaxContentsDAO.insertExhMainConts(contentsMap);
		}
		
		
		// update exhibition info
		if(thumbFileSeq != -1) {
			jsonMap.put("exh_thumb_file_seq", thumbFileSeq);
		}

		ajaxContentsDAO.updateExhibitionInfo(jsonMap);
		
		
		returnMap.put("retcode", "000");
		returnMap.put("retmsg",	"정상적으로 등록되었습니다.");
		
		return returnMap;
	}
	
	
	
	/*
	 * [20220207 ELMU] 콘텐츠정보 업데이트
	 */
	public HashMap<String, Object> exhInfoReg_d(HashMap<String, Object> jsonMap) throws Exception {

		HashMap<String, Object> jsonRetMap = new HashMap();

		int delExh = ajaxContentsDAO.deleteExhibitionInfo(jsonMap);
		if (delExh == 0) {
			jsonRetMap.put("retcode", "999");
			jsonRetMap.put("retmsg", "조건에 맞는 데이타가 없습니다.");
			return jsonRetMap;
		}


		jsonRetMap.put("retcode", "000");
		jsonRetMap.put("retmsg", "정상적으로 삭제 되었습니다.");
		return jsonRetMap;
	}
	
	
	
	@Override
	public Map<String, Object> exhibitionViewInfo(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		// select Exhibition View Info
		HashMap<String, Object> exhViewInfo = ajaxContentsDAO.selectExhibitionViewInfo(jsonMap);
		if (exhViewInfo == null) {
			retMap.put("retcode", "999");
			retMap.put("retmsg", "조건에 맞는 데이타가 없습니다.");
			return retMap;
		}
		retMap.put("exh_view_info", exhViewInfo);
		Log.print(LOGGER, "Exhibition View Info ==>  " + exhViewInfo); 
		
		// select exhibition file list
		List<HashMap> exhFileList = (List<HashMap>) ajaxContentsDAO.selectExhibitionFileList(jsonMap);
		retMap.put("exh_file", exhFileList);		
		Log.print(LOGGER, "Exhibition File List ==>  " + exhFileList);
		
		
		// select exhibition contents list
		List<HashMap> exhContsList = (List<HashMap>) ajaxContentsDAO.selectExhibitionContsList(jsonMap);
		retMap.put("exh_conts", exhContsList);		
		Log.print(LOGGER, "Exhibition Contents List ==>  " + exhContsList);
		
		retMap.put("exh_view_info", exhViewInfo);
		retMap.put("retcode", "000");
		retMap.put("retmsg", "정상적으로 조회되었습니다.");
		
		return retMap;
	}
	
	
	
	@Override
	public Map<String, Object> exhibitionInfo(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		HashMap<String, Object> checkTmplUid = new HashMap<String, Object>();
		
		// select Exhibition Info
		HashMap<String, Object> exhInfo = ajaxContentsDAO.selectMainExhibitionInfo(jsonMap);
		if (exhInfo == null) {
			retMap.put("retcode", "999");
			retMap.put("retmsg", "조건에 맞는 데이타가 없습니다.");
			return retMap;
		}
		
		checkTmplUid = ajaxContentsDAO.select_exh_tmpl_info(exhInfo);

		if (checkTmplUid == null || checkTmplUid.size() <= 0) {
			checkTmplUid = new HashMap<String, Object>();
			checkTmplUid.put("retcode", 	"995");
			checkTmplUid.put("retmsg",	"전시관 템플릿이 존재하지 않는 데이타입니다.");			
			return checkTmplUid;
		}
		
		if ("N".equals(exhInfo.get("use_yn"))) {
			retMap.put("retcode", "998");
			retMap.put("retmsg", "비공개");
			return retMap;
		}
		
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREAN);
        String today = (String)sdf.format(new java.util.Date());
        
        String startPeriod = ((String)exhInfo.get("start_period")).replace("/", "-");
        String endPeriod = ((String)exhInfo.get("end_period")).replace("/", "-");
		      
        LocalDate todayDate = LocalDate.parse(today);       
        LocalDate startPeriodDate = LocalDate.parse(startPeriod);
           
        if (todayDate.isBefore(startPeriodDate)) {
            Log.print(LOGGER, "startPeriod ==> nope");
			retMap.put("retcode", "997");
			retMap.put("retmsg", "오픈 전");
			return retMap;
        }
       
        
        LocalDate endPeriodDate = LocalDate.parse(endPeriod);
        
        if (todayDate.isAfter(endPeriodDate)) {
            Log.print(LOGGER, "endPeriodDate  ==> nope");
			retMap.put("retcode", "996");
			retMap.put("retmsg", "종료 후");
			return retMap;
        }     

		
        Log.print(LOGGER, "Exhibition View Info ==>  " + exhInfo);
		
		// select exhibition contents list
		List<HashMap> exhContsList = (List<HashMap>) ajaxContentsDAO.selectExhibitionContsList(jsonMap);		
		Log.print(LOGGER, "Exhibition Contents List ==>  " + exhContsList);
		
		// select contents info
		HashMap<Object, HashMap<String,Object>> product = new HashMap<Object, HashMap<String,Object>>();
		
		for (int i = 0; i < exhContsList.size(); i++) {
			
			HashMap<String, Object> tmpExhConts = (HashMap<String, Object>) exhContsList.get(i);
			HashMap<String, Object> tmpMap = new HashMap<String, Object>();
			
			if((Integer)tmpExhConts.get("root_tp") == 1) {
				
				if((Integer)tmpExhConts.get("prod_tp") == 3 && (Integer)tmpExhConts.get("main_conts_tp") != 3) {
					continue;
				}
				
				String saveName = null;
				String contsType = null;
				
				HashMap<String, Object> tmpConts = new HashMap<String, Object>();
				HashMap<String, Object> tmpContsImgs = new HashMap<String, Object>();
				List<HashMap> contsImgs = new ArrayList();
				String[] imgs = null;

				if(tmpExhConts.get("conts_tp") == null) continue;
				
				switch ((Integer)tmpExhConts.get("conts_tp")) 
				{
					case 1:
						saveName = (String)tmpExhConts.get("thumb_img");
						contsImgs = (List<HashMap>) ajaxContentsDAO.selectContsImgs(tmpExhConts);
						contsType = "image";
						break;
					case 2:
						tmpExhConts.put("srch-word", ".mp4");
						tmpConts = ajaxContentsDAO.selectContsVideoAndGlb(tmpExhConts);
						contsImgs = (List<HashMap>) ajaxContentsDAO.selectContsImgs(tmpExhConts);
						if(tmpConts == null) { saveName = null; }
						else { saveName = (String)tmpConts.get("save_name"); }
						contsType = "video";
						break;
					case 3:
						tmpExhConts.put("srch-word", ".glb");
						tmpConts = ajaxContentsDAO.selectContsVideoAndGlb(tmpExhConts);
						contsImgs = (List<HashMap>) ajaxContentsDAO.selectContsImgs(tmpExhConts);
						if(tmpConts == null) { saveName = null; }
						else { saveName = (String)tmpConts.get("save_name"); }
						contsType = "3D-Content";
						break;
				}

				
				imgs = new String[contsImgs.size()];
				for (int j = 0; j < contsImgs.size(); j++) {
					HashMap<String, Object> mapImgs = (HashMap<String, Object>) contsImgs.get(j);
					imgs[j] = pl.get("API_HOST")+"exhibition/downThumbImg.do?conts_uid="+tmpExhConts.get("conts_uid")+"&file="+mapImgs.get("save_name");
				}
				
				
				tmpMap.put("type", contsType);
				tmpMap.put("title", tmpExhConts.get("main_conts_name"));
				tmpMap.put("images", imgs);
				tmpMap.put("descr", tmpExhConts.get("conts_desc"));
				tmpMap.put("disp_tp", tmpExhConts.get("prod_tp"));
				tmpMap.put("root_tp", tmpExhConts.get("root_tp"));
				
				if(saveName != null) {
					tmpMap.put("url", pl.get("API_HOST")+"exhibition/downThumbImg.do?conts_uid="+tmpExhConts.get("conts_uid")+"&file="+saveName);
				} else {
					tmpMap.put("url", "null");
				}
			} else if((Integer)tmpExhConts.get("root_tp") == 2) {
				HashMap<String, Object> api_info = new HashMap<String, Object>();
				api_info.put("conts_uid", tmpExhConts.get("conts_uid"));
				api_info.put("service_tp", "get_3DConts_info");
				api_info.put("api_url", "//m.3dbank.xyz/Ajax3DWorldController.do");
				tmpMap.put("api_info", api_info);
				tmpMap.put("root_tp", tmpExhConts.get("root_tp"));
				tmpMap.put("disp_tp", 3);
				tmpMap.put("type", "3D-Content");
				tmpMap.put("images", new ArrayList());
			}
			
			product.put(tmpExhConts.get("main_conts_loc"), tmpMap);

		}
		
		String uptDttm = exhInfo.get("upt_dttm").toString();
		uptDttm = uptDttm.replaceAll("\\s+","");
		uptDttm = uptDttm.replaceAll("-","");
		uptDttm = uptDttm.replaceAll(":","");
		uptDttm = uptDttm.replaceAll("\\.","");

		retMap.put("title", exhInfo.get("exh_name"));
		retMap.put("descr", exhInfo.get("exh_desc"));
		retMap.put("url_file", "exhibition/downThumbImg.do?tmpl_uid="+exhInfo.get("exh_tmpl_uid")+"&dir=tmpl&file="+exhInfo.get("save_name") + "&" + uptDttm);
		retMap.put("url_base", pl.get("API_HOST"));	
		retMap.put("product", product);
		
		retMap.put("retcode", "000");
		retMap.put("retmsg", "정상적으로 조회되었습니다.");
		
		return retMap;
	}
	
	
	
	@Override
	public Map<String, Object> exhInfoList(HashMap<String, Object> jsonMap, HttpServletRequest request) throws Exception {
		
		int max_ret_count = jsonMap.get("max_ret_count") != null ? Integer.parseInt((String) jsonMap.get("max_ret_count")) : 12;
		int pageNum = Integer.parseInt((String) jsonMap.get("page_num"));
		int start_index = (pageNum - 1) * max_ret_count;
		
		jsonMap.put("start_index", start_index);
		jsonMap.put("max_ret_count", max_ret_count);
		
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		retMap.put("page_num", pageNum);
		retMap.put("max_ret_count", max_ret_count);
		retMap.put("start_index", start_index);
		retMap.put("total_count", ajaxContentsDAO.selectExhListTotalCnt(jsonMap));
		
		List<?> exh_list = ajaxContentsDAO.selectExhList(jsonMap);
		retMap.put("return_list_count", exh_list.size());
		if (exh_list.size() == 0) {
			retMap.put("retcode", "999");
			retMap.put("retmsg", "조건에 맞는 데이타가 없습니다.");
			return retMap;
		}
		
		// do operation
		
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREAN);
        String today = (String)sdf.format(new java.util.Date());
		
		for (int j = 0; j < exh_list.size(); j++) {
			HashMap<String, Object> tmpExhibition = (HashMap<String, Object>) exh_list.get(j);
			
	        String startPeriod = ((String)tmpExhibition.get("exh_start_period")).replace("/", "-");
	        String endPeriod = ((String)tmpExhibition.get("exh_end_period")).replace("/", "-");
	        ((Map<String, Object>) exh_list.get(j)).put("dateCheck", "true");
	        
	        LocalDate todayDate = LocalDate.parse(today);       
	        LocalDate startPeriodDate = LocalDate.parse(startPeriod);
	           
	        if (todayDate.isBefore(startPeriodDate)) {
	        	((Map<String, Object>) exh_list.get(j)).put("dateCheck", "false");
	        }
	       
	        LocalDate endPeriodDate = LocalDate.parse(endPeriod);
	        
	        if (todayDate.isAfter(endPeriodDate)) {
	        	((Map<String, Object>) exh_list.get(j)).put("dateCheck", "false");
	        } 
		}      

		
		retMap.put("exh_list", exh_list);
		retMap.put("retcode", "000");
		retMap.put("retmsg", "정상적으로 조회되었습니다.");
		
		return retMap;
	}




	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////// HELPER METHODS ///////////////////////////////////////////////////////////////////////////
	
    private static boolean isStringUpperCase(String str){
        
        //convert String to char array
        char[] charArray = str.toCharArray();
        
        for(int i=0; i < charArray.length; i++){
            
            //if any character is not in upper case, return false
            if( Character.isUpperCase( charArray[i] ))
                return true;
        }
        
        return false;
    }
		
}














