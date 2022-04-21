package com.asia3d.member.service.impl;

import java.io.File;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.asia3d.util.Log;
import com.asia3d.util.PropertyUtil;
import com.asia3d.web.Ajax3DBankController;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
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
import javax.mail.internet.MimeUtility;


public class SendMemberMail  {

	private String PROP_FILE = "/property/3dbank.properties";
	
	/*
	 * 메일 전송 정보
	 */
	String mID 	= null;
	String mPWD 	= null;
	String mHost 	= null; 	//smtp mail server     
	String mFrom 	= null; 	//보내는 주소는 서버 이름과 같아야함.
	
	String mTo,  subject,  text;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SendMemberMail.class);
	
	public SendMemberMail(String mTo, String subject, String text) {
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
	
	public void run() throws Exception
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
			if(mHost.equals("smtp.gmail.com")) {
				/*
				 * * http://lucetedaniel.tistory.com/202
				    PS. 위의 작업 전 구글 계정 2단계 인증을 등록해야만, 가능하다. 인증 안 받고 해보진 않았다. 
					1. https://myaccount.google.com/
					2. https://accounts.google.com/b/0/SmsAuthConfig?hl=ko 
						> 설정 시작
					3. 재로그인
					4. https://accounts.google.com/b/0/SmsAuthSettings?Setup=1
						> 전화번호 입력 후 코드 전송
						> 인증코드 입력
					5. https://security.google.com/settings/security/apppasswords?pli=1
						> 기기선택과 앱(MAIL) 선택 후 생성
					6. 생성된 비밀번호를 위 소스의 pwd란에 입력한다.
					    > mailPwd = "구글에서 발급받은 16자리";     여기 입력 할 비밀번호.
				 */
				props.put("mail.smtp.starttls.enable","true");
				props.put("mail.smtp.port", "465");
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.debug", "true");
				props.put("mail.smtp.socketFactory.port", "465");
				props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				props.put("mail.smtp.socketFactory.fallback", "false");
			}

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

		} catch (Exception mex) {
			Log.print(LOGGER,mex);
			
			throw mex;// new Exception("Call SendMailSingle error!!");
		}
    }
public void run_file(String filename) throws Exception {
		
		Log.print(LOGGER, "Start sendMail()...");
		Log.print(LOGGER, "mTo=[" + mTo + "],subject=[" + subject + "]");
		Log.print(LOGGER, "mPWD=[" + mPWD + "]");
		Log.print(LOGGER, "mHost=[" + mHost + "]");
		Log.print(LOGGER, "mFrom=[" + mFrom + "]");

		try {
			
			Properties props = new Properties();
			props.put("mail.smtp.host", mHost);
			props.put("mail.smtp.auth","true");
			if(mHost.equals("smtp.gmail.com")) {
				/*
				 * * http://lucetedaniel.tistory.com/202
				    PS. 위의 작업 전 구글 계정 2단계 인증을 등록해야만, 가능하다. 인증 안 받고 해보진 않았다. 
					1. https://myaccount.google.com/
					2. https://accounts.google.com/b/0/SmsAuthConfig?hl=ko 
						> 설정 시작
					3. 재로그인
					4. https://accounts.google.com/b/0/SmsAuthSettings?Setup=1
						> 전화번호 입력 후 코드 전송
						> 인증코드 입력
					5. https://security.google.com/settings/security/apppasswords?pli=1
						> 기기선택과 앱(MAIL) 선택 후 생성
					6. 생성된 비밀번호를 위 소스의 pwd란에 입력한다.
					    > mailPwd = "구글에서 발급받은 16자리";     여기 입력 할 비밀번호.
				 */
				props.put("mail.smtp.starttls.enable","true");
				props.put("mail.smtp.port", "465");
				props.put("mail.smtp.starttls.enable", "true");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.debug", "true");
				props.put("mail.smtp.socketFactory.port", "465");
				props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				props.put("mail.smtp.socketFactory.fallback", "false");
			}

			Authenticator auth = new MyAuthentication();
			Session sess = Session.getInstance(props, auth);

			Log.print(LOGGER, "sess=[" + sess + "]");

			Message msg = new MimeMessage(sess);
			msg.setFrom(new InternetAddress(mFrom));
			InternetAddress[] address = {new InternetAddress(mTo)};
			msg.setRecipients(Message.RecipientType.TO, address);
			msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
			msg.setSentDate(new java.util.Date());
			//msg.setText(text);

			MimeMultipart mp = new MimeMultipart();
			mp.setSubType("related");
			MimeBodyPart mbp1= new MimeBodyPart();
			
			filename = fileSize(filename);
			MimeBodyPart mbp2= new MimeBodyPart();
			FileDataSource fds = new FileDataSource(filename);
			
			mbp2.setDataHandler(new DataHandler(fds));
			mbp2.setFileName(MimeUtility.encodeText(fds.getName(), "KSC5601", "B"));
			
			mbp1.setContent(text,"text/html; charset=UTF-8");
			mp.addBodyPart(mbp1);
			if((!filename.equals(""))){
				mp.addBodyPart(mbp2);
			}
			msg.setContent(mp);
			
			Transport.send(msg);

			Log.print(LOGGER, "End sendMailThread.run()...[" + mTo + "]로 메일발송 완료됨.");

		} catch (Exception mex) {
			Log.print(LOGGER,mex);
			
			throw mex;// new Exception("Call SendMailSingle error!!");
		}
    }
	private String fileSize(String filename){
	File file = new File(filename);
		if (filename.length() > (1025 * 1025 * 2.5)){
			filename = "";
		}
	return filename;
	}
}
