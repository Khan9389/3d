package com.asia3d.util;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;

public class DownUtil {
    public void download(HttpServletRequest request
                        ,HttpServletResponse response
                        ,String realfilepath
                        ,String realfilename
                        ,String originalfilename) {
        String defaultfilepath = request.getSession().getServletContext().getRealPath("/");
         System.out.println("defaultfilepath = " + defaultfilepath);
         System.out.println("realfilepath + realfilename = " + realfilepath + realfilename);
        //해당 realfilepath 변수에 들어갈 파일경로는 "/경로1/경로2/ << 이런식으로 들어갈경우를 가정
        //만약 경로1/경로2 이런식으로 줄경우 if문을 삭제 또는 주석처리
       /* if(realfilepath.length() > 0) {
            realfilepath = realfilepath.substring(1);
        }*/
        //만약 웹소스 내에 존재하지 않는 파일일 경우
        //defaultfilepath + realfilepath 부분을 실제 경로로만 변경해주면 됨
        File downloadfile = new File(realfilepath + realfilename);
        if (downloadfile.exists() && downloadfile.isFile()) {
            response.setContentType("application/octet-stream; charset=utf-8");
            response.setContentLength((int) downloadfile.length());
            OutputStream outputstream = null;
            FileInputStream inputstream = null;
            try {
                response.setHeader("Content-Disposition", getDisposition(realfilename, check_browser(request)));
                response.setHeader("Content-Transfer-Encoding", "binary");
                outputstream = response.getOutputStream();
                inputstream = new FileInputStream(downloadfile);
                //Spring framework 사용할 경우
                
                FileCopyUtils.copy(inputstream, outputstream);
                
                //일반 자바/JSP 파일다운로드
                /*byte[] buffer = new byte[1024]; 
                int length = 0; 
                while((length = inputstream.read(buffer)) > 0) {
                    outputstream.write(buffer,0,length); 
                }*/
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (inputstream != null){
                        inputstream.close();
                    }
                    outputstream.flush();
                    outputstream.close();  
                } catch (Exception e2) {}
            }
        }else {
            System.out.println("파일존재하지 않음");
        }
    }
 
    private String check_browser(HttpServletRequest request) {
        String browser = "";
        String header = request.getHeader("User-Agent");
        //신규추가된 indexof : Trident(IE11) 일반 MSIE로는 체크 안됨
        if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1){
            browser = "ie";
        }
        //크롬일 경우
        else if (header.indexOf("Chrome") > -1){
            browser = "chrome";
        }
        //오페라일경우
        else if (header.indexOf("Opera") > -1){
            browser = "opera";
        }
        //사파리일 경우
        else if (header.indexOf("Apple") > -1){
            browser = "sarari";
        } else {
            browser = "firfox";
        }
        return browser;
    }
 
    private String getDisposition(String down_filename, String browser_check) throws UnsupportedEncodingException {
        String prefix = "attachment;filename=";
        String encodedfilename = null;
        System.out.println("browser_check:"+browser_check);
        if (browser_check.equals("ie")) {
            encodedfilename = URLEncoder.encode(down_filename, "UTF-8").replaceAll("\\+", "%20");
        }else if (browser_check.equals("chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < down_filename.length(); i++){
                char c = down_filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedfilename = sb.toString();
        }else {
            encodedfilename = "\"" + new String(down_filename.getBytes("UTF-8"), "8859_1") + "\"";
        }
        return prefix + encodedfilename;
    }
}
