/*
 * @(#)StrUtil.java	1.0  2007/10/18
 *
 * Copyright 2001 - 2004 Xenomobile, Inc. All rights reserved.
 * This software is the proprietary information of Xenomobile, Inc.
 * This source has license to Xenomobile.
 */

package com.asia3d.util;

import java.io.*;
import java.text.*;
import java.util.*;
import java.net.*;
import java.lang.reflect.Method;
import java.math.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *  String 처리를 위한  Utility. 
 * 
 * @author  Lee YongSun
 * @version 1.0, 2004/03/15
 * @since   1.0
 */
public class StrUtil 
{
	static Logger log = LoggerFactory.getLogger(StrUtil.class);
	public static void main( String args[])
	{
		/*
		 * @param sSrc 소스문자열
		 * @param iSize 소스문자열의 전체길이 
		 * @param sChar 채울 문자열
		 * @param sLine 정렬기준(L : 왼쪽정렬, R: 오른쪽정렬)
		 * @return 소스문자열에서 소스문자열의 길이에서 iSize뺀 sChar를 덧붙인 문자열
		 */
		String m = padChars("123", 
							2, 
							".", 
							"L");
		
		//log.error("m=[" + m + "]");

		byte a[] = new byte[0];
		
		//log.error("a=[" + a.length + "]");
	}


	/**
	 * <tt>String</tt>문자열을 <tt>int</tt> 타입으로 변형하여 반환한다. 만약 문자열이 null일 경우는 '0'을 리턴한다.
	 *
	 * @param s  <tt>String</tt>타입의 문자열
	 * @return <tt>int</tt> 타입의 숫자.
	 * @since 1.0
	 */
	public static int parseInt(String s)
    {
        try 
		{
        	if(s == null) 
				return 0;
			else
        		return Integer.parseInt(s);
        }
		catch(Exception e) 
		{
        }
        return 0;
    }

	/**
     * content문에서 줄바꿈 문자(Enter key)를 HTML문의 &lt;br&gt; Tag 로 바꿔주는 함수
	 *
	 * @param content 줄바꿈 문자(Enter key)가 섞인 문자열
	 * @return &lt;br&gt; Tag 이 섞인 html문자열
	 * @since 1.0
	 */
    public static String htmlToBr(String content)
    {
        int length = content.length();
        StringBuffer buffer = new StringBuffer();

        for (int i = 0; i < length; ++i)
        {
            String comp = content.substring(i, i+1);
            if ("\r".compareTo(comp) == 0)
            {
                comp = content.substring(++i, i+1);
                if ("\n".compareTo(comp) == 0)
                    buffer.append("<BR>\r");
                else
                    buffer.append("\r");
            }
            else if ("\n".compareTo(comp) == 0)
            {
                buffer.append("<BR>\r");
            }
            buffer.append(comp);
        }
        return buffer.toString();
    }

	/**
     * content문에서 Single Quota(')를 ('')로 변경한다.
	 *
	 * @param content Single Quota(')가 섞인 문자열
	 * @return ('')로 변경된 문자열
	 * @since 1.0
	 */
	public static String htmlToQuota(String content)
    {
        int length = content.length();
        StringBuffer buffer = new StringBuffer();

        for (int i = 0; i < length; ++i)
        {
            String comp = content.substring(i, i+1);

            if ("'".compareTo(comp) == 0)
            {
                comp = content.substring(++i, i+1);
                buffer.append("''");
            }

            buffer.append(comp);
        }
        return buffer.toString();
    }

	/**
     * content문에서 줄바꿈 문자(Enter key)를 HTML문의 &lt;br&gt; + tab 으로 바꿔주는 함수
	 *
	 * @param content 줄바꿈 문자(Enter key)가 섞인 문자열
	 * @return "&lt;br&gt; + tab"이 섞인 html문자열
	 * @since 1.0
	 */
    public static String htmlToBrTab(String content)
    {
        int length = content.length();
        StringBuffer buffer = new StringBuffer();

        for (int i = 0; i < length; ++i)
        {
            String comp = content.substring(i, i+1);
            if ("\r".compareTo(comp) == 0)
            {
                comp = content.substring(++i, i+1);
                if ("\n".compareTo(comp) == 0)
                    buffer.append("<BR>\r&nbsp;&nbsp;&nbsp;&nbsp;");
                else
                    buffer.append("\r&nbsp;&nbsp;&nbsp;&nbsp;");
            }
            else if ("\n".compareTo(comp) == 0)
            {
                buffer.append("<BR>\r&nbsp;&nbsp;&nbsp;&nbsp;");
            }
            buffer.append(comp);
        }
        return buffer.toString();
    }

	/**
     * content문에서 줄바꿈 문자(Enter key)를 HTML문의 &lt;br&gt; Tag 로 바꿔주는 함수
	 *
	 * @param content 줄바꿈 문자(Enter key)가 섞인 문자열
	 * @return &lt;br&gt; Tag 이 섞인 html문자열
	 * @since 1.0
	 */
	public static String htmlToView(String content)
    {
		/*
        int length = content.length();
        StringBuffer buffer = new StringBuffer();

        for (int i = 0; i < length; ++i)
        {
            String comp = content.substring(i, i+1);
            if("\n".compareTo(comp) == 0){
            	comp = content.substring(++i, i+1);
            	buffer.append("<BR>\n");
            }
            else if("\t".compareTo(comp) == 0){
            	comp = content.substring(++i, i+1);
            	buffer.append("&nbsp;&nbsp;&nbsp;&nbsp;");
            }
            else if(" ".compareTo(comp) == 0){
            	comp = content.substring(++i, i+1);
            	buffer.append("&nbsp;");
            }
            buffer.append(comp);
        }
        return buffer.toString();
		*/
		String retVal = content;
		retVal = retVal.replaceAll("\n","<br>\n");
		retVal = retVal.replaceAll("\t","&nbsp;&nbsp;&nbsp;&nbsp;");
		retVal = retVal.replaceAll(" ","&nbsp;");

		return retVal;
    } 

	/**
	 * 한글문자열의 실제길이를 얻는다.
	 *
	 * @param buf 길이를 구할 문자열
	 * @return 문자열의 실제길이
	 * @since 1.0
	 */
	public static int getHangulLength(String buf)
	{

		int datelen=0;
        for (int i=0; i<buf.length(); i++)
        {
			char nn;
            try 
			{
           		nn = buf.charAt(i);
               	Character.UnicodeBlock uniTmp = Character.UnicodeBlock.of(nn);

                if( uniTmp == Character.UnicodeBlock.HANGUL_COMPATIBILITY_JAMO ||
                    uniTmp == Character.UnicodeBlock.HANGUL_JAMO ||
                    uniTmp == Character.UnicodeBlock.HANGUL_SYLLABLES ||
                    uniTmp == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION  ||
                    uniTmp == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS ||
                    uniTmp == Character.UnicodeBlock.LATIN_1_SUPPLEMENT ||
                    uniTmp == Character.UnicodeBlock.SPECIALS ||
                    uniTmp == Character.UnicodeBlock.GREEK
                )
               	{
					datelen ++;
               	}
				datelen ++;
        	} 
			catch (Exception e) 
			{
           		log.error("In getHangulLength() Exception : "+e);
          	}
        }

		return datelen;
	} // End : int getHangulLength()


	/**
	 * Byte로 변환해서 s_offset에서 e_offset만큼의 문자열을 얻는다.
	 * @param str 문자열
	 * @param s_offset 얻을 문자열의 시작위치
	 * @param e_offset 얻을 문자열의 마지막위치
	 * @return s_offset에서 e_offset만큼의 문자열
	 * @since 1.0
	 */
	public static String byteSubString(String str, int s_offset, int e_offset)
	{
		
		byte b[] = str.getBytes();

		byte f[] = new byte[e_offset-s_offset];
		int m=0;
		for(int i=s_offset;i<e_offset; i++)
		{
			f[m++] = b[i];
		}

		return new String(f);
	}

	/**
	 * Byte로 변환해서 0에서 e_offset만큼의 문자열을 얻는다.
	 * @param str 문자열
	 * @param e_offset 얻을 문자열의 마지막위치
	 * @return 0에서 e_offset만큼의 문자열을 자른 후,  length가 e_offset보다 클 경우 ... 을 붙인다
	 * @since 1.0
	 */
	public static String byteSubStringAddDot(String str, int e_offset)
	{
		String szRet = "";

		if ( str.getBytes().length <= e_offset ) return str;
		
		byte b[] = str.getBytes();

		byte f[] = new byte[e_offset];
		for(int i=0;i<e_offset; i++)
		{
			f[i] = b[i];
		}

		szRet = new String(f);

		if ( e_offset <   str.getBytes().length )
		{
			szRet += "...";
		}

		return szRet;
	}



	/**
	 * 한글이 포함된 문자열에서 s_offset에서 e_offset만큼의 문자열을 얻는다.
	 * @param str 한글이 포함된 문자열
	 * @param s_offset 얻을 문자열의 시작위치
	 * @param e_offset 얻을 문자열의 마지막위치
	 * @return s_offset에서 e_offset만큼의 문자열
	 * @since 1.0
	 */
	public static String hangulSubString(String str, int s_offset, int e_offset)
    {
        String  sCnvStr = new String();

        int datelen=0;
        for(int i=0; i<str.length(); i++)
        {
            char nn;

            try
            {
                nn = str.charAt(i);

                Character.UnicodeBlock uniTmp = Character.UnicodeBlock.of(nn);

                //log.error("nn=[" + nn + "][" + uniTmp + "]");

                if( uniTmp == Character.UnicodeBlock.HANGUL_COMPATIBILITY_JAMO ||
                    uniTmp == Character.UnicodeBlock.HANGUL_JAMO ||
                    uniTmp == Character.UnicodeBlock.HANGUL_SYLLABLES ||
                    uniTmp == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION  ||
                    uniTmp == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS ||
                    uniTmp == Character.UnicodeBlock.LATIN_1_SUPPLEMENT ||
                    uniTmp == Character.UnicodeBlock.SPECIALS ||
                    uniTmp == Character.UnicodeBlock.GREEK
                )
                {
                    // 2Byte문자
                    datelen ++;
                }
                else if(uniTmp == Character.UnicodeBlock.BASIC_LATIN)
                {
                    // 1Byte문자
                }
                else
                {
                    log.error("Unknown Charset:"+uniTmp);
                }
                datelen ++;

                if(datelen > s_offset && datelen <= e_offset)
                    sCnvStr += str.substring(i,i+1);
            }
            catch (Exception e)
            {
                log.error("In hangulSubString() Exception : "+e);
            }
        }

        return sCnvStr;
    } // End : String hangulSubString()

	/**
	 * sBuf문자열에 sP문자를 length길이만큼 정렬하여 채운 문자열을 얻는다.
	 * <br><b>Warning : 한글처리</b>
	 * @param sBuf 소스문자열
	 * @param length 채울문자 길이
	 * @param sP 채울문자
	 * @param sPos 정렬기준("+" : 우측정렬, "-" : 좌측정렬)
	 * @return sBuf문자열에 sP문자를 length길이만큼 정렬하여 채운 문자열
	 * @since 1.0
	 */
	public static String getPaddingString(String sBuf, int length, String sP, String sPos)
	{
		String	sConv = "";
		int i,j;

		if(sPos.equals("-"))
		{
			for(i=0; i<length; i++)
			{
				if(i < getHangulLength(sBuf))
				{
					sConv += hangulSubString(sBuf, i, i+1);
				}
				else
				{
					sConv += sP;
				}
			}
		}
		else if(sPos.equals("+"))
		{
			for(i=0; i<length-getHangulLength(sBuf); i++)
			{
				sConv += sP;
			}
			//log.error("sConv1=[" + sConv + "][" + sConv.length() + "]");
			//log.error("..[" + i + "]");
			for(j=0; i<length; i++, j++)
			{
				sConv += hangulSubString(sBuf, j, j+1);
				//log.error("sConv=[" + sConv + "][" + sConv.length() + "]");
			}
		}

		return sConv;
	}


	/**
	 * sBuf라는 문자열에서 sDivision을 구분자로 해서 index번째 문자열을 얻는다.
	 * <br> (이때 space일 경우는 tab과 마찬가지로 처리한다.)
	 * @param sBuf 소스문자열
	 * @param sDivision 소스문자열에서의 구분자
	 * @param index 구분자의 index
	 * @return 구분자 index번째의 문자열
	 * @since 1.0
	 */
	public static String getTokenString(String sBuf, String sDivision, int index)
	{
		try
		{

			if(sDivision.equals("TAB") || sDivision.equals("tab"))
			{
				sDivision = "\t";
			}
	
			StringTokenizer stz = new StringTokenizer(sBuf,sDivision);
	
			int a = stz.countTokens();
	
			int count = 0;
			String sGetStr = "";
	
			while(stz.hasMoreTokens()) 
			{
				sGetStr = stz.nextToken();
	
				if(count == index)
				{
					return sGetStr;
				}
	
				count ++;
			}
		}
		catch(Exception e)
		{}

		return "";


	}

