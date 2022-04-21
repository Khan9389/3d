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

public class STL2VolumeWeightCalculator {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(STL2VolumeWeightCalculator.class);
	
	private String PROP_FILE = "/property/3dbank.properties";
	
	private String mocha	= null;
	private String parsejs	= null;
	
	private double ivolume;
	private double iweight;

	
	public STL2VolumeWeightCalculator() {
		PropertyUtil pl = new PropertyUtil(PROP_FILE);

		this.mocha			= pl.get("STL2VOLUMEWEIGHT_MOCHA");
		this.parsejs	 	= pl.get("STL2VOLUMEWEIGHT_PARSEJS");
	}
	
	public void load(String stlfile_path, String stlfile_name) throws Exception {

		Log.print(LOGGER, "###### STL2VolumeWeightCalculator.load ######");
		
	
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
			if(line.startsWith("cm^3=")) {
				ivolume = Double.parseDouble(line.substring(5));
			}
			if(line.startsWith("gram=")) {
				iweight = Double.parseDouble(line.substring(5));
			}
		}
		
		ivolume = Double.parseDouble(String.format("%.1f", ivolume));
		iweight = Double.parseDouble(String.format("%.1f", iweight));
		
		Log.print(LOGGER, outLine);

	}
	
	public double getVolume() {
		return ivolume;
	}
	
	public double getWeight() {
		return iweight;
	}

}
