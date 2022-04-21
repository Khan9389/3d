package com.asia3d.util;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.asia3d.web.Ajax3DBankController;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class SendMailThread extends Thread {

	private String PROP_FILE = "/property/3dbank.properties";
	
	/*
	 * 메일 전송 정보
	 */
	String mID 	= null;
	String mPWD 	= null;
	String mHost 	= null; 	//smtp mail server     
	String mFrom 	= null; 	//보내는 주소는 서버 이름과 같아야함.
	
	String mTo,  subject,  text;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SendMailThread.class);
	
	public SendMailThread(String mTo, String subject, String text) {
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		
		this.mID 		= pl.get("MAIL_ID");
		this.mPWD 	= pl.get("MAIL_PWD");
		this.mHost 	= pl.get("MAIL_HOST");
		this.mFrom	= pl.get("MAIL_FROM");
		
		this.mTo = mTo;
		this.subject = subject;
		this.text = text;
		
	}
	
	// javamail lib 이 필요합니다.
	class MyAuthentication extends Authenticator {
		PasswordAuthentication pa;
		public MyAuthentication(){
			pa = new PasswordAuthentication(mID, mPWD);  //ex) ID:cafe24@cafe24.com PASSWD:1234
		}

		public PasswordAuthentication getPasswordAuthentication() {
			return pa;
		}
	}
	
	public void run()
	{

		Log.print(LOGGER, "Start sendMail()...");
		Log.print(LOGGER, "mTo=[" + mTo + "],subject=[" + subject + "]");
		Log.print(LOGGER, "mPWD=[" + mPWD + "]");
		Log.print(LOGGER, "mHost=[" + mHost + "]");
		Log.print(LOGGER, "mFrom=[" + mFrom + "]");
		

		try {
			
			Properties props = new Properties();
			props.put("mail.smtp.host", mHost);
			props.put("mail.smtp.auth","true");
			if(mHost.equals("smtp.gmail.com")) props.put("mail.smtp.starttls.enable","true");

			Authenticator auth = new MyAuthentication();
			Session sess = Session.getInstance(props, auth);

			Log.print(LOGGER, "sess=[" + sess + "]");

			Message msg = new MimeMessage(sess);
			msg.setFrom(new InternetAddress(mFrom));
			InternetAddress[] address = {new InternetAddress(mTo)};
			msg.setRecipients(Message.RecipientType.TO, address);
			msg.setSubject(subject);
			msg.setSentDate(new java.util.Date());
			//msg.setText(text);

			MimeMultipart mp = new MimeMultipart();
			mp.setSubType("related");
			MimeBodyPart mbp1= new MimeBodyPart();
			mbp1.setContent(text,"text/html; charset=EUC-KR");
			mp.addBodyPart(mbp1);
			msg.setContent(mp);

			Transport.send(msg);

			Log.print(LOGGER, "End sendMailThread.run()...[" + mTo + "]로 메일발송 완료됨.");

		} catch (MessagingException mex) {
			mex.printStackTrace();
			Log.print(LOGGER,mex);
		}
    }
	
}