	/**
	 * sBuf라는 문자열에서 sDivision을 구분자로 한 문자열들을 <tt>ArrayList</tt>로 얻는다.
	 * <br> (이때 space일 경우는 tab과 마찬가지로 처리한다.)
	 * @param sBuf 소스문자열
	 * @param sDivision 소스문자열에서의 구분자
	 * @return 구분자로 나누어진 문자열의 ArrayList
	 * @since 1.0
	 */
	public	static ArrayList getTokenStringArray(String sBuf, String sDivision)
	{
		if(sDivision.equals("TAB") || sDivision.equals("tab"))
		{
			sDivision = "\t";
		}

		if(sBuf == null || sBuf.length() == 0)
			return new ArrayList();

		StringTokenizer stz = new StringTokenizer(sBuf,sDivision);

		ArrayList aList = new ArrayList();

		String sGetStr = "";

		while(stz.hasMoreTokens()) 
		{
			sGetStr = stz.nextToken();
			aList.add(sGetStr);		

		}
		return aList;
	} // End : ArrayList getTokenStringArray()
	
	
	/**
	 * sBuf라는 문자열에서 sDivision을 구분자로 한 문자열들을 <tt>ArrayList</tt>로 얻는다.
	 * <br> (이때 space일 경우는 tab과 마찬가지로 처리하며 중복데이타를 없앤다.)
	 * @param sBuf 소스문자열
	 * @param sDivision 소스문자열에서의 구분자
	 * @return 구분자로 나누어진 문자열의 ArrayList
	 * @since 1.0
	 */
	public	static ArrayList getTokenStringArrayNotDuplication(String sBuf, String sDivision)
	{
		if(sDivision.equals("TAB") || sDivision.equals("tab"))
		{
			sDivision = "\t";
		}

		if(sBuf == null || sBuf.length() == 0)
			return new ArrayList();

		StringTokenizer stz = new StringTokenizer(sBuf,sDivision);

		ArrayList aList = new ArrayList();

		String sGetStr = "";

		while(stz.hasMoreTokens()) 
		{
			sGetStr = stz.nextToken();
			// 중복제거
			if(!aList.contains(sGetStr)) aList.add(sGetStr);		

		}
		return aList;
	} // End : ArrayList getTokenStringArray()
	
	


	/**
	 * sSrc 태그 전문에서 iIndex번째의 sTagName태그의 Value를 얻는다.
	 * @param sSrc 태그형식의 전문(Attribute제외): <A>value Of A Tag</A>
	 * @param sTagName 태그이름
	 * @param iIndex 같은이름의 태그의 인덱스(0부터 시작)
	 * @return iIndex번째의 sTagName태그의 Value
	 */
	public static String getTagValueString(String sSrc, String sTagName, int iIndex)
	{
		String sRet = null;

		try
		{
			String sStartTag = "<"+sTagName.toUpperCase()+">";
			String sEndTag = "</"+sTagName.toUpperCase()+">";
			String sUpperStr = sSrc.toUpperCase();

			int iTotalLength = sSrc.length();
			int iTagLength = sStartTag.length();
			int iStartIndex = 0;
			int iOffset = 0;

			for( int i = 0, j = 0; j <= iIndex; j++)
			{
				iStartIndex = sUpperStr.indexOf(sStartTag, i);
				if( iStartIndex < 0 ) return null;

				iOffset = sUpperStr.indexOf(sEndTag, iStartIndex + iTagLength);
				i = j+iOffset;
			}

			int iEndIndex = sUpperStr.indexOf(sEndTag, iStartIndex + iTagLength);

			sRet = sSrc.substring(iStartIndex + iTagLength, iEndIndex);

		}
		catch(Exception e)
		{
			return null;
		}

		return sRet;
	} // End Of String getTagValueString()


	/**
	 *	Argument 로 입력받은 Data 를 Tag형식으로 변환해서 결과를 Return한다.<br>
	 *	ex) sample	: makeTag("AAAA", "Context") ==> return 결과 : "<AAAA>Context</AAAA>"
	 *	@param	Tag Tag Name
	 *	@param	sSrc Tag에 저장할 Data
	 *	@return	java.lang.String Tag형식으로 변환된 내용
	 *	@sample	makeTag("AAAA", "Context")
	 *			==> return 결과 : "<AAAA>Context</AAAA>"
	 */
	public static String makeTag(String sTag, String sSrc)
	{
		return new String("<" + sTag + ">" + sSrc + "</" + sTag + ">");
	}

	/**
	 *	CDATA 문자열 구성
	 *	@param	sSrc 에 저장할 Data
	 *	@return	CDATA 문자열
	 */
	public static String makeCDATA(String sSrc)
	{
		return new String("<![CDATA[" + sSrc + "]]>");
	}

	/**
     *  <tt>int</tt> 타입의 정수 앞에 자리 수 만큼의  "0"을 삽입시킨다.<br>
     *  ex) sample : appendZero(10, 3) ==> return 결과 : "010"
	 *	@param	iSrc  <tt>int</tt> type의 숫자
	 *	@param	iSize 자리수
	 *	@return	결과 String 
     */
 	public static String appendZero(int iSrc, int iSize)
    {
        String sTmp = new String();
        sTmp = Integer.toString(iSrc);

        int iLen = sTmp.length();
        if( iLen >= iSize )             return sTmp;

        for(int i=0;i < iSize;i++)
		{
			if( sTmp.length() == iSize )	break;

			sTmp = "0" + sTmp;
		}

        return sTmp;
    }

	/**
     *  <tt>long</tt> 타입의 정수 앞에 자리 수 만큼의  "0"을 삽입시킨다.<br>
     *  ex) sample : appendZero(10, 3) ==> return 결과 : "010"
	 *	@param	lSrc  <tt>long</tt> type의 숫자
	 *	@param	iSize 자리수
	 *	@return	결과 String 
     */
 	public static String appendZero(long lSrc, int iSize)
    {
        String sTmp = new String();
        sTmp = Long.toString(lSrc);

        int iLen = sTmp.length();
        if( iLen >= iSize )             return sTmp;

        for(int i=0;i < iSize;i++)
		{
			if( sTmp.length() == iSize )	break;

			sTmp = "0" + sTmp;
		}

        return sTmp;
    }

	/**
     *  <tt>String</tt> 타입의 문자열 앞에 자리 수 만큼의  "0"을 삽입시킨다.<br>
     *  ex) sample : appendZero(10, 3) ==> return 결과 : "010"
	 *	@param	sSrc  <tt>String</tt> type의 문자열
	 *	@param	iSize 자리수
	 *	@return	결과 String 
     */
 	public static String appendZero(String sSrc, int iSize)
    {
        String sTmp = new String();
        sTmp = sSrc;

        int iLen = sTmp.length();
        if( iLen >= iSize )             return sTmp;

        for(int i=0;i < iSize;i++)
		{
			if( sTmp.length() == iSize )	break;

			sTmp = "0" + sTmp;
		}

        return sTmp;
    }
 	


	/**
	 * String 에 문자 중 숫자 이외의 문자가 있는지 검사한다.
	 * <br>
	 * @param sSrc 검사할 문자열
	 * @return  true : 모두가 숫자, false : 그밖의 경우
	 */
	public static boolean isDigit(String sSrc)
	{
		if( sSrc == null || sSrc.length() == 0 )	return false;
		try
		{
			int iLen = sSrc.length();
			for(int i=0; i<iLen;i++)
			{
				if( !java.lang.Character.isDigit( sSrc.charAt(i) ) )	return false;
			}
		}
		catch(Exception e)
		{
			return false;
		}
		return true;
	}

	/**
	 * 숫자에 ','를 붙힌다.
	 * @param lNum 숫자
	 * @return ','이 추가된 숫자문자열
	 */
	public static String getIntoCurrencyFormat(long lNum)
	{
		StringBuffer sbufTmp = new StringBuffer();
		String strNum = null;
		strNum = String.valueOf(lNum);

		int k = strNum.length()%3;
		if( k == 0 ) k = 3;
		sbufTmp.append(strNum.substring(0, k));

		int i;
		for( i = k; i < strNum.length(); i += 3 )
		{
			sbufTmp.append(","+strNum.substring(i,i+3));
		}

		return(sbufTmp.toString());
	}   // End : Util.getIntoCurrencyFormat

	/**
	 * 숫자에 ','를 붙힌다.
	 * @param strNum 숫자문자열
	 * @return ','이 추가된 숫자문자열
	 */
	public static String getIntoCurrencyFormat(String strNum)
	{
		if( strNum == null || strNum.length() == 0 )
			return "";

		StringBuffer sbufTmp = new StringBuffer();

		int k = strNum.length()%3;
		if( k == 0 ) k = 3;
		sbufTmp.append(strNum.substring(0, k));

		int i;
		for( i = k; i < strNum.length(); i += 3 )
		{
			sbufTmp.append(","+strNum.substring(i,i+3));
		}

		return(sbufTmp.toString());
	}   // End : Util.getIntoCurrencyFormat


	/**
	 * sSrc문자열 뒤에 sSrc길이에서 iSize뺀 길이만큼 스페이스를 붙인다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sSrc 소스문자열
	 * @param iSize 소스문자열의 길이에서 뺄 길이
	 * @return 소스문자열에서 소스문자열의 길이에서 iSize뺀 스페이스를 덧붙인 문자열
	 */
	public static String appendSpace(String sSrc, int iSize)
	{
		//byte[] bSrc = sSrc.trim().getBytes();
		if( sSrc == null ) return sSrc;

		byte[] bSrc = sSrc.getBytes();

		int iLen = bSrc.length;

		if( iLen >= iSize )
			return sSrc;

		int iLength = iSize - iLen;

		byte[] bRet = new byte[iLength];

		for(int i=0; i < iLength; i++)
		{
			bRet[i] = 0x20;
		}

		return (sSrc + new String(bRet) );

	} // End : appendSpace()

	/**
	 * sSrc에 한글이 있으면 한글앞뒤로 SO, SI문자를 넣고
	 * iLength길이의 나머지 뒤의 공백은 스페이스로 처리한 문자열을 얻는다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sSrc 소스문자열
	 * @param iLength 반환할 문자열의 길이
	 * @return SO,SI문자와 스페이스처리가 된 문자열
	 */
	public static String getSoSiString(String sSrc, int iLength)
	{
		int i;
		int j;
		int iHanCheckFlag = 0;

		if( sSrc == null ) return sSrc;

		byte[] baTmp = new byte[iLength];
		byte[] baSrc = sSrc.getBytes();

		int iSrcLength = baSrc.length;

		for( i = 0, j = 0; i < iSrcLength; i++, j++ )
		{
			if( j >= iLength )
				break;

			// 한글일 경우
			if( (baSrc[i] & 0x80) == 0x80 )
			{
				// SO처리
				if( iHanCheckFlag == 0 )
				{
					//baTmp[j] = '(';
					baTmp[j] = 0x0E;
					iHanCheckFlag = 1;
					j++;
				}
				baTmp[j] = baSrc[i];
			}
			else // 한글이 아닐 경우
			{
				// SI처리
				if( iHanCheckFlag == 1 )
				{
					//baTmp[j] = ')';
					baTmp[j] = 0x0F;
					iHanCheckFlag = 0;
					j++;
				}

				baTmp[j] = baSrc[i];

			} // End : if( (baSrc[i] & 0x80) == 0x80 ) else

			// 마지막일 경우
			if( i == (iSrcLength - 1) )
			{
				if( iHanCheckFlag == 1 )
				{
					if( j < iLength )
					{
						j++;
						//baTmp[j] = ')';
						baTmp[j] = 0x0F;
					}
					else
					{
						baTmp[j-1] = 0x00;
						baTmp[j] = 0x0F;
						//baTmp[j] = ')';
					}

				} // End : if
			} // End : if( i == (iSrcLength - 1) )


		} // End : for()

		byte[] baRet = new byte[j];
		for( int k = 0; k < j; k++ )
			baRet[k] = baTmp[k];

		return appendSpace(new String(baRet), iLength);

	} // End : String getSoSiString()


