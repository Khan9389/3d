/*
 * @(#)CommUtil.java	1.0  2007/10/18
 *
 * Copyright 2001 - 2004 Xenomobile, Inc. All rights reserved.
 * This software is the proprietary information of Xenomobile, Inc.
 * This source has license to Xenomobile.
 */

package com.asia3d.util;

import java.io.*;
import java.net.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 *  통신을 위한 Utility.  Packet 송/수신을 위한 클래스. 통신을 위해 SOCKET 을 생성하고 데이타를 주고 받는 메소드를 제공한다.
 *
 * @author  Lee YongSun
 * @version 1.0, 2004/03/15
 * @since   1.0
 */
public class CommUtil {
	static Logger log = LoggerFactory.getLogger(CommUtil.class);
	/**
	 * 데이타를 보내기 위한 소켓을 생성하고 초기화 한다.
	 *
	 * @param SOCKET_IP	생성할 소켓의 IP
	 * @param SOCKET_PORT	생성할 소켓의 PORT
	 * @return 생성된 소켓
	 */
	public static Socket initSndSocket_old(String SOCKET_IP, int SOCKET_PORT) throws Exception
	{

		Socket network_socket	=	null;

		log.info( "[IN initSndSocket]");
		try
		{
			network_socket = new Socket(SOCKET_IP, SOCKET_PORT);
		}
		catch (IOException e)
		{
			log.error( "Error(STM)...could not connect to host <" + e + ">");
			throw e;
		}
		return network_socket;
	}
	
	public static Socket initSndSocket(String SOCKET_IP, int SOCKET_PORT) throws Exception
	{

		Socket network_socket	=	null;
		InetSocketAddress socketaddress = null;

		log.info( "[IN initSndSocket]");

		try
		{
			socketaddress = new InetSocketAddress(SOCKET_IP, SOCKET_PORT);
			
			network_socket = new Socket();
			
				network_socket.connect(socketaddress, 10000);
	
		}
		catch (IOException e)
		{
			log.error( "Error(STM)...could not connect to host <" + e + ">");
			throw e;
		}
		return network_socket;
	}

	/**
	 * 데이타를 받기 위한 소켓을 생성하고 초기화 한다.
	 *
	 * @param SOCKET_PORT	생성할 소켓의 PORT
	 * @param iSec	소켓 타임아웃 시간 (millisecond)
	 * @return 생성된 소켓
	 */
	public static ServerSocket initRcvSocket(int SOCKET_PORT) throws IOException
	{
		log.info( "[IN initRcvSocket]");

		try
		{
			return new ServerSocket(SOCKET_PORT);
		}
		catch (IOException e)
		{
			log.error( "initRcvSocket Unable to start server");
			throw e;
		}
	}

	public static Socket rcvSocketAccept(ServerSocket	network_SOCKET, int iSec) throws IOException
	{
		Socket			socket=null;

		log.info( "[IN rcvSocketAccept]");
	
		try
		{
			socket = network_SOCKET.accept();

			socket.setSoTimeout(iSec);
		}
		catch (IOException e)
		{
			log.error( "initRcvSocket Exception: <" + e + ">");
			throw e;
		}
		return socket;
	}
	
	/**
	 * 소켓을 통하여 데이타를 받는다. 1byte 씩 읽어서 스트링으로 변환하여 반환한다.
	 *
	 * @param is	서버 소켓으로 부터 들어오는 <tt>InputStream</tt>
	 * @param iRcvLen  받아서 처리할 길이
	 * @return  서버 소켓으로부터 받아서 변환한 문자열
	 */

	public	static byte[]	rcvSocket(BufferedInputStream bis, int iRcvLen) throws Exception
	{

		//Log.write("[IN rcvSocket] iRcvLen=[" + iRcvLen + "]");
		
		
		if(iRcvLen == 0)
		{
			return new byte[0];
		}

		byte[] rcvbuf	= new byte[iRcvLen];
		byte[] bTmp		= new byte[1];

		try
		{
			int iPos = 0;
			int iReadByte;
			while(true)
			{
				//Log.write("iPos[" + iPos + "]");
				bis.read(bTmp);
				
				//Log.write(".[" + StrUtil.deciToHexaDeci(bTmp[0]) + "]");
				if(bTmp == null || bTmp.length == 0)
				{
					continue;
				}
				
				//log.info(".[" + StrUtil.deciToHexaDeci(bTmp[0]) + "]");
				
				rcvbuf[iPos] = bTmp[0];
				iPos ++;

				if(iPos >= iRcvLen)
					break;

			}

			//Log.write("[IN rcvSocket] finish..");
			
			
			//Log.writeHex("[IN rcvSocket]",rcvbuf);

			return rcvbuf;

		}
		catch(Exception e1)
		{
			log.error( "Error(rcvSocket)...<" + e1 + ">");
			throw e1;
		}
	}


