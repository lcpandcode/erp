<%@page import="javax.imageio.ImageIO"%>
<%@page import="VO.toolVO.CheckCodeVO"%>
<%@page import="tool.CheckCode"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	CheckCode checkCode = new CheckCode();
	CheckCodeVO vo = checkCode.create();
	session.setAttribute("checkCode",vo.checkCode);
	
	response.setContentType("image/" + vo.format);
	response.setHeader("Pragam","no-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires",0);
	
	ServletOutputStream outputStream = response.getOutputStream();
	ImageIO.write(vo.bufferedImg,vo.format,outputStream);
	
	outputStream.close();
	
	out.clear();
	out=pageContext.pushBody();
 %>