	/**
	 * sSrc에 한글이 있으면 한글앞뒤로 SO, SI문자를 넣은 문자열을 반환한다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sSrc 소스문자열
	 * @return 한글앞뒤로 SO, SI문자를 넣은 문자열
	 */
	public static String getSoSiString(String sSrc)
	{
		int i;
		int j;
		int iHanCheckFlag = 0;

		if( sSrc == null ) return sSrc;

		byte[] baSrc = sSrc.getBytes();

		int iSrcLength = baSrc.length;

		int iTmpLength = iSrcLength+1024;
		byte[] baTmp = new byte[iTmpLength];

		for( i = 0, j = 0; i < iSrcLength; i++, j++ )
		{

			// 한글일 경우
			if( (baSrc[i] & 0x80) == 0x80 )
			{
				// SO처리
				if( iHanCheckFlag == 0 )
				{
					//baTmp[j] = '(';
					baTmp[j] = 0x0E;
					iHanCheckFlag = 1;
					j++;
				}
				baTmp[j] = baSrc[i];
			}
			else // 한글이 아닐 경우
			{
				// SI처리
				if( iHanCheckFlag == 1 )
				{
					//baTmp[j] = ')';
					baTmp[j] = 0x0F;
					iHanCheckFlag = 0;
					j++;
				}

				baTmp[j] = baSrc[i];

			} // End : if( (baSrc[i] & 0x80) == 0x80 ) else

			// 마지막일 경우
			if( i == (iSrcLength - 1) )
			{
				if( iHanCheckFlag == 1 )
				{
					j++;
					baTmp[j] = 0x0F;
					//baTmp[j] = ')';
				} // End : if
			} // End : if( i == (iSrcLength - 1) )


		} // End : for()

		byte[] baRet = new byte[j];
		for( int k = 0; k < j; k++ )
			baRet[k] = baTmp[k];

		return new String(baRet);

	} // End : String getSoSiString()

	/**
	 * sStr문자열에서 SO, SI 문자를 뺀 문자열을 구한다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sStr 소스문자열
	 * @return SO, SI 문자를 뺀 문자열
	 */
	public static String getStringDeletedSoSiChar(String sStr)
	{
		byte[] baSrc = sStr.getBytes();

		int iSrcLength = baSrc.length;
		int i;
		int j;

		byte[] baTmp = new byte[iSrcLength];

		for( i=0, j=0; i < iSrcLength; i++ )
		{
			//if( baSrc[i] != '(' && baSrc[i] != ')' )
			if( baSrc[i] != 0x0E && baSrc[i] != 0x0F)
			{
				baTmp[j] = baSrc[i];
				j++;
			}
		}

		byte[] baRet = new byte[j];
		for( int k=0; k < j; k++)
			baRet[k] = baTmp[k];

		return new String(baRet);
	}


	/**
	 * sStr에서 baDelByte문자들을 뺀 문자열을 얻는다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sStr  소스문자열
	 * @param baDelByte : 빼고자 하는 문자 배열
	 * @return 빼고자 하는 문자들이 삭제된 문자열
	 */
	public static String getStringDeletedByteArray(String sStr, byte[] baDelByte)
	{
		byte[] baSrc = sStr.getBytes();

		int iSrcLength = baSrc.length;
		int iArrayLength = baDelByte.length;
		int iCount = 0;
		int iEqualFlag = 0;

		byte[] baTmp = new byte[iSrcLength];

		for( int iF0=0; iF0 < iSrcLength; iF0++ )
		{
			iEqualFlag = 0;

			for( int iF1 = 0; iF1 < iArrayLength; iF1++ )
			{
				if( baSrc[iF0] == baDelByte[iF1] )
				{
					iEqualFlag = 1;
					continue;
				}
				else if( baSrc[iF0] != baDelByte[iF1] &&
						iF1 == (iArrayLength-1) &&
						iEqualFlag == 0
				)
				{
					baTmp[iCount] = baSrc[iF0];
					iCount++;
				} // End : if

			} // End : for

		} // End : for( int iF0=0; iF0 < iSrcLength; iF0++ )

		byte[] baRet = new byte[iCount];
		for( int iF0=0; iF0 < iCount; iF0++)
			baRet[iF0] = baTmp[iF0];

		return new String(baRet);
	} // End : String getStringDeletedByteArray()


	/**
	 * 문자열에서 iStartIndex에서 iSize크기만큼의 문자열을 얻는다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sSrc : 소스문자열
	 * @param iSize : 항목 사이즈
	 * @param iStartIndex : 항목의 첫번째 위치
	 * @return iStartIndex에서 iSize크기만큼의 문자열
	 */
	public static String getItemInStr(String sSrc, int iSize, int iStartIndex)
	{
		if( sSrc == null ) return null;

		byte[] baStr = sSrc.getBytes();
		byte[] baItem = new byte[iSize];

		for( int i = 0; i < iSize; i++ )
		{
			baItem[i] = baStr[i+iStartIndex];
		}

		return new String(baItem);
	}

	/**
	 * 문자열이 null이면 ""를 제외한 길이.
	 * @param sSrc : 소스문자열
	 * @return "" or 소스문자열에서 공백을 없앤 문자열길이
	 */
	public static int isNullLen(String sOrg)
	{
		if(sOrg == null || sOrg.trim().length() == 0)
		{
			return 0;
		}
		
		return sOrg.trim().length();
	}
	public static int isNullLen(Object sOrg)
	{
		if(sOrg == null || ((String) sOrg).trim().length() == 0)
		{
			return 0;
		}
		
		return ((String) sOrg).trim().length();
	}	


	/**
	 * 문자열이 null이면 ""을, 아니면 공백을 없앤 후 리턴한다.
	 * @param sSrc : 소스문자열
	 * @return "" or 소스문자열에서 공백을 없앤 문자열
	 */
	public static String isNull(String sOrg)
	{
		if (sOrg == null || sOrg.equals("null") )
			return "";

		return sOrg.trim();
	}


	/**
     * 문자열이 null이면 "0"을, 아니면 공백을 없앤 후 리턴한다.
     * @param sSrc : 소스문자열
     * @return "0" or 소스문자열에서 공백을 없앤 문자열
     */
    public static String isNullTo0(String sOrg)
    {
        if (sOrg == null || sOrg.equals("null") || sOrg.trim().length() == 0)
            return "0";

        return sOrg.trim();
    }

	/**
	 * URL객체에 해당하는 페이지의 출력문자열을 구한다.<br>
	 * @param   uURL 웹페이지 URL 객체
	 * @return  웹페이지의 소스문자열
	 */
	public static String getURLPageString(URL uURL) throws Exception
	{
		String sLine = "";
		String sDisplayString = "";
		BufferedReader br = null;

		try
		{
			br = new BufferedReader(new InputStreamReader(uURL.openStream() ) );
			int firstCheck = 0;

			while( (sLine = br.readLine() ) != null )
			{
				if( firstCheck != 0 ) sDisplayString += "\r\n";
				sDisplayString += sLine;
				firstCheck++;
			}

		}
		catch(Exception e) { throw e; }
		finally { try { if( br != null ) br.close(); } catch(Exception e) {} }

		return sDisplayString;
	}


	/**
	 * 소스문자열의 "\n"(New Line)을 "&lt;br&gt;\r"로 변환한 문자열을 리턴한다.
	 * @param   content 소스문자열
	 * @return  "\n"(New Line)을 "&lt;br&gt;\r"로 변환한 문자열
	 */
	public static String convertNewLineToBr(String content)
	{
		int length = content.length();
		StringBuffer buffer = new StringBuffer();

		for (int i = 0; i < length; ++i)
		{
			String comp = content.substring(i, i+1);
			if ("\r".compareTo(comp) == 0)
			{
				comp = content.substring(++i, i+1);
				if ("\n".compareTo(comp) == 0)
					buffer.append("<BR>\r");
				else
					buffer.append("\r");
			}
			else if ("\n".compareTo(comp) == 0)
			{
				buffer.append("<BR>\r");
			}
			buffer.append(comp);
		}
		return buffer.toString();
	}

	/**
	 * sSrc문자열에 sSrc길이에서 iSize뺀 길이만큼 sChar를 정렬하여 채운다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sSrc 소스문자열
	 * @param iSize 소스문자열의 전체길이 
	 * @param sChar 채울 문자열
	 * @param sLine 정렬기준(L : 왼쪽정렬, R: 오른쪽정렬)
	 * @return 소스문자열에서 소스문자열의 길이에서 iSize뺀 sChar를 덧붙인 문자열
	 */
	public static String padChars(String sSrc, int iSize, String sChar, String sLine)
	{
		//if( sSrc == null ) return sSrc;
		if( sSrc == null ) sSrc = "";

		byte[] bSrc = sSrc.getBytes();
		byte[] bChar = sChar.getBytes();

		int iLen = bSrc.length;
		int iCharLen = bChar.length;

		if( iLen >= iSize )
		{
			byte[] baTmp = new byte[iSize];
			for( int iF0=0; iF0 < iSize; iF0++)
				baTmp[iF0] = bSrc[iF0];

			return new String(baTmp);
		}

		int iLength = iSize - iLen - iCharLen + 1;

		byte[] bRet = new byte[iLength];

		for(int i=0, j=0; i < iLength; i++, j++)
		{
			if( j >= iCharLen )
				j = 0;
			bRet[i] = bChar[j];
		}

		if( sLine == null ) sLine = "";

		if( sLine.equalsIgnoreCase("L") ) // 왼쪽정렬
			return (sSrc + new String(bRet) );
		else // 오른쪽정렬
			return (new String(bRet) + sSrc);

	} // End : padChars()

	public static String padChars(String sSrc, int iLength, byte btAppend, boolean isLeft)
	{
		if( sSrc == null ) sSrc = "";

		byte[] btSrc = sSrc.getBytes();
		byte[] btDes = new byte[iLength];

		if( btSrc.length >= iLength )
		{
			System.arraycopy(btSrc, 0, btDes, 0, iLength);
		}
		else
		{
			// 왼쪽 정렬
			if( isLeft )
			{
				for( int i=btSrc.length; i<iLength; i++ )
				{
					btDes[i] = btAppend;
				}

				System.arraycopy(btSrc, 0, btDes, 0, btSrc.length);
			}
			// 오른쪽 정렬
			else
			{
				for( int i=0; i<iLength-btSrc.length; i++ )
				{
					btDes[i] = btAppend;
				}

				System.arraycopy(btSrc, 0, btDes, iLength-btSrc.length, btSrc.length);
			}
		}

		return new String(btDes);
	}


	/**
	 * sChar로 정렬된 소스문자열에서 sChar를 뺀 문자열을 구한다.
	 * <br><b>Warning : Byte처리로 되어 있다.</b>
	 * @param sStr 소스문자열
	 * @param sChar 뺄 문자열
	 * @param sLine 정렬기준(L:좌측정렬, 그외 우측정렬)
	 * @return sChar를 뺀 문자열
	 */
	public static String deleteChars(String sStr, String sChar, String sLine)
	{
		byte[] baSrc = sStr.getBytes();
		byte[] baChar = sChar.getBytes();

		int iSrcLength = baSrc.length;
		int iCharLength = baChar.length;
		int iStartIndex = 0;
		int iLength = 0;
		int iCharIndex = 0;

		boolean bEqualFlag = false;

		if( sStr == null || iSrcLength <= 0 ) return sStr;

		if( sLine == null || sLine.length() <= 0 ) return sStr;

		if( sChar == null || iCharLength <= 0 ) return sStr;

		if( sLine.equalsIgnoreCase("L") ) // 왼쪽정렬
		{
			for( int iF0=0; iF0 < iSrcLength; )
			{
				iStartIndex = iF0;
				iCharIndex = iF0%iCharLength;

				if( baSrc[iF0] == baChar[iCharIndex] )
				{
					int iF1 = iF0;
					for( int iTmp=0; iTmp < iCharLength; iF1++, iTmp++)
					{
						iCharIndex = iF1%iCharLength;
						if( baSrc[iF1] != baChar[iCharIndex] )
						{
							bEqualFlag = true;
							break;
						}
					}
				}
				else
					break;

				if( bEqualFlag == true )
					break;

				iF0 += iCharLength;
			}

			iLength = iSrcLength - iStartIndex;

		}
		else // 우측정렬일 경우
		{
			iCharIndex = iCharLength-1;
			for( int iF0=iSrcLength-1; iF0 > 0; )
			{
				iStartIndex = iF0+1;

				if( iCharIndex < 0 )
					iCharIndex = iCharLength-1;

				if( baSrc[iF0] == baChar[iCharIndex] )
				{
					int iF1 = iF0;
					int iCharIndex2 = iCharIndex;
					for( int iTmp=0; iTmp < iCharLength; iF1--, iTmp++, iCharIndex2--)
					{
						if( iCharIndex2 < 0 )
							iCharIndex2 = iCharLength-1;

						if( baSrc[iF1] != baChar[iCharIndex2] )
						{
							bEqualFlag = true;
							break;
						}
					}
				}
				else
					break;

				if( bEqualFlag == true )
					break;

				iF0 -= iCharLength;
				iCharIndex -= iCharLength;
			}

			iLength = iStartIndex;
			iStartIndex = 0;
		}

		String sRet = getItemInStr(sStr, iLength, iStartIndex);

		return sRet;

	} // End : String deleteChars()

