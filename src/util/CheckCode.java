package util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Random;

import VO.toolVO.CheckCodeVO;

public class CheckCode {
	//验证码图片大小属性
	public int width = 62;
	public int height = 22;
	//验证码长度，默认为四
	public int length = 4;
	//验证码图片格式,默认问jpeg
	public String format = "jpeg";
	public CheckCodeVO create(){
		BufferedImage bufferedImg = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		Graphics2D g = bufferedImg.createGraphics();
		
		g.setColor(Color.WHITE);
		g.fillRect(0,0,width,height);
		
		Font font = new Font("Times New Roman",Font.PLAIN,18);
		g.setFont(font);
		
		g.setColor(Color.BLACK);
		g.drawRect(0,0,width-1,height-1);
		g.setColor(Color.GRAY);
		
		Random random = new Random();//设置随机种子
		
		for(int i=0;i<40;i++){
			//设置40条干扰线
			int x1 = random.nextInt(width);
			int y1 = random.nextInt(height);
			int x2 = random.nextInt(10);
			int y2 = random.nextInt(10);
			g.drawLine(x1,y1,x1+x2,y1+y2);
		}
		
		StringBuffer randomCode = new StringBuffer();
		for(int i = 0;i<length;i++){//获取随机数字字符串
			String strRand = String.valueOf(random.nextInt(10));
			g.setColor(Color.RED);
			g.drawString(strRand,13 * i + 6, 16);
			randomCode.append(strRand);
		}
		g.dispose();
		//将产生的数据放进封装类
		CheckCodeVO vo = new CheckCodeVO();
		vo.checkCode = randomCode.toString();
		vo.bufferedImg = bufferedImg;
		vo.format = format;
		//返回
		return vo;
	}
	
}
