package com.asia3d.contents.service.impl.stl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Hashtable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.asia3d.contents.service.impl.AjaxContentsServiceImpl;
import com.asia3d.util.Log;
import com.asia3d.util.PropertyUtil;

public class STL2Images {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(STL2Images.class);
	
	private String PROP_FILE = "/property/3dbank.properties";
	
	private String imgName = null;
	private String imgPath = null;
	
	private String scad_path 		= null;
	private String save_images_path = null;
	private String stl2png_Shell 	= null;
	private String imagemagick_Shell= null;
	
	private String convRetImage = null;

	public STL2Images() {
		
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		
		this.scad_path			= pl.get("STL2IMAGES_SCAD_PATH");
		this.save_images_path 	= pl.get("STL2IMAGES_SAVE_IMAGES_PATH");
		// stl2png script
		this.stl2png_Shell 		= pl.get("STL2IMAGES_STL2PNG_SHELL");
		// imagemagick script
		this.imagemagick_Shell 	= pl.get("STL2IMAGES_IMAGEMAGICK_SHELL");
	}
	
	public void load(String stlfile_path, String stlfile_name) throws Exception {
		
		Log.print(LOGGER, "###### STL2Images.load ######");
		
		
		
		/* 
		 * 1차 이미지 생성 - Openscad 이용
		 */
		String pngfile_name = stlfile_name + ".png"; 
		
		String openscad_param[] = {	stl2png_Shell,
							scad_path + "stl2png.scad", 
							save_images_path + pngfile_name, 
							stlfile_path + stlfile_name };

		for(int i=0;i<openscad_param.length;i++)
		{
			Log.print(LOGGER, ">> openscad_param[" + i + "]=[" + openscad_param[i] + "]");
		}
		Runtime runtime = Runtime.getRuntime();
		Process process = runtime.exec(openscad_param);
		process.waitFor();
		int exitValue = process.exitValue();
		Log.print(LOGGER, "exit code is not 0 [" + exitValue	+ "]");
		if (exitValue != 0) {
			throw new RuntimeException("exit code is not 0 [" + exitValue	+ "]");
		}

		InputStream is = process.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);

		String line;
		String outLine = new String();
		while((line = br.readLine()) != null) {
			outLine += line + "<br>\n";
		}
		Log.print(LOGGER, outLine);
		
		/////////////////////////////////////////////////////////

		/* 
		 * 2차 이미지 보정작업 - imagemagick 이용
		 */
		String conv_pngfile_name = stlfile_name + ".conv.png"; 

		String imagemagick_param[] = {	imagemagick_Shell,
							save_images_path + pngfile_name,
							save_images_path + conv_pngfile_name
							};

		for(int i=0;i<imagemagick_param.length;i++)
		{
			Log.print(LOGGER, "imagemagick_param[" + i + "]=[" + imagemagick_param[i] + "]");
		}
		runtime = Runtime.getRuntime();
		process = runtime.exec(imagemagick_param);
		process.waitFor();
		exitValue = process.exitValue();
		Log.print(LOGGER, "exit code is not 0 [" + exitValue	+ "]");
		if (exitValue != 0) {
			throw new RuntimeException("exit code is not 0 [" + exitValue	+ "]");
		}

		is = process.getInputStream();
		isr = new InputStreamReader(is);
		br = new BufferedReader(isr);
		outLine = new String();
		
		while((line = br.readLine()) != null) {
			outLine += line + "<br>\n";
			line = line.trim();
			if(line.startsWith("convRetImage=")) {
				convRetImage = line.substring(13);
			}
		}
		Log.print(LOGGER, outLine);		
		
		if(convRetImage == null || convRetImage.length() == 0) {
			throw new Exception("Error STL2Images : " + convRetImage);
		}
	}
	
	public String getConvRetImage() {
		return convRetImage;
	}


}