	/**
	 * sChar로 정렬된 소스문자열에서 sChar를 뺀 문자열을 구한다.
	 *	구분자로된 연속적인 문자열에서..(예:123,456,789)
	 *	sFlag구분자(예:,)로 문자열이있나 찾아본다.
	 *
	 * @param sStr 		소스문자열
	 * @param sFString 	체크할문자열
	 * @param sFlag		구분자 
	 * @return boolean - true(문자열존재), false(존재하지않음)
	 */
	public static boolean findString(String sStr, String sFString, String sFlag)
	{

		boolean bFind = false;
        for(int i=0;;i++)
        {
            String sVar = getTokenString(sStr,sFlag,i);
            if(sVar == "")
                break;

            if(sVar.equals(sFString))
            {
                bFind = true;
                break;
            }
        }
		
		return bFind;
	}

	/**
	 * sSrcString 문자열의 sFindString 을 찾아서 sReplaceString 으로 바꾸어서 반환한다.
	 * 권고 : ==> replace 메소드를 사용하길 권장함
	 * @param sSrcString 원본 문자열
	 * @param sFindString 찾을 문자열
	 * @param sReplaceString 바꿀 문자열
	 * @return 변경한 전체 문자열
	 */
	public static String replaceWord(String sSrcString, String sFindString, String sReplaceString)
   	{
		String Return_String = new String();	
		int index = sSrcString.indexOf(sFindString, 0);
		if (index < 0) return sSrcString;
		else
		{
			String Remained_String =  sSrcString.substring
                    (index+ sFindString.length(), sSrcString.length());

			Return_String = sSrcString.substring(0, index) + sReplaceString;
   
   			return Return_String + replaceWord(Remained_String, sFindString,sReplaceString);
  		}
   	}

	/**
	 * 지정한 <tt>Hashtable</tt> 에서 지정한  oValue 와 같은 값을 가지는 키 값을 반환한다.
	 * @param hash 키를 찾을 <tt>Hashtable</tt>
	 * @param oValue 찾고자 하는 값
	 * @return 지정한  oValue 와 같은 값을 가지는 키 <tt>Object</tt>
	 */
	public static Object getHashKey(Hashtable hash, Object oValue)
    {
        if(hash.containsValue(oValue))
        {
            Enumeration eValue  =hash.elements();
            Enumeration eKey    =hash.keys();

            while(eValue.hasMoreElements())
            {
                Object oCurrValue   = eValue.nextElement();
                Object oCurrKey     = eKey.nextElement();

                //System.out.print("=>"+oCurrValue + "\n");
                //System.out.print("=>"+oCurrKey + "\n");

                if(oCurrValue.equals(oValue))
                {
                    return oCurrKey;
                }
            }
        }

        return null;
    }

	/**
	 * <tt>Hashtable</tt>의 구성이 key + Hashtable로 구성이 되어있고
	 * 다시 Hashtable이 name + value로 구성이 되었을 경우 
	 * name + value가 일치하는 key를 얻는다.
	 *
	 * @param hash   모든 정보가있는 hashtable
	 * @param obj1   name 에 관련된 object
	 * @param obj2   value에 관련된 object
	 * @return key object
	 * @since 1.0
	 */
	public static Object getHashKey(Hashtable hash, Object obj1, Object obj2)
	{

		Enumeration eValue_out  =hash.elements();
		Enumeration eKey_out    =hash.keys();

		Object oCurrValue_out	=	null;
		Object oCurrKey_out		=	null;

		Hashtable hash_in  		= new Hashtable();

		while(eValue_out.hasMoreElements())
		{
			oCurrValue_out   = eValue_out.nextElement();
			oCurrKey_out     = eKey_out.nextElement();

			//System.out.print("=><><><><><=\n");

			hash_in  = (Hashtable)oCurrValue_out;
			//System.out.print("=>"+ hash_in + "\n");

			if(hash_in.containsKey(obj1) &&
					hash_in.get(obj1).equals(obj2))
			{
				return oCurrKey_out;
			}
		}
		return null;
	}

	/**
	 * 지정한 <tt>Hashtable</tt> 에서 키의 값을 oKey1 에서 oKey2 으로 변경한다.  단 값을 그대로 유지한다.
	 * @param hash 키를 바꿀 <tt>Hashtable</tt>
	 * @param oKey1 바꾸고자 하는 키 값
	 * @param oKey2 바꾼후의  키 값
	 * @return 키를 바꾼후의 <tt>Hashtable</tt> 객첵
	 */
    public static Hashtable changeHashKey(Hashtable hash, Object oKey1, Object oKey2)
    {
        try
        {
            if(hash.containsKey(oKey1))
            {
                Object oValue   = hash.get(oKey1);
                hash.remove(oKey1);
                hash.put(oKey2, oValue);
                return hash;
            }
        }
        catch(Exception e)
        {}

        return hash;
    }

	
	/**
	 *	숫자앞에 있는 0을 없앤다.
     * 넘어온  숫자가 "0"이나 space면 "0"을 반환한다.
	 * @param sOrg 편집할 숫자값   
	 * @return 편집된 숫자값 
	 */
	public static String zeroDel(String sOrg)
	{
		String sValidData;
		boolean bMinusExist = false;

		try
		{
			if( sOrg.indexOf('-') >= 0 )
			{
				bMinusExist = true;
				sValidData = new String(sOrg.substring(sOrg.indexOf('-')+1));
			}
			else
				sValidData = new String(sOrg);

			sValidData = sValidData.trim();

			int i = 0;
			for( ; i<sValidData.length() ; i++ )
			{
				if( sValidData.charAt(i) != '0' )
					break;
			}

			if( i == sValidData.length() )
				return "0";

			if( bMinusExist )
				return "-" + sValidData.substring(i, sValidData.length());

			return sValidData.substring(i, sValidData.length());
		}
		catch( Exception e )
		{
			return sOrg;
		}
	}//end of zeroDel()


	/**
	* 숫자앞에 있는 0을 없앤 다음
	* 세자리 단위마다 콤마(,)를 찍어준다. 첫번째 문자가 1이면 '-'...
	*
	* @param sOrg 편집할 가격 값 
 	* @return 편집된 가격 값 
	*/
	public static String insertComma(String sOrg)
	{
		try
		{
				if(sOrg == null || sOrg.length() < 1)
							return sOrg;

				String sValidData = sOrg.trim();

				boolean bMinusExist = false;

				if( sValidData.charAt(0) == '-' )
				{
					bMinusExist = true;
					sValidData = sValidData.substring(1);
				}

				if( sValidData.charAt(0) == '+' )
				{
					sValidData = sValidData.substring(1);
				}

				sValidData = zeroDel(sValidData);

				byte[] btData = sValidData.getBytes();
				byte[] btResult = "000000000000000000000000000000".getBytes();

				int iPos = sValidData.length()-1;
				int iRetPos = 29;

				while(true)
				{
					for( int i =0 ; i < 3 ; i++ )
					{
						if( iPos < 0 )
							break;

						btResult[iRetPos--] = btData[iPos--];
					}

					if( iPos >= 0 )
					{
						btResult[iRetPos--] = (byte)',';
					}
					else if( iPos < 0 )
					{
						break;
					}
				}

				if( bMinusExist ) btResult[iRetPos] = (byte)'-';

				return zeroDel(new String(btResult));
		}catch(Exception e){ log.error("StrUtil.s_InsertComma Err=[" + e + "][" + sOrg + "]");}
		return sOrg;

	}//end of s_InsertComma()

	/**
	 * 지정한 문자열을 태그 형식으로 작성하여 반환한다. <br>
	 * ex) sample : tagSet("tag_name", "tag_value") ==> result : "<tag_name>tag_value</>"
	 * @param tagname 태그 이름
	 * @param value 태그 값
	 * @return 태그형식의 문자열
	 */
    public static String tagSet(String tagname, String value)
    {
        String Result = new String();

        Result = "<" + tagname + ">" + value + "</>";
        return Result;
    }

	/**
	 * 지정한 태그 문자열에서  태그 이름에 해당하는 값을  반환한다. <br>
	 * ex) sample : tagSet("tag_name", "tag_value") ==> result : "<tag_name>tag_value</>"
	 * @param sSrc  태그 문자열
	 * @param tagName  태그 이름
	 * @return  태그이름에 해당하는 값의 문자열
	 */
    public static String tagGet(String sSrc, String tagName)
    {
        String sValue = new String();

        int iSoff = sSrc.indexOf("<" + tagName + ">");
        int iEoff = sSrc.indexOf("</>", iSoff);

        if(iSoff <  0 || iEoff <  0)
            return "";
        if(iSoff >= iEoff)
            return "";
        return sSrc.substring( iSoff+2+tagName.length() , iEoff);
    }

	/**
	 * 지정한 sSrc 태그형식 문자열에서 index 번째 해당하는 태그 이름을 반환한다.
	 * @param sSrc 태그형식 문자열
	 * @param index 찾고자 하는 index
	 * @param 찾은 태그이름 (없으면 null)
	 */
	public static String tagGetNameIndex(String sSrc, int index)
    {
        int iCurrPos = 0;
        int i = 0;
        while(true)
        {
            int iSoff = sSrc.indexOf("<", iCurrPos);

            int iEoff = sSrc.indexOf(">", iSoff);

            if(iSoff <  0 || iEoff <  0)
                break;
            if(iSoff >= iEoff)
                break;

            if(!sSrc.substring(iSoff,iEoff+1).equals("</>"))
            {
                if(index == i)
                {
                    return sSrc.substring(iSoff+1,iEoff);
                }
                i++;
            }
            iCurrPos = iEoff;
        }

        return null;
    }
	
	/** 
	 * 태그를 추가한다. 만일 태그가 존재한다면 엎어친다.
	 * @param sTagString 태그 문자열
	 * @param sTag 추가할 태그 이름
	 * @param value 추가할 태그 값
	 * @param 추가된 결과 태그 문자열
	 */
    public static String tagAdd(String sTagString, String sTag, String value)
    {
        if(sTagString.indexOf("<" + sTag + ">") >= 0)
        {
            return tagChange(sTagString, sTag, value);
        }
        else
        {
            return sTagString + "<" + sTag + ">" + value + "</>";
        }
    }

	/** 
	 * 지정한 sSrc 태그문자열에서 sTag 태그에 해당하는 값을 지정한 value 의 값으로 변경한다.
	 * @param sTagString 태그 문자열
	 * @param sTag 추가할 태그 이름
	 * @param value 추가할 태그 값
	 * @param 추가된 결과 태그 문자열 (지정한 sTag 태그에 해당하는 이름이 없을 경우 "" 을 반환)
	 */
    public static String tagChange(String sSrc, String sTag, String Value)
    {
        int     iSoff;
        int     iEoff;
        String  sTmpSrc = new String();

        iSoff = sSrc.indexOf("<" + sTag + ">");
        iEoff = sSrc.indexOf("</>", iSoff);


        if(iSoff <  0 || iEoff <  0)
            return "";
        if(iSoff >= iEoff)
            return "";


        iSoff += sTag.length() + 2;

        //log.error("iSoff=[" + iSoff + "]");
        //log.error("iEoff=[" + iEoff + "]");

        sTmpSrc = sSrc.substring(0, iSoff);
        sTmpSrc += Value;
        sTmpSrc += sSrc.substring(iEoff, sSrc.length());

        //log.error("=[" + sTmpSrc + "]");

        return sTmpSrc;
    }

	/** 
	 * 키값을 전문태그명, Value를 전문태그값으로 가지는 Hashtable을
	 * 받아서 Tag 전문으로 변환 시켜준다. 
	 *
	 * @param Hashtable hOrg 
	 * @return String sRetJunmun 태그 전문
	 */
	public static String tagAdd( Hashtable hOrg )
	{
		String sRet = new String();
		String sTemp = new String();

		String sKey = new String();
		String sValue = new String();

		for ( Enumeration e = hOrg.keys() ; e.hasMoreElements(); )
		{
			sKey = (String)e.nextElement();

			sValue = (String)hOrg.get(sKey);

			sRet = tagAdd(sRet,sKey, sValue);

		}

		return sRet;
	}

