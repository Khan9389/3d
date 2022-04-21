package com.asia3d.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

public class ShellCommander {

	public static void main(String[] args) throws Exception {

		String command = "ls -al";

		// 이 부분에 실행할 리눅스 Shell 명령어를 입력하면 된다. (여기선 ls -al 명령어 입력)

		(new ShellCommander()).OpenscadCmd();
	}

	String OpenscadCmd() throws Exception {

		String path = "/home/vdiuser/Downloads/openscad/stl2png/";

		// stl2png script
		String stl2png_shell = "/home/vdiuser/Downloads/openscad/stl2png/stl2png.sh";

		String param[] = {	stl2png_shell,
							path + "stl2png.scad", 
							path + "cube.png", 
							path + "2.bin.stl"};

		for(int i=0;i<param.length;i++)
		{
			System.out.println("param[" + i + "]=[" + param[i] + "]");
		}

		Runtime runtime = Runtime.getRuntime();

		Process process = runtime.exec(param);

		process.waitFor();
		int exitValue = process.exitValue();
		System.out.println("exit code is not 0 [" + exitValue	+ "]");
		if (exitValue != 0) {
			throw new RuntimeException("exit code is not 0 [" + exitValue	+ "]");
		}


		InputStream is = process.getInputStream();

		InputStreamReader isr = new InputStreamReader(is);

		BufferedReader br = new BufferedReader(isr);

		String line;
		String outLine = new String();

		while((line = br.readLine()) != null) {
			outLine += line + "\n";
		}

		System.out.println(outLine);

		return outLine;
	}

}
