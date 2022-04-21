package com.asia3d.util;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.UUID;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class SecureUtil {

	public SecureUtil() {
		// TODO Auto-generated constructor stub
	}
	
	public SecureUtil(byte[] iv, byte[] mk) {
		// TODO Auto-generated constructor stub
		this.iv = iv;
		this.mk = mk;
	}

	private byte[] iv;
	private byte[] mk;
	
	
	public byte[] encrypt(byte[] data) throws Exception
	{
		SeedCBC s = new SeedCBC();
		String retMsg = s.LoadConfig(iv, mk);

		return s.Encryption(data);
	}
	
	public byte[] decrypt(byte[] data) throws Exception
	{
		SeedCBC s = new SeedCBC();
		String retMsg = s.LoadConfig(iv, mk);

		return s.Decryption(data);
	}
	
	public String base64Encoder(byte[] data) throws Exception
	{
		BASE64Encoder base64Encoder = new BASE64Encoder();
		return base64Encoder.encode(data);
	}

	public byte[] base64Decoder(String data) throws Exception
	{
		BASE64Decoder base64Decoder = new BASE64Decoder();
		return  base64Decoder.decodeBuffer(data);
	}
		
	public String encryptAndBase64Encoder(byte[] data) throws Exception
	{
		SeedCBC s = new SeedCBC();
		String retMsg = s.LoadConfig(iv, mk);

		byte[] bCipherText = s.Encryption(data);
		BASE64Encoder base64Encoder = new BASE64Encoder();
		return base64Encoder.encode(bCipherText);
	}
	
	public byte[] Base64DecoderAndDecrypt(String data) throws Exception
	{
		BASE64Decoder base64Decoder = new BASE64Decoder();
		byte[] bCipherText =  base64Decoder.decodeBuffer(data);
		
		SeedCBC s = new SeedCBC();
		String retMsg = s.LoadConfig(iv, mk);
		return s.Decryption(bCipherText);
	}
	
	public byte[] convStr2ByteLen(String ivmk) throws Exception
	{
		int iByteLen = ivmk.length() / 2;
		String sHex = null;
		byte bUUID[] = new byte[iByteLen];
		for(int idx=0;idx<iByteLen;idx++) {
			sHex = ivmk.substring(idx*2,idx*2+2);
			bUUID[idx] = getHex(sHex);	
			//System.out.println("bUUID["+ sHex + "][" + idx + "]=" + bUUID[idx]);
			//System.out.format ("%02X\n", bUUID[idx]);
		}	
		return bUUID;
	}
	
	public byte[] convIVMK2ByteLen(String ivmk) throws Exception
	{
		int iByteLen = ivmk.length() / 2;
		String sHex = null;
		byte bUUID[] = new byte[iByteLen];
		for(int idx=0;idx<iByteLen;idx++) {
			sHex = ivmk.substring(idx*2,idx*2+2);
			bUUID[idx] = getHex(sHex);	
			//System.out.println("bUUID["+ sHex + "][" + idx + "]=" + bUUID[idx]);
			//System.out.format ("%02X\n", bUUID[idx]);
		}	
		return bUUID;
	}
	
	public byte[] convIVMK2Byte(String ivmk) throws Exception
	{
		String sHex = null;
		byte bUUID[] = new byte[16];
		for(int idx=0;idx<16;idx++) {
			sHex = ivmk.substring(idx*2,idx*2+2);
			bUUID[idx] = getHex(sHex);	
			//System.out.println("bUUID["+ sHex + "][" + idx + "]=" + bUUID[idx]);
			//System.out.format ("%02X\n", bUUID[idx]);
		}	
		return bUUID;
	}
	
	public String create_iv() {
		// 16바이트의 IV 또는 MK 를 random
		String uuid = UUID.randomUUID().toString().replaceAll("-","").toUpperCase();
		System.out.println("create_iv=[" + uuid + "][" + uuid.length() + "]");
		return uuid;
	}
	
	public String create_mk() {
		// 16바이트의 IV 또는 MK 를 random
		String uuid = UUID.randomUUID().toString().replaceAll("-","").toUpperCase();
		System.out.println("create_mk=[" + uuid + "][" + uuid.length() + "]");
		return uuid;
	}
		
	private byte getHex(String str) throws Exception {
		if(str == null || str.length() > 2)
		{
			throw new Exception("getHex input parameter error!!");
		}
		str = str.trim();
		if(str.length() == 0)
			str = "00";
		else if(str.length() == 1)
			str = "0" + str;
		
		str = str.toUpperCase();
		return (byte)(getHexNibble(str.charAt(0)) * 16 + getHexNibble(str.charAt(1)));
	}

	private byte getHexNibble(char c) {
		if(c >= '0' && c<='9')
			return (byte)(c - '0');
		if(c >= 'A' && c<='F')
			return (byte)(c - 'A' + 10);
		return 0;
	}
	
	
	public String printHex(byte abyte0[])
    {
        int i = abyte0.length;
        int j = i / 16;

		StringBuffer buf = new StringBuffer();

        //log.info("01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:   1234567890123456");
        //log.info("================================================   ================");

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

            //log.info(stringbuffer);
            buf.append(stringbuffer+"\n");
        }   
		return buf.toString().trim() +("\n-------------------------------------------------------------------");
    }
	
	public byte[] byte2HexStr(byte abyte0[]) {
		int i = abyte0.length;
		int j = i / 16;

		StringBuffer buf = new StringBuffer();

		for (int k = 0; k <= j; k++) {
			int k1 = Math.min(16, i - k * 16);
			for (int l = 0; l < k1; l++) {
				char c = Character.forDigit(abyte0[k * 16 + l] >> 4 & 15, 16);
				char c2 = Character.forDigit(abyte0[k * 16 + l] & 15, 16);
				buf.append(Character.toUpperCase(c));
				buf.append(Character.toUpperCase(c2));
			}
		}
		return buf.toString().trim().getBytes();
	}
	
	public String printHex2(byte abyte0[])
    {
        int i = abyte0.length;
        int j = i / 16;

		StringBuffer buf = new StringBuffer();

		buf.append("------------------------------------------------\n");

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

            buf.append(stringbuffer+"\n");
        }   
		return buf.toString().trim() +("\n------------------------------------------------");
    }
}
