package com.asia3d.contents.service.impl.stl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.asia3d.util.FileUtil;
import com.asia3d.util.Log;
import com.asia3d.util.PropertyUtil;

public class Meshconvs {

	private static final Logger LOGGER = LoggerFactory.getLogger(Meshconvs.class);
	private String PROP_FILE = "/property/3dbank.properties";
		
	private String sourcePath	= null;
	private String sourceFile	= null;
	private String outType 		= null;
	
	public Meshconvs(String sourcePath, String sourceFile, String outType) {
		// TODO Auto-generated constructor stub
		this.sourcePath = sourcePath;
		this.sourceFile = sourceFile;
		this.outType 	= outType;
	}

	private StringBuffer strbuf = null;
	public String makefile(String targetPath, String targerFile) throws Exception {
		// TODO Auto-generated method stub
        strbuf = new StringBuffer ( );
        
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		
		Log.print(LOGGER, "###### Meshconvs.makefile ######");
		
		String outLine = new String();

        String [] param = {
        		pl.get("MESHCONV_EXE"),
        		sourcePath + sourceFile,
                "-c",
                outType,
                "-o",
                targetPath + targerFile
        };
        
        try
	    {

            BufferedReader br = null;

            Process proc = Runtime.getRuntime ( ).exec ( param );

            br = new BufferedReader ( new InputStreamReader ( proc.getInputStream ( ) ) );

            String line;
            while ( ( line = br.readLine ( ) ) != null ) {
                strbuf.append ( line + "\n" );
            }

            br.close ( );
            proc.destroy ( );

        	// 결과 파일의 존재 유무로 결정한다.
    		long filesize = FileUtil.getFileSize(targetPath + targerFile + "." + outType);
    		
    		if(filesize <= 0) {
    			throw new RuntimeException("cannot find targerFile : [" + targetPath + targerFile + "." + outType + "]");
    		}
    		
            //System.out.println (strbuf );

            return targerFile + "." + outType;
        }
        catch ( Exception e ) { throw e ; }
        
  
	}	
	
	public String getOutputMsg()
	{
		return strbuf.toString();
	}
		
	/*
	public String makefile(String targetPath, String targerFile) throws Exception {
		// TODO Auto-generated method stub
		
		PropertyUtil pl = new PropertyUtil(PROP_FILE);
		
		Log.print(LOGGER, "###### Meshconvs.makefile ######");
		
		String outLine = new String();

		String param[] = 
			{	
				pl.get("MESHCONV_EXE"),
				sourcePath + sourceFile,
				outType,
				targetPath + targerFile,
				pl.get("LOGS_BASE_DIR") + "meshconv/" + targerFile + "." + outType + ".log" 
			};

		for(int i=0;i<param.length;i++)
		{
			Log.print(LOGGER, ">> param[" + i + "]=[" + param[i] + "]");
		}

		Runtime runtime = Runtime.getRuntime();

		Process process = runtime.exec(param);

		process.waitFor();
		int exitValue = process.exitValue();
		
		Log.print(LOGGER, "process.exitValue [" + exitValue	+ "]");
		
		// 결과 파일의 존재 유무로 결정한다.
		long filesize = FileUtil.getFileSize(targetPath + targerFile + "." + outType);
		
		if(filesize <= 0) {
			throw new RuntimeException("cannot find targerFile : [" + targetPath + targerFile + "." + outType + "]");
		}

		InputStream is = process.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);

		String line;

		while((line = br.readLine()) != null) {
			outLine += line + "<br>\n";
		}

		
		Log.print(LOGGER, outLine);
		
		return outLine;
	}
	*/

}
