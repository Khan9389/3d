package com.asia3d.util;


import java.awt.Color;
import java.awt.Graphics2D; 
import java.awt.RenderingHints; 
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import javax.imageio.ImageIO; 

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class SpriteMiddleImage {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SpriteMiddleImage.class);
	
    int maxWidth; double xyRatio; // 이미지의 행값,열값,가로,가로세로비율
    String s_imge, t_imge;
    
    /*
     * s_imge : 소스이미지
     * t_imge : 저장될이미지
     * w_size : 가로비율
     * h_size : 세로비율
     */
    public SpriteMiddleImage(String s_imge,String t_imge,int maxWidth, double xyRatio) {
        this.s_imge = s_imge;
        this.t_imge = t_imge;
        this.maxWidth = maxWidth;
        this.xyRatio = xyRatio;
    }
    
    public void saveSpliteImage(){

    	FileOutputStream fos = null;
    			
    	try {
    		Log.print(LOGGER, "## Start SpriteMiddleImage #################################");
    		Log.print(LOGGER, "## s_imge  :" + s_imge);
    		Log.print(LOGGER, "## t_imge  :" + t_imge);
    		Log.print(LOGGER, "## maxWidth:" + maxWidth);
    		Log.print(LOGGER, "## xyRatio :" + xyRatio);

			
	        File f = new File(t_imge);
	        fos = new FileOutputStream(f);
			
	        fos.write(generateImage( getImageBytes(s_imge)));
			 
	    } catch (Exception e) {
	    	Log.print(LOGGER, e);
	    }
		finally {
	        try { fos.close(); } catch (IOException e) {}
			
		}
		Log.print(LOGGER, "## End  SpriteMiddleImage #################################");
		
    }
	
	public  byte[] generateImage( byte[] imageContent) throws IOException {
        BufferedImage originalImg = ImageIO.read( new ByteArrayInputStream(imageContent));
 
        //get the center point for crop
        int[] centerPoint = { originalImg.getWidth() /2, originalImg.getHeight() / 2 };
 
        //calculate crop area
        int cropWidth=originalImg.getWidth();
        int cropHeight=originalImg.getHeight();
 
        if( cropHeight > cropWidth * xyRatio ) {
            //long image
            cropHeight = (int) (cropWidth * xyRatio);
        } else {
            //wide image
            cropWidth = (int) ( (float) cropHeight / xyRatio) ;
        }
 
        //set target image size
        int targetWidth = cropWidth;
        int targetHeight = cropHeight;
 
        //if( targetWidth > maxWidth) 
        {
            //too big image
            targetWidth = maxWidth;
            targetHeight = (int) (targetWidth * xyRatio);
        }
 
        //processing image
        BufferedImage targetImage = new BufferedImage(targetWidth, targetHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics2D = targetImage.createGraphics();
        graphics2D.setBackground(Color.WHITE);
        graphics2D.setPaint(Color.WHITE);
        graphics2D.fillRect(0, 0, targetWidth, targetHeight);
        graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        graphics2D.drawImage(originalImg, 0, 0, targetWidth, targetHeight,   centerPoint[0] - (int)(cropWidth /2) , centerPoint[1] - (int)(cropHeight /2), centerPoint[0] + (int)(cropWidth /2), centerPoint[1] + (int)(cropHeight /2), null);
 
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        
        if(    s_imge.toLowerCase().indexOf(".jpeg") > 0) ImageIO.write(targetImage, "JPEG", output);
        else if(s_imge.toLowerCase().indexOf(".jpg") > 0)  ImageIO.write(targetImage, "JPG", output);
        else if(s_imge.toLowerCase().indexOf(".png") > 0)  ImageIO.write(targetImage, "PNG", output);
        else if(s_imge.toLowerCase().indexOf(".gif") > 0)  ImageIO.write(targetImage, "GIF", output);
        else if(s_imge.toLowerCase().indexOf(".bmp") > 0)  ImageIO.write(targetImage, "BMP", output);
        else ImageIO.write(targetImage, "PNG", output);
        
        //ImageIO.write(targetImage, "png", output);
 
        return output.toByteArray();
    }
	

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		String path = "C:/Users/lys01/Desktop/test";
		File dirFile = new File(path);
		File [] fileList = dirFile.listFiles();
		
        double xyRatio = 0.75;
        int maxWidth = 600;
        
		for(File t:fileList){
			String tmpPath = t.getParent();
			String tmpFileName = t.getName();
			//int extPosition = tmpFileName.indexOf("jpg");
			//if(extPosition != -1)
			{
				String fullPath = tmpPath+"/"+tmpFileName;
	
				//String newFileName = tmpFileName.replaceFirst(".jpg", "_resize.jpg");
				String newPath = tmpPath+"/resize_"+tmpFileName;
				
		        SpriteMiddleImage sp = new SpriteMiddleImage(fullPath, newPath, maxWidth, xyRatio);
		        sp.saveSpliteImage();
		        
				System.out.println(newPath);
			}
		}
		System.out.println("FIN");
	}
	
	/*
	public static void main(String[] args) throws IOException {
		 
        String imgUrl = "http://wstatic.dcinside.com/new/interview/dc_se1.jpg";
        // width: height
        double xyRatio = 0.75;
        int maxWidth = 600;
 
        URL url = new URL(imgUrl);
 
        File f = new File("C:/Users/lys01/Desktop/test/a.png");
        FileOutputStream fos = new FileOutputStream(f);
 
        fos.write(generateImage( getImageContent(url), maxWidth, xyRatio));
 
        fos.close();
 
    }
    */
 
	private  byte[] getImageBytes(String file) throws IOException {
        ByteArrayOutputStream bais = new ByteArrayOutputStream();
         
        File f = new File(file);
        FileInputStream is = new FileInputStream(f);
        
 
  
          byte[] byteChunk = new byte[4096]; // Or whatever size you want to read in at a time.
          int n;
 
          while ( (n = is.read(byteChunk)) > 0 ) {
            bais.write(byteChunk, 0, n);
          }
 
        is.close();
        return bais.toByteArray();
    }
	
 
    private  byte[] getImageContent(URL url) throws IOException {
        ByteArrayOutputStream bais = new ByteArrayOutputStream();
        InputStream is = null;
 
          is = url.openStream ();
          byte[] byteChunk = new byte[4096]; // Or whatever size you want to read in at a time.
          int n;
 
          while ( (n = is.read(byteChunk)) > 0 ) {
            bais.write(byteChunk, 0, n);
          }
 
        is.close();
        return bais.toByteArray();
    }
}