	/**
	 * 지정한 <tt>String</tt> 타입의 s1, s2 의 값의 차를 반환한다. (s1 -  s2)
	 * 내부적으로 <tt>BigDecimal</tt> 타입으로 변환하여 계산한다.
	 * @param s1 첫번째 문자열
	 * @param s2 두번째 문자열
	 * @param 두 문자열의 차 (s1-s2)
	 */ 
	public static String bigMinus(String s1, String s2)
    {
		if(s1 == null)
			s1 = "0";
		if(s2 == null)
			s2 = "0";


		BigDecimal B1 = new BigDecimal(s1);
		BigDecimal B2 = new BigDecimal(s2);
		BigDecimal B3 = B1.subtract(B2);

		return B3.toString();
	}

	/**
	 * 지정한 <tt>String</tt> 타입의 s1, s2 의 값의 합을 반환한다. (s1 +  s2)
	 * 내부적으로 <tt>BigDecimal</tt> 타입으로 변환하여 계산한다.
	 * @param s1 첫번째 문자열
	 * @param s2 두번째 문자열
	 * @param 두 문자열의 합 (s1 + s2)
	 */ 
    public static String bigSum(String s1, String s2)
    {
		if(s1 == null)
			s1 = "0";
		if(s2 == null)
			s2 = "0";


		BigDecimal B1 = new BigDecimal(s1);
		BigDecimal B2 = new BigDecimal(s2);
		BigDecimal B3 = B1.add(B2);

		return B3.toString();
	}


	/**
	 * 지정한 <tt>String</tt> 타입의 s1, s2 의 값을 비교한다. (Compare s1 to s2)
	 * 내부적으로 <tt>BigDecimal</tt> 타입으로 변환하여 계산한다.
	 * @param s1 첫번째 문자열
	 * @param s2 두번째 문자열
	 * @return 이 BigDecimal 의 값이 o 보다 작은 경우는 부의 수, 동일한 경우는 0, 
	 * 			큰 경우는 정의 수. 
	 */ 
    public static int bigCompareTo(String s1, String s2)
    {
		if(s1 == null)
			s1 = "0";
		if(s2 == null)
			s2 = "0";


		BigDecimal B1 = new BigDecimal(s1);
		BigDecimal B2 = new BigDecimal(s2);

		return B1.compareTo(B2);
	}

	/**
	 * 지정한 <tt>String</tt> 타입의 s1, s2 의 값의 곱을 반환한다. (s1 *  s2)
	 * 내부적으로 <tt>BigDecimal</tt> 타입으로 변환하여 계산한다.
	 * @param s1 첫번째 문자열
	 * @param s2 두번째 문자열
	 * @param 두 문자열의 곱 (s1 * s2)
	 */
    public static String bigMultiply(String s1, String s2)
	{

		BigDecimal B1 = new BigDecimal(s1);
		BigDecimal B2 = new BigDecimal(s2);
		BigDecimal B3 = B1.multiply(B2);

		return B3.toString();
	}

	/**
	 * 지정한 <tt>String</tt> 타입의 s1, s2 의 값의 곱을 반환한다. 소수점 밑은 삭제한다. (s1 *  s2)
	 * 내부적으로 <tt>BigDecimal</tt> 타입으로 변환하여 계산한다.
	 * @param s1 첫번째 문자열
	 * @param s2 두번째 문자열
	 * @param 두 문자열의 곱 (s1 * s2)
	 */
    public static String bigMultiply2(String s1, String s2)
	{

		BigDecimal B1 = new BigDecimal(s1);
		BigDecimal B2 = new BigDecimal(s2);
		BigDecimal B3 = B1.multiply(B2);

		return toMoneyComma(B3.toString());
	}

	/**
	 * 지정한 <tt>String</tt> 타입의 s1, s2 의 값의 나눗셈(/) 연산 결과를 반환한다. (s1 / s2)
	 * 내부적으로 <tt>BigDecimal</tt> 타입으로 변환하여 계산한다. (반올림)
	 * @param s1 첫번째 문자열
	 * @param s2 두번째 문자열
	 * @param 두 문자열의 나눗셈(/) 결과 (s1 / s2)
	 */
    public static String bigDiv(String s1, String s2, int iRounding)
	{

		BigDecimal B1 = new BigDecimal(s1);
		BigDecimal B2 = new BigDecimal(s2);
		BigDecimal B3 = B1.divide(B2,iRounding,iRounding+1);

		return B3.toString();
	}

	/**
	 * 문자열내에서 바꾸고 싶은 문자열을 찾아서 원하는 문자열로 바꿔준다.
	 *
	 * @param sotreStr 원본 문자열
	 * @param oldStr 바꿀 문자열
	 * @param newStr 바뀔 문자열
	 * @return 바뀐 문자열
	 * @exception Execption error occurs
	 */
  public static String replace(String storeStr, String oldStr, String newStr)
      {

    int index = 0;
    StringBuffer returnStr = new StringBuffer();

    try {
      for( int i=1; true; i++ ) {
        if( (index = storeStr.indexOf(oldStr)) == -1 ) {
          returnStr.append( storeStr );
          break;
        }
        returnStr.append( storeStr.substring(0, index) );
        returnStr.append( newStr );
        storeStr = storeStr.substring(index+oldStr.length(), storeStr.length());
      }
    }
    catch( Exception e ) {  return "";}

    return returnStr.toString();
  } 


	/**
	 * String 내의 mark된 부분을 Vector로 넘어온 String으로 대치시킨다. default
	 * mark로 "#"을 사용한다.
	 *
	 * @param str mark를 갖고 있는 String
	 * @param replacedStr mark 부분을 대치할 문자를 담고 있는 Vector
	 * @return 분리된 string array
	 * @exception Execption error occurs
	 */
  public static String replaceString(String str, Vector replacedStr) {
    return replaceString(str, replacedStr, "#");
  }


	/**
	 * String 내의 mark된 부분을 Vector로 넘어온 String으로 대치시킨다.
	 *
	 * @param str mark를 갖고 있는 String
	 * @param replacedStr mark 부분을 대치할 문자를 담고 있는 Vector
	 * @param markStr mark로 사용할 String
	 * @return 분리된 string array
	 * @exception Execption error occurs
	 */
  public static String replaceString(String str, Vector replacedStr, String markStr) {

    // -1 is not necesarry as the sql statement will not start with flagStr
    int    previous = 0;
    int    current = 0;
    int    length;

    String endString = null;
    String newStatement = new String(str);

    for (int i = 0; i < replacedStr.size(); i++) {
      current = newStatement.indexOf(markStr, previous);
      String o = (String)replacedStr.elementAt(i);

      if (o != null) {
        length = newStatement.length();
        endString = newStatement.substring(current + 1, length);
        newStatement = newStatement.substring(0, current).concat(o);
        newStatement = newStatement.concat(endString);
      }
      previous = current + 1;
    }

    return newStatement;
  }

	/**
	 * 구분자에 의해 분리된 string을 분리하여 string array 로 만든다.
	 * 내부적으로  Trim 하지 않는다.
	 * @param str 구분자에 의해 분리된 string
	 * @param delim 구분자
	 * @return 분리된 string array
	 * @exception Execption error occurs
	 */
	public static String[] split(String str, String delim)   {
    StringTokenizer st = new StringTokenizer(str, delim);
    String[] strArr = null;

    try {
      int count = st.countTokens();
      strArr = new String[count];
      for(int i=0; st.hasMoreTokens(); i++) {
        strArr[i] = st.nextToken();
      }
    }
    catch( NoSuchElementException nsee) {}
    return strArr;
	}

	/**
	 * 구분자에 의해 분리된 string을 분리하여 공백을 없앤후 string array 로 만든다.
	 * 분리한 문자열을 내부적으로 Trim 을 실행한다.
	 * @param str 구분자에 의해 분리된 string
	 * @param delim 구분자
	 * @return 분리된 string array
	 * @exception Execption error occurs
	 */
	public static String[] splitTrim(String str, String delim)   {
    StringTokenizer st = new StringTokenizer(str, delim);
    String[] strArr = null;

    try {
      int count = st.countTokens();
      strArr = new String[count];
      for(int i=0; st.hasMoreTokens(); i++) {
        strArr[i] = st.nextToken().trim();
      }
    }
    catch( NoSuchElementException nsee) {  
    }
    return strArr;
	}


  /**
   * <tt>String</tt> 타입의 금액에 ','를 붙인다.
   *
   * @param money 원본 금액
   * @return 변환된 금액(123,456,789)
   * @exception Execption error occurs
   */
  public static String toMoneyFormat(String money)   {
	  if (money == null)		return "";
	  if (money.equals(""))		return "0";

		String money2 = "";
		String money3 = "" ;  //-처리
		/* modify by songmi		
			- 금액 처리		*/
		int posCheck = money.indexOf("-");

		int pos = money.indexOf(".");
		if (posCheck==0)
		{
			money3	=	money.substring(0,1) ;
			money = money.substring(posCheck+1,money.length());
		}
		if(pos > 0)
		{
			money2 = money.substring(pos, money.length());
			money = money.substring(0,pos);
		}
	 BigDecimal big =  new BigDecimal(money);
	 money = big.toString();
    return money3 + toAnyFormat(money, 3, ',') + money2;
  }


  /**
   * <tt>BigDecimal</tt> 타입의 금액에 ','를 붙인다.
   *
   * @param money 원본 금액
   * @return 변환된 금액
   * @exception Execption error occurs
   */
  public static String toMoneyFormat(java.math.BigDecimal money)   {
    if (money == null)
                return "";

    return toAnyFormat(money.toString(), 3, ',');
  }


  /**
   * 금액에 ','를 붙인다. (통화코드에 따른  포맷 변경)
   * 통화코드가 KRW 인 경우에는 toMoneyFormat(String money) 와 동일함
   * @param currCd 통화코드 ('KRW' 등...., 현재는 KRW 만 지정할 수 있음)
   * @param money 원본 금액
   * @return 변환된 금액 (123,456,789)
   * @exception Execption error occurs
   */
  public static String toMoneyFormat(String currCd, String money)   {
	  if (money == null) return "";
	  if (money.equals("0")) return "";

	  if(money.indexOf(".") < 0){
		  log.error("금액 변환에러[toMoneyFormat]"+ currCd+","+money);
		  return toAnyFormat(money, 3, ',');
	  }
	  if(currCd.equals("KRW")){
		  money = money.substring(0,money.indexOf("."));
		  BigDecimal big =  new BigDecimal(money);
		  money = big.toString();
		  return toAnyFormat(money, 3, ',');
	  }else{
		  String temp = "";
		  money = money.substring(0,money.indexOf("."));
		  temp = money.substring(money.indexOf("."));
		  BigDecimal big =  new BigDecimal(money);
		  money = big.toString();
		  return toAnyFormat(money, 3, ',')+temp;
	  }
  }

  /**
   * 금액에 '.'이하를 제거한다.
   *
   * @param money 원본 금액
   * @return 변환된 금액
   * @exception Execption error occurs
   */
  public static String toMoneyComma(String money)   {
	  if (money == null)
                return "";

	  if(money.indexOf(".") < 0)
		  return money;
	  else
		  return money.substring(0,money.indexOf("."));
  }


  /**
   * 카드번호에 '-'를 붙인다.
   *
   * @param cardNum 원본 카드번호
   * @return 변환된 카드번호(1111-2222-3333-4444)
   * @exception Execption error occurs
   */
  public static String toCardFormat(String cardNum)   {
    if( cardNum == null )
	return "";

    if( cardNum.length() != 16 )
	return cardNum;

    return toAnyFormat(cardNum, 4, '-');
  }


 /**
   * 날짜에 '/'를 붙인다.
   *
   * @param sourceDate 원본 날짜(8자리)
   * @return 변환된 날짜(2004-02-03)
   * @exception Execption error occurs
   */
  public static String toDateFormat(String sourceDate)   {
    if (sourceDate == null)
	return "";

    if( sourceDate.length() != 8 ){
		return sourceDate;
    }

    StringBuffer newDate = new StringBuffer();

    newDate.append( sourceDate.substring(0,4) );
    newDate.append( "-" );
    newDate.append( sourceDate.substring(4,6) );
    newDate.append( "-" );
    newDate.append( sourceDate.substring(6,8) );

    return newDate.toString();
  }