	public	static byte[]	rcvSocketTp(DataInputStream rcv, int iRcvLen) throws Exception
	{

		if(iRcvLen == 0)
		{
			return new byte[0];
		}

		byte[] rcvbuf	= new byte[iRcvLen];
		byte[] bTmp		= new byte[1];

		try
		{
			int iPos = 0;
			int iReadByte;
			while(true)
			{
				//Log.write("iPos[" + iPos + "]");
				rcv.read(bTmp);
				
				//Log.write(".[" + StrUtil.deciToHexaDeci(bTmp[0]) + "]");
				if(bTmp == null || bTmp.length == 0)
				{
					continue;
				}
				rcvbuf[iPos] = bTmp[0];
				iPos ++;

				if(iPos >= iRcvLen)
					break;

			}


			return rcvbuf;

		}
		catch(Exception e1)
		{
			log.error( "Error(rcvSocket)...<" + e1 + ">");
			throw e1;
		}
	}



	/**
	 * 소켓을 통하여 데이타를 보낸다. 보낼 문자열을 1byte 씩 보낸다.
	 *
	 * @param bos	서버 소켓으로 보내는 <tt>OutputStream</tt>
	 * @param SndBuf  보낼 문자열
	 * @return  Excepption(실패), (성공)
	 */

	public	static void	sndSocket(BufferedOutputStream bos,	byte[] sndbuf) throws Exception
	{
		//log.info( "[IN sndSocket]");

		try
		{
			//byte[] sndbuf	= SndBuf.getBytes();
			//1byte씩 보내는건 어떨까?(lys01)
			for(int i=0;i<sndbuf.length;i++)
			{
				bos.write(sndbuf[i]);
			}
			bos.flush();	
		}
		catch(Exception excpt)
		{
			log.error( "sndSocket Err excpt=[" + excpt + "]");
			throw excpt;
		}
	}
	

	/////////////////////////////////////////////////////////////////////////////////////
	// 여기부턴 바이트 처리에 관련된 메소드
	/////////////////////////////////////////////////////////////////////////////////////

	public static final byte[] short2byte(short s)
	{
		byte dest[] = new byte[2];
		dest[1] = (byte)(s & 0xff);
		dest[0] = (byte)(s >>> 8 & 0xff);
		return dest;
	}

	public static final byte[] int2byte(int i)
	{
		byte dest[] = new byte[4];
		dest[3] = (byte)(i & 0xff);
		dest[2] = (byte)(i >>> 8 & 0xff);
		dest[1] = (byte)(i >>> 16 & 0xff);
		dest[0] = (byte)(i >>> 24 & 0xff);
		return dest;
	}

	public static final byte[] long2byte(long l)
	{
		byte dest[] = new byte[8];
		dest[7] = (byte)(int)(l & 255L);
		dest[6] = (byte)(int)(l >>>  8 & 255L);
		dest[5] = (byte)(int)(l >>> 16 & 255L);
		dest[4] = (byte)(int)(l >>> 24 & 255L);
		dest[3] = (byte)(int)(l >>> 32 & 255L);
		dest[2] = (byte)(int)(l >>> 40 & 255L);
		dest[1] = (byte)(int)(l >>> 48 & 255L);
		dest[0] = (byte)(int)(l >>> 56 & 255L);
		return dest;
	}

	public static final byte getbyte(byte src[], int offset)
	{
		return src[offset];
	}

	public static final byte[] getbytes(byte src[], int offset, int length)
	{
		byte dest[] = new byte[length];
		System.arraycopy(src, offset, dest, 0, length);
		return dest;
	}

	public static final short getshort(byte src[], int offset)
	{
		return (short)((src[offset] & 0xff) << 8 | src[offset + 1] & 0xff);
	}

