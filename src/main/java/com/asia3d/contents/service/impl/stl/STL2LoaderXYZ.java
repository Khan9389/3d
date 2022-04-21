package com.asia3d.contents.service.impl.stl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Hashtable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.asia3d.util.Log;
import com.asia3d.util.PropertyUtil;

public class STL2LoaderXYZ {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(STL2LoaderXYZ.class);
	
	private String PROP_FILE = "/property/3dbank.properties";
	
	private String mocha	= null;
	private String parsejs	= null;
	
	private double iX = -1;
	private double iY = -1;
	private double iZ = -1;

	
	public STL2LoaderXYZ() {
		PropertyUtil pl = new PropertyUtil(PROP_FILE);

		this.mocha			= pl.get("STL2LOADERXYZ_MOCHA");
		this.parsejs	 	= pl.get("STL2LOADERXYZ_PARSEJS");
	}
	
	public void load(String stlfile_path, String stlfile_name) throws Exception {

		Log.print(LOGGER, "###### STL2LoaderXYZ.load ######");
		
		
		String outLine = new String();

		String param[] = {	mocha,
							parsejs,
							stlfile_path + stlfile_name};

		for(int i=0;i<param.length;i++)
		{
			Log.print(LOGGER, ">> param[" + i + "]=[" + param[i] + "]");
		}

		Runtime runtime = Runtime.getRuntime();

		Process process = runtime.exec(param);

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

		while((line = br.readLine()) != null) {
			outLine += line + "<br>\n";
			line = line.trim();
			if(line.startsWith("f_x=")) {
				iX = Double.parseDouble(line.substring(4));
			}
			if(line.startsWith("f_y=")) {
				iY = Double.parseDouble(line.substring(4));
			}
			if(line.startsWith("f_z=")) {
				iZ = Double.parseDouble(line.substring(4));
			}
		}
		
		iX = Double.parseDouble(String.format("%.1f", iX));
		iY = Double.parseDouble(String.format("%.1f", iY));
		iZ = Double.parseDouble(String.format("%.1f", iZ));
		
		Log.print(LOGGER, outLine);
	}
	
	public double getX() {
		return iX;
	}
	
	public double getY() {
		return iY;
	}

	public double getZ() {
		return iZ;
	}


}