 /**
   * 날짜포맷 변환
   *
   * @param sourceDate 원본 날짜(8자리)
   * @return 변환된 날짜(2004년 02월 03일)
   * @exception Execption error occurs
   */
  public static String toDateFormatF(String sourceDate)   {
    if (sourceDate == null)
    return "";

    if( sourceDate.length() != 8 ){
        return sourceDate;
    }

    StringBuffer newDate = new StringBuffer();

    newDate.append( sourceDate.substring(0,4) );
    newDate.append( "년 " );
    newDate.append( sourceDate.substring(4,6) );
    newDate.append( "월 " );
    newDate.append( sourceDate.substring(6,8) );
    newDate.append( "일" );

    return newDate.toString();
  }


/**
   * 날짜를 특정 구분자로 구분하여 반환한다. ('-','/','', 등)
   *
   * @param sourceDate 원본 날짜 (6자리 또는 8자리)
   * @param gubun  구분자 ('-', '/', '' 등)
   * @return 변환된 날짜 (예 : 2007/09, 2004/02/04 , 2003-09-09, 2003-01)
   * @exception Execption error occurs
   */
  public static String toDateFormat(String sourceDate, char gubun)   {
    if (sourceDate == null)
	return "";
    

    if((sourceDate.length() != 6) && (sourceDate.length() != 8) ){
		return sourceDate;
    }

    StringBuffer newDate = new StringBuffer();

    newDate.append( sourceDate.substring(0,4) );
    newDate.append(gubun);
    newDate.append( sourceDate.substring(4,6) );

	if(sourceDate.length() == 8)   {
	    newDate.append(gubun);
		newDate.append( sourceDate.substring(6,8) );
	}

    return newDate.toString();
  }

 /**
   * 사업장번호에 '-'를 붙인다.
   *
   * @param srcCNum 원본 사업장번호(10자리)
   * @return 변환된 사업장번호(213-45-12345)
   * @exception Execption error occurs
   */
  public static String toComNumFormat(String srcCNum)   {
    if (srcCNum == null)
	return "";

    if( srcCNum.length() != 10 ){
		return srcCNum;
    }

    StringBuffer newString = new StringBuffer();

    newString.append( srcCNum.substring(0,3) );
    newString.append( "-" );
    newString.append( srcCNum.substring(3,5) );
    newString.append( "-" );
    newString.append( srcCNum.substring(5,10) );

    return newString.toString();
  }

 /**
   * 주민번호에 '-'를 붙인다.
   *
   * @param rdnt (13자리)
   * @return 변환된 주민번호(711111-1234567)
   * @exception Execption error occurs
   */
  public static String toRdntFormat(String srcRdnt)   {
    if (srcRdnt == null)
	return "";

    if( srcRdnt.length() != 13 ){
		return srcRdnt;
    }

    StringBuffer newRdnt = new StringBuffer();

    newRdnt.append( srcRdnt.substring(0,6) );
    newRdnt.append( "-" );
    newRdnt.append( srcRdnt.substring(6,13) );

    return newRdnt.toString();
  }


 /**
   *  우편번호에 '-'를 붙인다.
   *
   * @param sourceDate 원본 우편번호(6자리)
   * @return 변환된 우편번호(123-456)
   * @exception Execption error occurs
   */
  public static String toPostFormat(String sourceStr)   {
    if (sourceStr == null)
	return "";

    if( sourceStr.length() != 6 ){
		return sourceStr;
    }

    StringBuffer newStr = new StringBuffer();

    newStr.append( sourceStr.substring(0,3) );
    newStr.append( "-" );
    newStr.append( sourceStr.substring(3,6) );

    return newStr.toString();
  }


 /**
   * 전화번호에 '-'를 붙인다.
   *
   * @param sourceTele 원본 전화번호
   * @return 변환된 번호
   * @exception Execption error occurs
   */
  public static String toTeleFormat(String sourceTele)   {
    if (sourceTele == null)
	return "";

		int iLen = sourceTele.length();
		int iLenBuf = 0;
		int iLenBuf1 = 0;

		 String newTele1 = new String();
		 String newTele2 = new String();
		 String newTele3 = new String();
		 StringBuffer newTele=new StringBuffer();
		 
		 iLenBuf=(iLen-4);
		 iLenBuf1=(iLenBuf-4);
		 if((iLenBuf<0) || (iLenBuf1<0)){
			 return sourceTele;
		 }else{
			newTele3=sourceTele.substring(iLenBuf,iLen);
		 	newTele2=sourceTele.substring(iLenBuf1,iLenBuf);
			newTele1=sourceTele.substring(0,iLenBuf1);
			newTele.append(newTele1);
			newTele.append("-");
			newTele.append(newTele2);
			newTele.append("-");
			newTele.append(newTele3);
		 }
		return newTele.toString();
	}


	/**
   * 시간에 ':'를 붙인다.
   *
   * @param sourceDate 원본 시간(6자리)
   * @return 변환된 시간(12:34:56)
   * @exception Execption error occurs
   * [2006.09.06] : 4자리도 처리하도록 추가
   */
  public static String toTimeFormat(String sourceTime)   {
    if( sourceTime == null )
	return "";
    if( sourceTime.length() != 6 && sourceTime.length() != 4 ){
	return sourceTime;
  }

    StringBuffer newTime = new StringBuffer();

	if( sourceTime.length() == 4 )
	{
		newTime.append( sourceTime.substring(0,2) );
		newTime.append( ":" );
		newTime.append( sourceTime.substring(2,4) );
	}
	if( sourceTime.length() == 6 )
	{
		newTime.append( sourceTime.substring(0,2) );
		newTime.append( ":" );
		newTime.append( sourceTime.substring(2,4) );
		newTime.append( ":" );
		newTime.append( sourceTime.substring(4,6) );
	}

    return newTime.toString();
  }

  /**
   * string 에 지정된 위치마다 원하는 문자를 넣는다.
   *
   * @param src 변환하고자 하는 문자열
   * @param len appendChar가 들어갈 반복적 길이
   * @param appendChar 넣고자 하는 문자
   * @return 변화된 문자열
   * @exception Execption error occurs
   */
  private static String toAnyFormat(String src, int len, char appendChar)
      {

    char[] arySrc = src.toCharArray();
    int lenSrc = arySrc.length;
    int lenTgt = lenSrc + ((lenSrc - 1) / len);
    char[] aryTgt = new char[lenTgt];

    String target = null;
    try {
      for(int i=lenSrc-1, j=lenTgt-1, k=0; i >= 0; i--, j--, k++) {
        if( k != 0 && (k % len) == 0 ) aryTgt[j--] = appendChar;
        aryTgt[j] = arySrc[i];
      }
      target = new String(aryTgt);
    }
    catch( Exception e ) {      
    }

    return target;
  }

	/**
	 * 구분자에 의해 분리된 string을 분리하여 string array 로 만든다.
	 * split와 다른점은 ',,'이렇게 넘어온다고 한다면 3개의 array로 만들어준다.
	 * @param str 구분자에 의해 분리된 string
	 * @param delim 구분자
	 * @return 분리된 string array
	 * @exception Execption error occurs
	 */
	public static String[] splitPermitSpace(String str, String delim)   {
	  int strStart = 0;
	  int strEnd = 0;
	  int count = 1;

	  for(int j=0;j<str.length();j++){
		  strEnd = str.indexOf(delim, strStart);
		  if(strEnd == -1)
			  break;
		  strStart = strEnd + 1;
		  count++;
	  }

	  String[] strArr = new String[count];

	  strStart = 0;
	  strEnd = 0;

	  for(int j=0;j<count;j++){
		  strEnd = str.indexOf(delim, strStart);
		  if(strEnd == 0 || strStart == strEnd)
			  strArr[j] = "";
		  else if(strEnd == -1){
			  strArr[j] = str.substring(strStart);
			  break;
		  }else
			  strArr[j] = str.substring(strStart,strEnd);
		  strStart = strEnd + 1;
	  }
    return strArr;
	}


	/**
	 * string array를 구분자로 구분하여 string으로 만든다.
	 *
	 * @param strArr string array
	 * @param delim 구분자
	 * @return 구분자에 의해 분리된 string
	 * @exception Execption error occurs
	 */
  public static String arrayToString(String[] strArr, String delim)   {
    String str = "" ;
    try {
      for ( int i = 0 ; i < strArr.length ; i++ ) {
        if ( i == 0 ) {
          str += strArr[i] ;
        }
        else {
          str += delim + strArr[i] ;
        }
       }
    }
    catch( NoSuchElementException nsee) {
      
    }
    return str;
  }


  /**
   * ','를 기준으로 문자열을 분리하여 Vector에 넣는다.
   *
   * @param str ','문자열
   * @return Vector
   * @exception Execption error occurs
   * by zerog
   */
  public static Vector getCommaParam (String sStr)  
  {
	Vector vBuf = new Vector();

	try {
		if (sStr == null || sStr.length() <= 0)
			return vBuf;

		String sBuf = new String();
		for (int i=0; i<sStr.length(); i++) {
			if ( (""+sStr.charAt(i)).equals(",") ) {
				sBuf = sBuf.trim();
				vBuf.addElement(sBuf);
				sBuf = new String();
			} else {
				sBuf = sBuf + ("" + sStr.charAt(i));
				if ( i == sStr.length() -1) {
					sBuf = sBuf.trim();
					vBuf.addElement(sBuf);
				}
			}
		}

	} catch(Exception e) {
		
	}
	return vBuf;
  }

  /**
   * ';'를 기준으로 문자열을 분리하여 Vector에 넣는다.
   *
   * @param str ';'문자열
   * @return Vector
   * @exception Execption error occurs
   * by zerog
   */
  public static Vector getColonParam (String sStr)  
  {
        Vector vBuf = new Vector();

        try {
                if (sStr == null || sStr.length() <= 0)
                        return vBuf;

                String sBuf = new String();
                for (int i=0; i<sStr.length(); i++) {
                        if ( (""+sStr.charAt(i)).equals(";") ) {
                                sBuf = sBuf.trim();
                                vBuf.addElement(sBuf);
                                sBuf = new String();
                        } else {
                                sBuf = sBuf + ("" + sStr.charAt(i));
                                if ( i == sStr.length() -1) {
                                        sBuf = sBuf.trim();
                                        vBuf.addElement(sBuf);
                                }
                        }
                }

        } catch(Exception e) {
                
        }
        return vBuf;
  }


  /**
   * 특정 문자를 기준으로 문자열을 분리하여 Vector에 넣는다.
   *
   * @param str ';'문자열
   * @return Vector
   * @exception Execption error occurs
   * by zerog
   */
  public static Vector getSepParam (String sStr, String sSep)  
  {
        Vector vBuf = new Vector();

        try {
                if (sStr == null || sStr.length() <= 0)
                        return vBuf;

                String sBuf = new String();
                for (int i=0; i<sStr.length(); i++) {
                        if ( (""+sStr.charAt(i)).equals(sSep) ) {
                                sBuf = sBuf.trim();
                                vBuf.addElement(sBuf);
                                sBuf = new String();
                        } else {
                                sBuf = sBuf + ("" + sStr.charAt(i));
                                if ( i == sStr.length() -1) {
                                        sBuf = sBuf.trim();
                                        vBuf.addElement(sBuf);
                                }
                        }
                }

        } catch(Exception e) {
               
        }
        return vBuf;
  }

	
  /**
   * 숫자형 String에서 ','를 제거한다.
   *
   * @param str 숫자형 문자열
   * @return ','가 제거된 문자열
   * @exception Execption error occurs
   * by zerog
   */
  public static String delComma (String sStr)  
  {
	if (sStr == null || sStr.length() <= 0)
		return "";

	String sBuf = new String();
        try {

                for (int i=0; i<sStr.length(); i++) {
                        if ( (""+sStr.charAt(i)).equals(",") ) {

                        } else {
                                sBuf = sBuf + ("" + sStr.charAt(i));
                        }
                }

        } catch(Exception e) {
               
        }

	return sBuf;
  } 


  /**
   *  문자 앞으로 숫자만큼의 길이가 되도록 '0'을 넣는다.
   *
   * @param str 문자열
   * @return  문자열
   * @exception UtilException error occurs
   */
  public static String instZero (String temp, int len)
  {
	if (temp == null) 
		return "";

	if (temp.trim().length() >= len)
		return temp.trim();

	int iStrLen = temp.trim().length(); 
	int iInstLen = len - iStrLen; 

	String sRet = "";
	for (int i=0; i<iInstLen; i++) {
		sRet = sRet + "0";
	}

	sRet = sRet + temp.trim();
	return sRet;
  }


  /**
   * 문자와 숫자를 가지고 문자뒤로 숫자만큼의 길이가 되도록 공백을 넣는다.
   *
   * @param str 문자열
   * @return 공백이 들어간 문자열
   * @exception Execption error occurs
   * by jamesk
   */
  public static String instBlank (String temp, int len)  
  {
	  StringBuffer strBuf = new StringBuffer();
	  int oldLen = len;
	  temp = temp.trim();

	  byte[] b = temp.getBytes();	  

	  int currlen = b.length;
	  int realLen = oldLen - currlen;
	  strBuf.append(temp.trim());
	  for(int i = 0; i < realLen; i++){
		  strBuf.append(" ");
	  }

	return strBuf.toString();
  } 