	public static final int getint(byte src[], int offset)
	{
		return
			(src[offset]     & 0xff) << 24 |
			(src[offset + 1] & 0xff) << 16 |
			(src[offset + 2] & 0xff) <<  8 |
			 src[offset + 3] & 0xff;
	}

	public static final long getlong(byte src[], int offset)
	{
		return
			(long)getint(src, offset) << 32 |
			(long)getint(src, offset + 4) & 0xffffffffL;
	}

	public static final float getfloat(byte src[], int offset)
	{
		return Float.intBitsToFloat(getint(src, offset));
	}

	public static final double getdouble(byte src[], int offset)
	{
		return Double.longBitsToDouble(getlong(src, offset));
	}

	public static final byte[] setbyte(byte dest[], int offset, byte b)
	{
		dest[offset] = b;
		return dest;
	}

	public static final byte[] setbytes(byte dest[], int offset, byte src[])
	{
		System.arraycopy(src, 0, dest, offset, src.length);
		return dest;
	}

	public static final byte[] setshort(byte dest[], int offset, short s)
	{
		dest[offset] = (byte)(s >>> 8 & 0xff);
		dest[offset + 1] = (byte)(s & 0xff);
		return dest;
	}

	public static final byte[] setint(byte dest[], int offset, int i)
	{
		dest[offset] = (byte)(i >>> 24 & 0xff);
		dest[offset + 1] = (byte)(i >>> 16 & 0xff);
		dest[offset + 2] = (byte)(i >>> 8 & 0xff);
		dest[offset + 3] = (byte)(i & 0xff);
		return dest;
	}

	public static final byte[] setlong(byte dest[], int offset, long l)
	{
		setint(dest, offset, (int)(l >>> 32));
		setint(dest, offset + 4, (int)(l & 0xffffffffL));
		return dest;
	}

	public static final byte[] setfloat(byte dest[], int offset, float f)
	{
		return setint(dest, offset, Float.floatToIntBits(f));
	}

	public static final byte[] setdouble(byte dest[], int offset, double d)
	{
		return setlong(dest, offset, Double.doubleToLongBits(d));
	}

	public static final boolean isEquals(byte b[], String s)
	{
		if(b == null || s == null)
			return false;
		int slen = s.length();
		if(b.length != slen)
			return false;
		for(int i = slen; i-- > 0;)
			if(b[i] != s.charAt(i))
				return false;

		return true;
	}

	public static final boolean isEquals(byte a[], byte b[])
	{
		if(a == null || b == null)
			return false;
		if(a.length != b.length)
			return false;
		for(int i = a.length; i-- > 0;)
			if(a[i] != b[i])
				return false;

		return true;
	}

	public static byte[] appendBytes(byte[] m1, byte[] m2)
	{
		if(m1 == null) m1 = new byte[0];
		if(m2 == null) m2 = new byte[0];

		byte[] bRet = new byte[m1.length + m2.length];

		int pos = 0;

		for(int i=0;i < m1.length; i++)
		{
			bRet[pos++] = m1[i];
		}

		for(int i=0;i < m2.length; i++)
		{
			bRet[pos++] = m2[i];
		}

		return bRet;
	}
	
	public static byte[] appendBytes(byte[] m1, String m2)
	{
		if(m2 == null) m2 = new String();
		return appendBytes(m1, m2.getBytes());
	}
	
	public static byte[] appendBytes(byte m1, byte[] m2)
	{
		byte m11[] = {m1};
		return appendBytes(m11, m2);
	}


	/**
     *  <tt>String</tt> 타입의 문자열 뒤에 자리 수 만큼의  Null을 추가한다.<br>
     *  ex) sample : appendZero(10, 3) ==> return 결과 : "010"
	 *	@param	sSrc  <tt>String</tt> type의 문자열
	 *	@param	iSize 자리수
	 *	@return	결과 String 
     */
 	public static byte[] appendNullLen(String sSrc, int iSize)
    {	
 		if(sSrc == null) sSrc = new String();
 		
 		byte sTmp[] = sSrc.getBytes();
 		
 		for(int i=sTmp.length;i<iSize;i++)
 		{	
 			sTmp = appendBytes(sTmp, new byte[]{0x00});
 		}
 		
        return sTmp;
    }
}
