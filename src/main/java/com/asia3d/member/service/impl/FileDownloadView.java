package com.asia3d.member.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component(value = "fileDownloadView")
public class FileDownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		File file = (File) model.get("fileDownload");

		response.setContentType("application/download; utf-8");

		response.setContentLength((int) file.length());

		String userAgent = request.getHeader("User-Agent");
		
		String rename = (String) request.getAttribute("fileName");

		String fileName = rename == null ? file.getName() : rename;

		fileName = java.net.URLEncoder.encode(fileName, "utf-8");

		fileName = fileName.replace("+", " ");

		if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1) { // MS
																					// IE
																					// 브라우저에서
																					// 한글
																					// 인코딩

			response.setHeader(
					"Content-Disposition",
					"attachment; filename="

							+ java.net.URLEncoder.encode(fileName, "UTF-8")
									.replaceAll("\\+", "\\ ") + ";");

		} else { // 모질라나 오페라 브라우저에서 한글 인코딩

			response.setHeader(
					"Content-Disposition",

					"attachment; filename="
							+ new String(fileName.getBytes("UTF-8"),
									"ISO-8859-1").replaceAll("\\+", "\\ ")
							+ ";");

		}

		response.setHeader("Content-Transfer-Encoding", "binary");

		OutputStream out = response.getOutputStream();

		FileInputStream fis = null;

		try {

			fis = new FileInputStream(file);

			FileCopyUtils.copy(fis, out);

		} catch (Exception e) {

			// e.printStackTrace();

		} finally {

			if (fis != null) {

				try {

					fis.close();

				} catch (Exception e) {

				}

			}

		}

		out.flush();

	}

}