  /**
   * 영문, 한글 혼용 문자열을 일정한 길이에서 잘라주는 함수
   *
   * @param str		문자열
   * @param limit	자르고자 하는 길이
   * @return		원하는 길이대로 잘라진 문자열
   * @exception Execption error occurs
   * by jamesk
   */
  public static String cutStrLen (String str, int limit)  
  {
	int len = str.length();

	if (str == null || str.getBytes().length < limit ) return str ;

    int cnt=0, index=0;

    while (index < len && cnt < limit)
    {
        if (str.charAt(index++) < 256) // 1바이트 문자라면...
            cnt++;     // 길이 1 증가
        else // 2바이트 문자라면...
			cnt += 2;  // 길이 2 증가
    }

    if (index < len)
        str = str.substring(0, index);

	return str ; 
  } 

  /**
   * 영문, 한글 혼용 문자열을 일정한 길이에서 잘라주는 함수
   * 만일 str이 limit보다 길이가 짧을 경우 fill만큼 공백으로 채워서 리턴한다.
   *
   * @param str         문자열
   * @param limit       자르고자 하는 길이
   * @return            원하는 길이대로 잘라진 문자열
   * @exception Execption error occurs
   * by jamesk
   */
  public static String cutInsStrLen (String str, int limit)  
  {
        int len = str.length();

	if (str == null)
		return "";

	if (str.getBytes().length < limit) 
		return (instBlank(str, limit));


    int cnt=0, index=0;

    while (index < len && cnt < limit)
    {
        if (str.charAt(index++) < 256) // 1바이트 문자라면...
            cnt++;     // 길이 1 증가
        else // 2바이트 문자라면...
                        cnt += 2;  // 길이 2 증가
    }

    if (index < len)
        str = str.substring(0, index);

        return str ;
  }

  /**
   * 두개의 일자를 받아서 서로 다른경우 *일자로 return 한다.
   *
   * @param beforeStr    입력일자
   * @param cfrmStr      결정일자
   * @return             결정일자
   * @exception Execption error occurs
   * by jamesk
   */
  public static String compDate (String beforeStr, String cfrmStr)  
  {
	String str = "" ; 

	if (beforeStr.trim().equals(cfrmStr)){
		str = StrUtil.toDateFormat(cfrmStr)  ; 
	}
	else {
		str =  "<font color ='red'>*</font>"+StrUtil.toDateFormat(cfrmStr) ; 
	}
	return str ; 
  }

  /**
   * 문자열이 Null이거나 공백인 경우 "0"을 리턴한다.
   *
   * @param str 문자열
   * @return 문자열
   * @exception Execption error occurs
   */
  public static String null2Zero(String str){
  	String rStr = str;
  	try{
    	if(str == null || str.equals("")) rStr = "0";
  	}catch(Exception e){
        log.error("Exception e:"+e.toString());
    }
  	return rStr;
  }

	/**
	 * KSC5601문자열을 유니코드로 반환한다.
	 *
	 * @param src 유니코드로 변환할 KSC5601문자가 섞인 문자열
	 * @return 유니코드로 변경된 문자열
	 * @since 1.0
	 */
    public static String to8859(String src)
    {
        if(src == null) return "";

        try {
            String ret = new String(src.getBytes("KSC5601"), "8859_1");
            return ret;
        }catch(UnsupportedEncodingException e) {
            return src;
        }catch(Exception e) {
            return src;
        }
    }


	/**
	 * 유니코드를 KSC5601문자열로 반환한다.
	 *
	 * @param src KSC5601로 변환할 유니코드가 섞인 문자열
	 * @return KSC5601로 변경된 문자열
	 * @since 1.0
	 */
	public static String toHangul(String src)
    {
        if(src == null) return "";

        try {
            String ret = new String(src.getBytes("8859_1"), "KSC5601");
            return ret;
        }catch(UnsupportedEncodingException e) {
            return src;
        }catch(Exception e) {
            return src;
        }
    }




	/**
	 * 유니코드를 KSC5601문자열로 반환한다.
	 *
	 * @param src KSC5601로 변환할 유니코드가 섞인 문자열
	 * @return KSC5601로 변경된 문자열
	 * @since 1.0
	 */
	public static String toReqHangul(String src)
    {
        if(src == null) return "";

        try {
            String ret = new String(src.getBytes("8859_1"), "EUC-KR");
            return ret;
        }catch(UnsupportedEncodingException e) {
            return src;
        }catch(Exception e) {
            return src;
        }
    }


	/**
	 * off set에 해당하는 현재 미래 과거 날짜를 구한다.
	 *
	 * @param 과거 또느 미래(0:당일, 1:전월 당일, 2: 전월 1일, 3:익월 당일, 4: 익월 말일, 5: 6개월 전당일, 6:6개월전월 1일)
	 * @return 날짜(미래, 과거)
	 * @since 1.0
	 */
	public static String getPeriFormatDate(String src)
    {
		String retStr = "";
		try{
			// 일자를 입력 안하면 최근 1개월전부터 조회한다.
			DateFormat Tdf = new SimpleDateFormat("yyyyMMdd");
			Calendar Tcalender = Calendar.getInstance();

			String Tcurrent = Tdf.format(Tcalender.getTime());
			
			if(src.equals("1")){//전월 당일
				Tcalender.add(Calendar.MONTH, -1);
				String Tpast = Tdf.format(Tcalender.getTime());

				retStr = StrUtil.toDateFormat(Tpast);

			}else if(src.equals("2")){//전월1일
				Tcalender.add(Calendar.MONTH, -1);
				String Tpast = Tdf.format(Tcalender.getTime());

				retStr = StrUtil.toDateFormat(Tpast.substring(0, 6) + "01");

			}else if(src.equals("3")){//익월당일
				Tcalender.add(Calendar.MONTH, +1);
				String Tpast = Tdf.format(Tcalender.getTime());

				retStr = StrUtil.toDateFormat(Tpast);
				
			}else if(src.equals("4")){//익월말일
				Tcalender.add(Calendar.MONTH, +1);
				String tFuture = Tdf.format(Tcalender.getTime());

				String future = tFuture.substring(0,6)+Integer.toString(DateUtil.getMonthLastDay(tFuture.substring(0,6)));

				retStr = StrUtil.toDateFormat(future);
			}else if(src.equals("5")){//6개월 전 당일
				Tcalender.add(Calendar.MONTH, -6);

				String Tpast = Tdf.format(Tcalender.getTime());

				retStr = StrUtil.toDateFormat(Tpast);
			}else if(src.equals("6")){//6개월전월 1일
				Tcalender.add(Calendar.MONTH, -6);
				String Tpast = Tdf.format(Tcalender.getTime());

				retStr = StrUtil.toDateFormat(Tpast.substring(0, 6) + "01");

			}else{//현재일자	

				retStr = StrUtil.toDateFormat(Tcurrent);
			}
			
		
		}catch(Exception e){
			log.error("####################["+e+"]");
		}
		return retStr;
		
    }
	

    /**
     * 문자열이 한글로만 되어 있는지 체크
     * <br><b>Warning : Byte처리로 되어 있다.</b>
     * @param sSrc 소스문자열
     * @return 
     */
    public static boolean isHangul(String sSrc)
    {
        int i;
 
        if( sSrc == null ) return false;
 
        byte[] baSrc = sSrc.getBytes();
 
        int iSrcLength = baSrc.length;
 
        for( i = 0 ; i < iSrcLength; i++ )
        {
            // 한글일 경우
            if( !((baSrc[i] & 0x80) == 0x80) )
            {
				return false;
            }
		}
		
		return true;
 
    } // End : String isHangul()


    /**
     * 문자열이 영문으로만 되어 있는지 체크
     * <br><b> </b>
     * @param sSrc 소스문자열
     * @return
     */
    public static boolean isEng(String sSrc)
    {
        int i;
 
        if( sSrc == null ) return false;
 
 
		sSrc = sSrc.toUpperCase();
        int iSrcLength = sSrc.length();
 
        for( i = 0; i < iSrcLength; i++ )
        {
			if ( (int)sSrc.charAt(i) < 65 || (int)sSrc.charAt(i) > 90) {
				return false;
			}
        }
 
        return true;
 
    } // End : String isEng()

    /**
     * 주민번호 유효성 체크
     * <br><b> </b>
     * @param sSrc 주민번호
     * @return
     */
    public static boolean isRbno(String sSrc)
	{

		if (isDigit(sSrc) == false) return false;

		int[]  nIdNumCheck = {2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5};
		int nAmount = 0;
		char ch;
	 
		for( int i = 0; i < 12; i ++ )
		{
			ch = sSrc.charAt(i);
			if ( ch < '0' || ch > '9' ) return false;
			nAmount += ( nIdNumCheck[i] * ( ch - '0' ));
		}
	 
		nAmount %= 11;
		nAmount = 11 - nAmount;
	 
		if( nAmount == 11 ) nAmount = 1;
		if( nAmount == 10 ) nAmount = 0;
	 
		if( nAmount == ( sSrc.charAt(12) - '0' )) return true;
	 
		return false;
	 
	} // End : String isEng()


    /**
     * 이메일 유효성 체크
     * <br><b>Warning : </b>
     * @param sSrc 소스문자열
     * @return
     */
    public static boolean isEmail(String sSrc)
    {
 
        if( sSrc == null ) return false;

		int comIndex = sSrc.indexOf(".");
		int atIndex  = sSrc.indexOf("@");

		if (atIndex < 2 || comIndex < 3) return false;

		if (atIndex < comIndex) return false;

 
        return true;
 
    } // End : String isEmail()


	/**
	* 특수문자가 들어오면 지워버린다.
	* @param String 
	* @return 파일에서 읽은 String
	*/
	public static String chkSpecialChar(String strParam) {

		strParam = StrUtil.replaceWord(strParam,"(","");
		strParam = StrUtil.replaceWord(strParam,"<","");
		strParam = StrUtil.replaceWord(strParam,">","");
		strParam = StrUtil.replaceWord(strParam,"'","");
		strParam = StrUtil.replaceWord(strParam,"\"","");
		strParam = StrUtil.replaceWord(strParam,")","");
		strParam = StrUtil.replaceWord(strParam,"+","");

		return strParam;
		
    }//end of method getReadLine


	/**
	 * 문자열이 null이거나 "" 이면 지정문자열을 리턴, 그렇지 않으면 공백을 없앤 후 리턴한다.
     *
	 * @param sOrg : 소스문자열
	 * @param initValue : sOrg가 널이거나 빈 문자열일 경우 초기값으로 사용할 문자열
	 * @return 문자열 또는 소스문자열에서 공백을 없앤 문자열
	 */
	public static String nvl(String sOrg, String initValue)
	{
		sOrg = isNull(sOrg);

		if ( initValue != null && "".equals(sOrg))		return initValue;
		else											return sOrg;
	}

	/**
	 * 문자열이 null이거나 "" 이면 지정문자열을 리턴, 그렇지 않으면 공백을 없앤 후 리턴한다.
     *
	 * @param sOrg : 소스문자열
	 * @param initValue : sOrg가 널이거나 빈 문자열일 경우 초기값으로 사용할 문자열
	 * @return 문자열 또는 소스문자열에서 공백을 없앤 문자열
	 */
	public static String nvl(Object obj, String initValue)
	{
		String ret = "";
		if( obj != null && obj instanceof String ) ret = (String)obj;
		return "".equals(ret) ? initValue : ret;
	}
	
	/**
	 * 입력 문자열에 있는 문자열이 flash에 전문 전송 하는 과정에서 예약어를 사용하여야 하는 경우에 대하여, 예약어 덮어쓰기 한다.
     *
	 * @param sOrg : 소스문자열
	 */
	public static String cvtToTags(String sOrg)
	{
		String str = sOrg;
		// enter tag
		String tag = "";
		
		// enter tag
		tag = "#enter#";
		str = StrUtil.replaceWord(str,"\r\r",tag);
		str = StrUtil.replaceWord(str,"\r\n",tag);
		str = StrUtil.replaceWord(str,"\r",tag);
		str = StrUtil.replaceWord(str,"\n",tag);
		
		return str;
	}

