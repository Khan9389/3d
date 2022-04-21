package com.asia3d.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * 
	<meta charset="utf-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=960">
	<meta name="apple-mobile-web-app-title" content="NAVER" />
	<meta property="og:title" content="네이버 메인">
	<meta property="og:url" content="http://www.naver.com/">
	<meta property="og:image" content="http://static.naver.net/www/mobile/edit/2016/0407/mobile_17004159045.png">
	<meta property="og:description" content="네이버 메인에서 다양한 정보와 유용한 컨텐츠를 만나 보세요">
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="네이버 메인">
	<meta name="twitter:url" content="http://www.naver.com/">
	<meta name="twitter:image" content="http://static.naver.net/www/mobile/edit/2016/0407/mobile_17004159045.png">
	<meta name="twitter:description" content="네이버 메인에서 다양한 정보와 유용한 컨텐츠를 만나 보세요">
 *
 */
public class KakaoThumnail {
	
	static Logger log = LoggerFactory.getLogger(KakaoThumnail.class);

	public static void main(String h[]) {

		KakaoThumnail kaka = new KakaoThumnail("http://www.naver.com");
		kaka.run();

		KakaoThumnail kaka2 = new KakaoThumnail("http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&oid=030&aid=0002487504&sid1=001");
		kaka2.run();
		
		KakaoThumnail kaka3 = new KakaoThumnail("http://www.daum.net");
		kaka3.run();

		KakaoThumnail kaka4 = new KakaoThumnail("http://m.blog.naver.com/linesync/220722712643");
		kaka4.run();
		
		KakaoThumnail kaka5 = new KakaoThumnail("http://news.naver.com/main/read.nhn?mode=LSD&mid=sec&oid=052&aid=0000844796&sid1=001");
		kaka5.run();
		
		KakaoThumnail kaka6 = new KakaoThumnail("http://blog.naver.com/wowwow3d/220650266207");
		kaka6.run();
		
	}
	
	private String reg_url;
	public KakaoThumnail(String url) {
		this.reg_url = url;
	}
	
