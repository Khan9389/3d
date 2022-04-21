package com.asia3d.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZIPCompress {

	private String files[] = null;
	private ArrayList aUploadFileName = null;

	public ZIPCompress(String files[], ArrayList aUploadFileName) {
		this.files = files;
		this.aUploadFileName = aUploadFileName;
	}

	public void run(String zipfile) throws Exception {
		byte[] buf = new byte[1024];

		ZipOutputStream zipOut = null;
		FileInputStream in = null;
		
		try {
			zipOut = new ZipOutputStream(new FileOutputStream(zipfile));
	
			// files 라는 문자 배열에 정의된 파일 수 만큼 파일들을 압축한다.
			for (int i = 0; i < files.length; i++) {
				in = new FileInputStream(files[i]);
	
				String sUploadFileName = (String)aUploadFileName.get(i);
				
				sUploadFileName = sUploadFileName.substring(sUploadFileName.lastIndexOf(File.separator) + 1);
				zipOut.putNextEntry(new ZipEntry(sUploadFileName));
	
				int len;
				while ((len = in.read(buf)) > 0) {
					zipOut.write(buf, 0, len);
				}
	
				zipOut.closeEntry();
				in.close();
			}
			zipOut.close();
		}
		finally {
			try { if(in != null) in.close(); } catch(Exception e) {}
			try { if(zipOut != null) zipOut.close(); } catch(Exception e) {}
		}
	}

}
