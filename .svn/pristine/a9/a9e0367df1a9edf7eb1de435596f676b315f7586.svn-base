package com.asia3d.util;

import java.io.UnsupportedEncodingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Log {

	public static void writeHex(String s, byte[] info)
	{
		System.out.println("> writeHex(len:" + info.length + "):" + s + "\n" + printHex(info));
	}

	public static String printHex(byte abyte0[])
    {
        int i = abyte0.length;
        int j = i / 16;
		StringBuffer buf = new StringBuffer();
		buf.append("-------------------------------------------------------------------\n");
        buf.append("01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:   1234567890123456\n");
        buf.append("================================================   ================\n");
        for(int k = 0; k <= j; k++)
        {
            StringBuffer stringbuffer = new StringBuffer(83);
            int k1 = Math.min(16, i - k * 16);
            for(int l = 0; l < k1; l++)
            {
                char c = Character.forDigit(abyte0[k * 16 + l] >> 4 & 15, 16);
                char c2 = Character.forDigit(abyte0[k * 16 + l] & 15, 16);
                stringbuffer.append(Character.toUpperCase(c));
                stringbuffer.append(Character.toUpperCase(c2));
                stringbuffer.append(':');
            }
            for(int i1 = 16; i1 >= k1; i1--)
                stringbuffer.append("   ");
            for(int j1 = 0; j1 < k1; j1++)
            {
                char c1 = (char)abyte0[k * 16 + j1];
                if(Character.isISOControl(c1))
                    stringbuffer.append('.');
                else
                    stringbuffer.append((char)abyte0[k * 16 + j1]);
            }
            buf.append(stringbuffer+"\n");
        }     
		return buf.toString().trim() +("\n-------------------------------------------------------------------");
    }

	public static void print(Logger logger, String string) { 

		logger.debug(string);
		/*
		System.out.println(DateUtil.getDateNTimeByForm("yyyy/MM/dd HH:mm:ss") + " " + string );
		*/
		
		/*
		if(System.getProperties().getProperty("os.name").indexOf("Windows") >= 0) {		
			Log.LOG_FILE = PropertyUtil.getResource(PROP_FILE, "LOG_FILE_WIN");
		} else {
			Log.LOG_FILE = PropertyUtil.getResource(PROP_FILE, "LOG_FILE_UNIX");
		}
		*/
	}

	public static void print(Logger logger, Exception e) {
		// TODO Auto-generated method stub
		logger.error("= logger.error =", e);
		
	}

}