	/**
	 * XML을 작성하는중에 HTML테그가 발견될 경우 Display 가능한 테그로 변환한다.
     *
	 * @param sOrg : 소스문자열
	 */
	public static String cvtToTxtTags(String sOrg)
	{
		String str = sOrg;
		// enter tag
		String tag = "";
		
		// enter tag
		tag = "#enter#";
		str = StrUtil.replaceWord(str,"\r\r",tag);
		str = StrUtil.replaceWord(str,"\r\n",tag);
		str = StrUtil.replaceWord(str,"\r",tag);
		str = StrUtil.replaceWord(str,"\n",tag);
		str = StrUtil.replaceWord(str,"<","&lt;");
		str = StrUtil.replaceWord(str,">","&gt;");
		//str = StrUtil.replaceWord(str,"\"","*double-quotation;");
		//str = StrUtil.replaceWord(str,"\'","*single-quotation;");
		//str = StrUtil.replaceWord(str,"=","*equal;");
		//str = StrUtil.replaceWord(str,"#","*sharp;");
		str = StrUtil.replaceWord(str,"&nbsp;","#nbsp#");
		
		
		return str;
	}

	public static byte[] appendByte(byte[] a, byte[] b) throws Exception {
		
		if(b == null) return a;
		
		byte ret[] = new byte[a.length + b.length];

		System.arraycopy(a, 0, ret, 0, a.length);
		System.arraycopy(b, 0, ret, a.length, b.length);

		return ret;
	}

	public static byte[] appendByte(byte type, byte[] b) throws Exception {
		byte a[] = new byte[1];
		a[0] = type;

		if(a == null || b == null) return null;
		
		byte ret[] = new byte[a.length + b.length];

		System.arraycopy(a, 0, ret, 0, a.length);
		System.arraycopy(b, 0, ret, a.length, b.length);

		return ret;
	}
	
	public static byte[] subByte(byte[] b, int offset, int len) throws Exception {
		byte ret[] = new byte[len];
		
		System.arraycopy(b, offset, ret, 0, len);
		
		return ret;
	}

	public static byte[] instBlank2(Object o, int len)  
	{
		if(o == null) return new byte[0];
		
		String temp = o.toString();
	  
		StringBuffer strBuf = new StringBuffer();
		int oldLen = len;
		temp = temp.trim();

		byte[] b = temp.getBytes();	  

		int currlen = b.length;
		int realLen = oldLen - currlen;
		strBuf.append(temp.trim());
	  	for(int i = 0; i < realLen; i++){
	  		strBuf.append(" ");
	  	}

	  	return strBuf.toString().getBytes();
	} 
	
	public static String deciToHexaDeci(int i) {
		
		char[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8',
				'9', 'a', 'b', 'c', 'd', 'e', 'f' };
		
		char[] buf = new char[8]; // int가 32bit이므로 16진수로는 8자리를 넘지 못합니다.(2진수
									// 4자리 = 16진수 1자리)

		int charPos = 8; // buf를 뒤에서 부터 채우기 위해 사용하는 변수. 0부터가 아니라 7부터 채우기 위함
		int mask = 15; // 2진수로 1111

		do {
			buf[--charPos] = digits[i & mask]; // i와 1111을 비트연산자 &로 연산한다. 이렇게
												// 하면 16진수 한자리를 얻을 수 있다.
			i >>>= 4; // i를 2의 4제곱으로 나눕니다.
		} while (i != 0);

		return new String(buf, charPos, (8 - charPos)); // buf중에서 채워진 부분만 빼서
														// String으로 만들어 반환합니다.
	} 

	public static int CompareVer(String a, String b)
	{
		String a1 = StrUtil.replace(a, ".", "");
		String b1 = StrUtil.replace(b, ".", "");

		if(Integer.parseInt(a1) > Integer.parseInt(b1)) {
				return 1;
		}

		if(Integer.parseInt(a1) < Integer.parseInt(b1)) {
				return -1;
		}

		return 0;
	}
	
	

	
	public static void setParameter(Map<String, String> request, Object prm)
	{
	    
	    Method[] methods =	prm.getClass().getMethods();
	    
		for (Object key : request.keySet())
	    {
	        String name = key.toString();
	        for(int i=0; i<methods.length; i++)
	        {
	        	
	        	
	            if(methods[i].getName().toLowerCase().equals("set"+name.toLowerCase()))
	            {
	                String type = methods[i].getGenericParameterTypes()[0].toString().replace("class ","");
	                try
	                {
	                    // Java 1.7 이상에서는 switch 문에서 문자열을 지원하므로
	                    // switch 변경 가능 합니다.
	                    if("int".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), int.class);
	                        methods[i].invoke(prm, Integer.parseInt(nvl2((String) request.get(name),"0")));
	                    }
	                    else if("long".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), long.class);
	                        methods[i].invoke(prm, Long.parseLong(nvl2((String) request.get(name),"0")));
	                    }
	                    else if("double".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), double.class);
	                        methods[i].invoke(prm, Double.parseDouble(nvl2((String) request.get(name),"0")));
	                    }
	                    else if("float".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), float.class);
	                        methods[i].invoke(prm, Float.parseFloat(nvl2((String) request.get(name),"0")));
	                    }
	                    else if("boolean".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), boolean.class);
	                        methods[i].invoke(prm, Boolean.valueOf(nvl((String) request.get(name),"false")));
	                    }
	                    else if("java.lang.Integer".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), new Integer("0").getClass());
	                        methods[i].invoke(prm, new Integer(nvl((String) request.get(name),"0")));
	                    }
	                    else if("java.lang.Long".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), new Long("0").getClass());
	                        methods[i].invoke(prm, new Long(nvl((String) request.get(name),"0")));
	                    }
	                    else if("java.lang.Double".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), new Double("0").getClass());
	                        methods[i].invoke(prm, new Double(nvl((String) request.get(name),"0")));
	                    }
	                    /*
	                    else if("java.math.BigInteger".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), new BigInteger(DateUtil.getToday()).getClass());
	                        methods[i].invoke(prm, new BigInteger((String) request.get(name)));
	                    }
	                    */
	                    else if("java.lang.StringBuffer".equals(type))
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), new StringBuffer().getClass());
	                        methods[i].invoke(prm, new StringBuffer((String) request.get(name)));
	                    }
	                    else
	                    {
	                        methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName(), new String().getClass());
	                        methods[i].invoke(prm, (String) request.get(name));
	                    }
	                }
	                catch (Exception e)
	                {
	                	log.error("setParameter methods[i].getName() err=>["  + methods[i].getName() + "]");
	                    e.printStackTrace();
	                }
	            }
	        }
	    }
	}


	private static String nvl2(String string, String string2) {

		if(string == null || string.length() == 0)
			return "0";
		
		return string;
	}

	public static String[] setArray(Map<String, String> request, Object prm, int certLen, String getName)
	{
	    
	    String data[] =  new String[certLen];

        for(int i=0; i<certLen; i++)
        {
                log.info("getName" + getName +"=[" + request.get(getName+i)+ "]");
                data[i] = request.get(getName+i);

        }
	        
	    return data;

	}
	public static int[] setArray1(Map<String, String> request, Object prm, int certLen, String getName)
	{
	    
	    int data[] =  new int[certLen];

        for(int i=0; i<certLen; i++)
        {
                log.info("getName" + getName +"=[" + request.get(getName+i)+ "]");
                data[i] = Integer.parseInt(request.get(getName+i));

        }
	        
	    return data;

	}
	
	 /**
	  * 문자열이 url형태일 경우 name=value 방식으로 hashtable에 저장한다.
	  * 
	  * @param url : 소스문자열(RESPCODE=00&RESPMSG=ok&SVC_AUTH=1)
	  * @return hashtable
	  */
	 public static Hashtable parseURL2Hash(String url)
	 {
	  Hashtable hash = new Hashtable();
	   
	  for(int i=0;i<10000;i++)
	  {
	   String namevalue = getTokenString(url, "&", i);
	   if(namevalue.length()==0) {
	    break;
	   }
	   
	   if(namevalue.indexOf("=") <= 0) continue;
	       
	   String tmp1 = getTokenString(namevalue, "=", 0);
	   if(tmp1.length() == 0)
	    continue;
	   
	   String tmp2 = getTokenString(namevalue, "=", 1);
	   
	   hash.put(tmp1, tmp2);
	   
	  }
	  
	  return hash;  
	 }
	 
	public static void setVO2HashMap(Object prm, Map<String, Object> map)
	{  
	    Method[] methods =	prm.getClass().getDeclaredMethods();
	    
        for(int i=0; i<methods.length; i++)
        {

            if(methods[i].getName().startsWith("get"))
            {
            	//System.out.println("===="  + methods[i].getName());
                try
                {   	        	
                    methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName());
                    Object o = methods[i].invoke(prm);
                    //System.out.println(String.valueOf(o));
                    
                    map.put(methods[i].getName().substring(3).toLowerCase(), String.valueOf(o));
                }
                catch (Exception e)
                {
                	System.out.println("setParameter methods[i].getName() err=>["  + methods[i].getName() + "]");
                    e.printStackTrace();
                }
            }
        }

	}


	public static void setVO2HashMapList(Object prm, Map<String, Object> map) {
	    Method[] methods =	prm.getClass().getDeclaredMethods();
	    
        for(int i=0; i<methods.length; i++)
        {

            if(methods[i].getName().startsWith("get"))
            {
            	//System.out.println("===="  + methods[i].getName());
                try
                {   	        	
                    methods[i] = prm.getClass().getDeclaredMethod(methods[i].getName());
                    Object o = methods[i].invoke(prm);
                   // System.out.println(String.valueOf(o));
                    
                    map.put(methods[i].getName().substring(3).toLowerCase(), String.valueOf(o));
                }
                catch (Exception e)
                {
                	System.out.println("setParameter methods[i].getName() err=>["  + methods[i].getName() + "]");
                    e.printStackTrace();
                }
            }
        }
	}
	


	 /**
	  * 정규식과 String.replaceAll()메소드를 이용해  주석 제거
	  * @param str : 소스문자열
	  * @return str:주석이 제거된 문자열
	  */
	public static String  removeComment(String str)
	{
		// str = "/*-- 주석1 --*/ /**-- 주석2 --**/  주석아님1 /** 주석3 **/  /* \n 주석 \n 주석 */  주석아님2";

		//	str = str.replaceAll("/\\*(?:.|[\\n\\r])*?\\*/", "");
	
		//	str = str.replaceAll("--.*\n", "\n");
		//	str = str.replaceAll("--.*\r", "\r");
		//	str = str.replaceAll("--.*$", "");
			
		//	str = str.replaceAll("//.*\n", "\n");
		//	str = str.replaceAll("//.*\r", "\r");
		//	str = str.replaceAll("//.*$", "");
		
		str = str.replaceAll("(?://.*\n{0,1})|(?:/\\*(?:.|\\s)*?\\*/\n{0,1})", "");
		return str;
	}

	 /**
	  * 해당클래스의 필드 타입
	  * @param o : class
	  * @param field : 필드문자열
	  * @return class:해당필드getType
	  */
	public static Class getFieldType(Object o, String field)
	{
		try {
			return o.getClass().getField(field).getType();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}


	 /**
	  * 해쉬리스트에서 정의된 Name리스트를 제외하고 모두 삭제한다.
	  * @param aServiceDtlList : class
	  * @param field : 필드문자열
	  * @return class:  Name리스트
	  */
	public static void defListHData(
			ArrayList<HashMap<String, Object>> aServiceDtlList, String[] field) {
		// TODO Auto-generated method stub
		for(int i=0;i<aServiceDtlList.size();i++) {
			HashMap<String, Object> hash = aServiceDtlList.get(i);
			HashMap<String, Object> new_hash = new HashMap();
			//System.out.println("0=" + hash);
			
			for(int f=0;f<field.length;f++) {
				new_hash.put(field[f], hash.get(field[f]));
			}
			aServiceDtlList.set(i, new_hash);
		}
	}


	/**
	* len자리 랜덤생성
	*
	* @param len 길이
	* @return 발생된 영숫자혼합 문자열(대문자)
	* @exception Exception error occurs
	*/
	public static String getGetRandomCode(int len)
	{
		String tmp = UUID.randomUUID().toString().replace("-", "");
		tmp = tmp.toUpperCase();
	
		String s = "";
		for(int i=0;i<tmp.length();i++)
		{
			Random random = new Random();
	        int num = random.nextInt(tmp.length()); // 0~n사이값중 하나얻기
		
	        //System.out.println("num=[" + num + "]");
	        if(num <= 0) continue;
	        if(num >= tmp.length()) continue;
	        
	        if(0 <= num && num < tmp.length()  )
	        {
		        s += tmp.substring(num, num+1);
		        
		        if(s.length() >= len) break;
		        }
	    }
		
		//System.out.println("[" + s + "]");
		
		return s;
	}
	
} // End Of File