	public Hashtable run(){
		 
        URL url;
        InputStream is = null;
        BufferedReader br;
        String line;
       
        Hashtable data = new Hashtable();
        
        try {
        	if(reg_url.indexOf("http://") < 0 && reg_url.indexOf("https://") < 0)
        		reg_url = "http://" + reg_url;
        	log.info("####");
        	log.info("#### reg_url:" + reg_url);
        	log.info("####");
            url = new URL(reg_url);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.connect();
            String contentType = connection.getContentType();
            log.info("contentType:" + contentType);
            
            String charset = null;
            if(contentType != null) {
            	int iPos = contentType.toLowerCase().replaceAll(" ", "").indexOf("charset=") ;
            	if(iPos >= 0 ) charset = contentType.toLowerCase().replaceAll(" ", "").substring(iPos + 8);
            }
            
            log.info("charset:" + charset);
            
            int responseCode = connection.getResponseCode();
            log.info("responseCode:" + responseCode);
                           
            if(responseCode== 200){ // 성공
            	
                if(contentType != null ){
                    if(contentType .contains("text/html")){
                        // 파싱 시작
                    	
                    	/*
                    	 * 추후 한글이 깨지는지 이부분에서 유념해야한다.
                    	 */
                    	if(contentType.toLowerCase().indexOf("euc-kr") >= 0) {
                    		br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "euc-kr"));
                    	}
                    	else if(contentType.toLowerCase().indexOf("utf-8") >= 0) {
                    		br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));	
                    	}
                    	else if(charset != null && charset.length() > 0) {
                    		br = new BufferedReader(new InputStreamReader(connection.getInputStream(), charset));
                    	}
                    	else {  // default
                    		br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));	
                    	}
                        
 
                        String fullStr = "";
                        StringBuffer bf = new StringBuffer();
                        while ((line = br.readLine()) != null) {
                        	// log.info(line);
                        	//line = StrUtil.to8859(line);
                            bf.append(line);
                            if(line.trim().endsWith(">")) {
                            	bf.append("\n");
                            }
                        }
                        fullStr = bf.toString();
                        
                       // 전체
                       //log.info(fullStr);
                        
                       long start = System.currentTimeMillis(); 
                       data  = getData(fullStr);
                       log.info("currentTimeMillis:" + (System.currentTimeMillis()-start));
                    }
                }
            }
  
        } catch (MalformedURLException mue) {
        	log.error("KakaoThumnail", mue);
        	
        } catch (IOException ioe) {
        	log.error("KakaoThumnail", ioe);
        } finally {
            try {
                if (is != null) is.close();
            } catch (IOException ioe) {
                // nothing to see here
            }
        }
        
        return data;
	}
	
    

	
    /**
     * 메타 tag에서 content와 property 값을 가진 라인을 찾는다
     * @param str
     * @return
     */
    public Hashtable getData(String str) {
    	
    	String title   		= null;
        String url   		= null;
        String image  		= null;
        String description 	= null; 
        
        String reg = "<meta.*?((content=['\"].*['\"])|(property=['\"].*['\"])).*?((content=['\"].*['\"])|(property=['\"].*['\"])).*?>";
        
        Pattern pattern2 = Pattern.compile(reg, Pattern.CASE_INSENSITIVE);
 
        Matcher matcher2 = pattern2.matcher(str);
        while(matcher2.find()){
            String match2 = matcher2.group();
       
            if(false) 
            {
	            log.info("KakaoThumnail 0 : " + matcher2.group(0));
	            log.info("KakaoThumnail 1 : " + matcher2.group(1));
				log.info("KakaoThumnail 2 : " + matcher2.group(2));
				log.info("KakaoThumnail 3 : " + matcher2.group(3));
	            log.info("KakaoThumnail 4 : " + matcher2.group(4));
				log.info("KakaoThumnail 5 : " + matcher2.group(5));
				log.info("KakaoThumnail 6 : " + matcher2.group(6));
            }
			
			if(title == null && 
				( 	(matcher2.group(1) != null && matcher2.group(1).indexOf(":title") >= 0) || 
					(matcher2.group(2) != null && matcher2.group(2).indexOf(":title") >= 0) ||
					(matcher2.group(3) != null && matcher2.group(3).indexOf(":title") >= 0) ))
				{
					if(     matcher2.group(4) != null && matcher2.group(4).indexOf("content=") >= 0)
						title = matcher2.group(4).substring(8);
					else if(matcher2.group(5) != null && matcher2.group(5).indexOf("content=") >= 0)
						title = matcher2.group(5).substring(8);
					else if(matcher2.group(6) != null && matcher2.group(6).indexOf("content=") >= 0)
						title = matcher2.group(6).substring(8);
				}
			
			if(url == null && 
				( 	(matcher2.group(1) != null && matcher2.group(1).indexOf(":url") >= 0) || 
					(matcher2.group(2) != null && matcher2.group(2).indexOf(":url") >= 0) ||
					(matcher2.group(3) != null && matcher2.group(3).indexOf(":url") >= 0) ))
				{
					if(     matcher2.group(4) != null && matcher2.group(4).indexOf("content=") >= 0)
						url = matcher2.group(4).substring(8);
					else if(matcher2.group(5) != null && matcher2.group(5).indexOf("content=") >= 0)
						url = matcher2.group(5).substring(8);
					else if(matcher2.group(6) != null && matcher2.group(6).indexOf("content=") >= 0)
						url = matcher2.group(6).substring(8);
				}

			if(image == null && 
				( 	(matcher2.group(1) != null && matcher2.group(1).indexOf(":image") >= 0) || 
					(matcher2.group(2) != null && matcher2.group(2).indexOf(":image") >= 0) ||
					(matcher2.group(3) != null && matcher2.group(3).indexOf(":image") >= 0) ))
				{
					if(     matcher2.group(4) != null && matcher2.group(4).indexOf("content=") >= 0)
						image = matcher2.group(4).substring(8);
					else if(matcher2.group(5) != null && matcher2.group(5).indexOf("content=") >= 0)
						image = matcher2.group(5).substring(8);
					else if(matcher2.group(6) != null && matcher2.group(6).indexOf("content=") >= 0)
						image = matcher2.group(6).substring(8);
				}
				
			if(description == null && 
				( 	(matcher2.group(1) != null && matcher2.group(1).indexOf(":description") >= 0) || 
					(matcher2.group(2) != null && matcher2.group(2).indexOf(":description") >= 0) ||
					(matcher2.group(3) != null && matcher2.group(3).indexOf(":description") >= 0) ))
				{
					if(     matcher2.group(4) != null && matcher2.group(4).indexOf("content=") >= 0)
						description = matcher2.group(4).substring(8);
					else if(matcher2.group(5) != null && matcher2.group(5).indexOf("content=") >= 0)
						description = matcher2.group(5).substring(8);
					else if(matcher2.group(6) != null && matcher2.group(6).indexOf("content=") >= 0)
						description = matcher2.group(6).substring(8);
				}			
        }
        
        // 한번더 필터링을 거친후 실제 데이터를 입력을 해주어야함
        Hashtable hash = new Hashtable();
        
        if(removeDoubleQuotation(title) != null)  hash.put("og_title", removeDoubleQuotation(title));
        if(removeDoubleQuotation(url) != null)  hash.put("og_url", removeDoubleQuotation(url));
        if(removeDoubleQuotation(image) != null)  hash.put("og_image", removeDoubleQuotation(image));
        if(removeDoubleQuotation(description) != null)  hash.put("og_desc", removeDoubleQuotation(description));
        
        log.info("얻은 KakaoThumnail:" + hash);
        return hash;
	}
  
    public String removeDoubleQuotation(String m) {
    	//log.info("removeDoubleQuotation [" + m + "]");
    	if(m != null && m.length() >= 2 &&
    		"\"".equals(m.substring(0, 1)) &&
    		"\"".equals(m.substring(m.length()-1) ))
    	{
    		m = m.substring(1, m.length()-1);
    	}
    	//log.info("..> [" + m + "]");
    	return m;
    }
  
}
