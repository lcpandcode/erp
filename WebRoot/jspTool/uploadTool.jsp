<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import = "java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List,java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.disk.*"%>
<%@page import="org.apache.commons.fileupload.FileUploadBase.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.servlet.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
		//上传图片的相对路径
	String upload_path = "upload/headPic/";
	//默认头像定义
	String save_path = upload_path + "moren.png";
	
	//设置上传文件最大10k
	int kb = 10;
	final long MAX_SIZE = kb * 1024;
	//允许上传的文件格式列表
	final String[] allowedExt = new String[] {"jpg","gif","png"};
	//检测request中是否包含multipart内容
	
	if(ServletFileUpload.isMultipartContent(request)){
		
		//实例化一个硬盘文件工厂，用来配置上传组件ServletFileUpload
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//设置上传文件时用于临时存放文件的内存大小，这里是4k，多于部分将临时存在硬盘，就是说上传的时候一点一点地上传
		//先传向内存，多于4k的逐渐拉到硬盘临时文件夹中，待上传完毕，就从临时文件夹移到目标文件夹。不设置则为默认10240.
		factory.setSizeThreshold(4096);
		//用DiskFileItemFactory工厂实例化上传组件
		ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
		servletFileUpload.setHeaderEncoding("utf-8");
		//设置最大上传尺寸
		servletFileUpload.setSizeMax(MAX_SIZE);
		//从request得到所有上传域列表
		List<FileItem>fileItemsList = null;
		
		try{
			fileItemsList = servletFileUpload.parseRequest(request);
		}catch(FileUploadException e){
			if(e instanceof SizeLimitExceededException){
				//文件过大
				out.println("<script>alert('上传文件超过规定大小：' + kb +'KB，请重新操作！');window.location='register.jsp';</script>");
				return ;
			}
			e.printStackTrace();
		}
		if(fileItemsList != null && fileItemsList.size()!=0) {
			System.out.println("test3_register_do");
			//得到所有上传的文件/普通文本域
			Iterator fileItr = fileItemsList.iterator();
			
			FileItem item_file = null;
			while (fileItr.hasNext()) {
				//得到当前文件/普通文本域
				FileItem item = (FileItem)fileItr.next();
				/*
				//普通文本域
				if(item==null||item.isFormField()){
					String name = item.getFieldName();
					String value = item.getString("utf-8");
					if(name.equals("username") && value!=null && !value.equals("")){
						username = value;
					}
					if(name.equals("password") && value !=null && !value.equals("")){
						password = value;
					}
					if(name.equals("realname") && value !=null && !value.equals("")){
						realname = value;
					}
					if(name.equals("age") && value !=null && !value.equals("")){
						age = Integer.parseInt(value);
					}
					if(name.equals("sex") && value!=null && !value.equals("")){
						sex = value;
					}
					if(name.equals("phone") && value!=null && !value.equals("")){
						phone = value;
					}
					if(name.equals("qq") && value!=null && !value.equals("")){
						qq = value;
					}if(name.equals("email") && value!=null && !value.equals("")){
						email= value;
					}
					if(name.equals("weixin") && value!=null && !value.equals("")){
						weixin= value;
					}
					if(name.equals("dept") && value!=null && !value.equals("")){
						dept= value;
					}
				}
				//头像
				if(item != null && !item.isFormField()) {
					item_file=item;
				}
			}
				///判断传输的数据是否合法
			if(username !=null && password!=null && realname!=null){
				//数据连接，查看是否合法
				Connection conn = null;
				Statement stmt = null;
				ResultSet rs = null;
				try{
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enterprise","root","root");
					stmt = conn.createStatement();
					String sql = "select * from worker where w_username='" + username + "'";
					rs = stmt.executeQuery(sql);
					if(rs.next()){
						out.print(
						"<script> alert('对不起，该用户名已存在，请重新输入！');window.location='register.html';</script>");
						
					}
				}catch(Exception e){
					e.printStackTrace();
				}finally{
					try{
						if(rs!=null){
							rs.close();
						}
						if(stmt!=null){
							stmt.close();
						}
						if(conn!=null){
							conn.close();
						}
					}catch(Exception e){
						e.printStackTrace();
					}
				}
				
			}else{
				out.print(
				"<script>alert('输入的参数有误！');window.open('resigin.html','_self');</script>");
				return ;
			}
			*/
			//保存图像
			if(item_file != null){
				String fileName = item_file.getName();
				System.out.println("test_filename" + fileName);
				//得到文件大小
				long size = item_file.getSize();
				if(!"".equals(fileName) && size != 0) {
					//移除路径之后的文件名
					String t_name = fileName.substring(fileName.lastIndexOf("\\") + 1);
					String t_ext = t_name.substring(t_name.lastIndexOf(".") + 1); //后缀名
					
					//拒绝接受规定文件格式之外的格式
					int allowFlag = 0;
					int allowedExtCount = allowedExt.size();
					//遍历allowedExt动态数组判断是否符合格式
					Iterator it = allowedExt.iterator();
					while(it.hasNext()){
						if(t_text.equals(it.next()))
							break;
						
					}
				}
				
				fileName = "file" + System.currentTimeMillis()
				+ fileName.substring(fileName.lastIndexOf("."));
				System.out.println("test1_register");
				//定义文件路径biaoji1
				save_path = upload_path + fileName;
				//保存文件到服务器
				File file = new File(request.getSession().getServletContext().getRealPath(save_path));
				if(!file.getParentFile().exists()){
					file.getParentFile().mkdirs();
				}
				item_file.write(file);
			}
			//jdbc连接数据库
			Connection conn = null;
			Statement stmt = null;
			try{
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enterprise","root","root");
				stmt = conn.createStatement();
				String w_id = UUID.randomUUID().toString();
				String sql = "insert into worker values('" + w_id + "','"
				+ username + "','" + password + "','" + realname + "','" 
				+ age + "','" + sex +"','" + phone +"','" + qq + "','"
				+ weixin + "','" + email +"','" + dept + "','" + save_path + "')";
				stmt.executeUpdate(sql);
				out.print(
				"<script>alert('注册成功！');window.location='login.jsp';</script>");
				return ;
			}catch(Exception e){
				File f = new File(request.getSession().getServletContext().getRealPath(save_path));
				f.delete();
				out.print(
				"<script>alert('注册失败，请重新操作！');window.location='register.html';</script>");
				return ;
			}finally{
				if(stmt!=null){
					stmt.close();
				}
				if(conn!=null){
					conn.close();
				}
			}
		}	
	}
%>