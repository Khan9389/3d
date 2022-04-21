/*
 * @(#)PropertyUtil.java	1.0  2007/10/18
 *
 * Copyright 2001 - 2004 Xenomobile, Inc. All rights reserved.
 * This software is the proprietary information of Xenomobile, Inc.
 * This source has license to Xenomobile.
 */

package com.asia3d.util;

import java.io.*;
import java.util.*;

/**
 * Property Utility(실제로 AP에서 사용). 
 * 
 * @author  Lee YongSun
 * @version 1.0, 2004/03/15
 * @since   1.0
 */
public class PropertyUtil
{
	private String prop_file = null;
	public PropertyUtil(String prop_file)
	{
		this.prop_file = prop_file;
	}
	/**
	 * 해당 메소드를 실행한다.(non static)
	 *
	 * @param sFIle	검사할 property파일명(예:"/bbds.properties")
	 * @param sName	검사할 property속성
	 * @return not null(정상적으로 실행 후 리턴값이 존재), null(비정상)
	 * @since 1.0
	 */
	public String get(String sFile, String sName)
	{
		InputStream is = getClass().getResourceAsStream(sFile);

		Properties props = new Properties();
		try 
		{
			props.load(is);
		}
		catch (Exception e) 
		{
			System.err.println("Can't read the properties file. " +
				"Make sure [" + sFile + "] is in the CLASSPATH");
			return null;
		}

		String sVar = props.getProperty(sName, "알수 없는 propsName[" + sFile + "][" + sName+ "]");

		try
		{
			if(is != null)
				is.close();
		}
		catch (Exception e)
		{}

		return sVar;

	}

	/**
	 * 해당 메소드를 실행한다.(use static)
	 *
	 * @param sFIle	검사할 property파일명(예:"/bestech.properties")
	 * @param sName	검사할 property속성
	 * @return not null(정상적으로 실행 후 리턴값이 존재), null(비정상)
	 * @since 1.0
	 */
	public static String getResource(String sFile, String sName)
	{
		Object ob = new Object();

		InputStream is = ob.getClass().getResourceAsStream(sFile);
		if( is == null )
			is = PropertyUtil.class.getResourceAsStream(sFile);

		Properties props = new Properties();
		try
		{
			props.load(is);
		}
		catch (Exception e)
		{
			System.err.println("Can't read the properties file. Make sure [" + sFile + "] is in the CLASSPATH");
			e.printStackTrace();
			ob = null;
			return null;
		}

		String sVar = props.getProperty(sName, "알수 없는 propsName");

		try
		{
			if(is != null)
				is.close();
		}
		catch (Exception e)
		{}

		ob = null;
		return sVar ;

	}

	public String get(String sName)
	{
		return get(prop_file, sName);
	}
}
