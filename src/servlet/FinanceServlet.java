package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import service.FinanceServerce;

import VO.financeVO.FinanceAddVO;
import VO.financeVO.FinanceDeleteVO;
import VO.financeVO.FinanceUpdateVO;



public class FinanceServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * 参数（int）对应前端的服务请求如下：0:add; 1:update; 2:delete
	 */
	public void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException ,IOException{
		//设置编码格式
		request.setCharacterEncoding("utf-8");//为什么设置为utf-8会不行的？
		response.setCharacterEncoding("gbk");
		response.setContentType("text/html,gbk");
		//验证是否登录
		HttpSession session = request.getSession();
		Integer user_id = (Integer)session.getAttribute("user_id");
		//获取数据输出对象
		PrintWriter out = response.getWriter();
		if(user_id==null){
			response.sendRedirect("loginUI.jsp");
			out.println("<script>alert('您尚未登录！')</script>");
			out.close();
			return;
		}
		//接受前端服务类型的参数
		int id = 0;
		try{
			id = Integer.parseInt(request.getParameter("id"));
		}catch (NumberFormatException e) {
			// TODO: handle exception
			//捕获异常，拦截非法操作
			e.printStackTrace();
			response.sendRedirect("indexUI.jsp");
			out.println("<script>alert('非法操作！')</script>");
			out.close();
			return;
		}
		//业务代码
 		switch(id){
			case(0):{
				//add操作
				//获取添加的数据类型（1代表支出，2代表收入）
				int type=Integer.parseInt(request.getParameter("type"));//根据接收参数判断是支出还是收入型记录
				
				String fin_moneyStr = request.getParameter("fin_money");
				String fin_type = request.getParameter("fin_type");
				String fin_time = request.getParameter("fin_time");
				String fin_summary = request.getParameter("fin_summary");
				/*
				*业务判断参数输入是否为空（fin_money不能为空,fin_type不能为"收入类型",其他类型可以为空
				*当其他类型为空时，被设置成默认值存储，其中，fin_time默认=0000-00-00，fin_summary="该消费记录无任何说明&&"
				*/
				
				/*判断接收到的输入金额是否为空，为空url传参返回-1,否则转换为int类型,如果用户输入的金额格式不对，
				*跳转至提示界面，url传参传输-1值作为标记，窗口提示用户重新输入
				*/
				int fin_money = 0;
				if(fin_moneyStr==null || "".equals(fin_moneyStr)){
					out.println("<script>alert('金额输入不能为空！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}else{
					try{
						fin_money = Integer.parseInt(fin_moneyStr);
					}catch(NumberFormatException e){
						e.printStackTrace();
						//出现异常，表示输入格式不对，跳转至提示页面
						out.println("<script>alert('非法操作！');window.location='financesUI.jsp';</script>");
						out.close();
						return;
					}
				}
				//判断用户是否选择收入类型，若否，跳转至提示界面
				if("收入类型".equals(fin_type)){
					out.println("<script>alert('请选择收入类型！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}
				
				//通过验证之后，执行数据业务存储业务方法
				//初始化封装类数据
				FinanceAddVO vo = new FinanceAddVO();
				vo.user_id = user_id;
				//判断是支出还是收入(2是收入)
				if(type==2){
					vo.fin_money = fin_money;
					vo.fin_typeAttribute = 1;
				}else{
					vo.fin_money = fin_money * -1;
					vo.fin_typeAttribute = 0;
				}
				
				
				vo.fin_typeName = fin_type;
				if(fin_time==null || "".equals(fin_time)){
					vo.fin_time = " ";
				}else{
					vo.fin_time = fin_time;
				}
				if(fin_summary==null || "".equals(fin_summary)){
					vo.fin_summary = "该消费记录无任何说明&&";
				}else{
					vo.fin_summary = fin_summary;
				}
				//调用FinanceTypeServerce中的add方法
				FinanceServerce serverce = new FinanceServerce();
				boolean rtn = serverce.financeAddDo(vo);
				if(rtn){
					
					out.print("<script>alert('添加成功')</script>");
					response.sendRedirect("financesUI.jsp");
					//out.close();
				}else{
					out.println("<script>alert('添加失败，请检查网络连接！');window.location='financesUI.jsp';</script>");
					out.close();
				}
				return;
			}
			case(1):{
				//update操作
				String record_type = request.getParameter("fin_typeAttribute3");//记录类型：支出or收入
				String fin_type = request.getParameter("fin_type3");
				String fin_moneyStr = request.getParameter("fin_money3");
				String fin_time = request.getParameter("fin_time3");
				String fin_summary = request.getParameter("fin_summary3");
				
				double fin_money = 0;
				if(fin_moneyStr==null || "".equals(fin_moneyStr)){
					out.println("<script>alert('金额输入不能为空！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}else{
					try{
						fin_money = Double.parseDouble(fin_moneyStr);
					}catch(NumberFormatException e){
						e.printStackTrace();
						//出现异常，表示输入格式不对，跳转至提示页面
						out.println("<script>alert('金额输入不合法！');window.location='financesUI.jsp';</script>");
						out.close();
						return;
					}
				}
				//判断用户是否选择收入类型，若否，跳转至提示界面
				if("收入类型".equals(fin_type)){
					out.println("<script>alert('请选择收入类型！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}
				int fin_id = 0;
				try{
					fin_id = Integer.parseInt(request.getParameter("fin_id"));
				}catch(NumberFormatException e){
					e.printStackTrace();
					out.println("<script>alert('非法操作！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}
				//通过验证之后，执行数据业务存储业务方法
				//初始化封装类数据
				FinanceUpdateVO vo = new FinanceUpdateVO();
				vo.fin_id = fin_id;
				vo.user_id = user_id;
				//判断是支出还是收入(2是收入)
				if("收入".equals(record_type)){
					vo.fin_money = fin_money;
					vo.fin_typeAttribute = 1;
				}else if("支出".equals(record_type)){
					vo.fin_money = fin_money * -1;
					vo.fin_typeAttribute = 0;
				}else{
					//非法操作，拦截跳转
					out.println("<script>alert('非法操作！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}
				vo.fin_typeName = fin_type;
				if(fin_time==null || "".equals(fin_time)){
					out.println("<script>alert('请输入时间！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}else{
					//利用正则表达式判断日期格式
					String eL = "[1-9][0-9]{3}\\-(0[0-9]|1[0-2])\\-(0[0-9]|1[0-9]|2[0-9]|3[0-1])";
					 Pattern p = Pattern.compile(eL);    
				     Matcher m = p.matcher(fin_time);    
				     boolean b = m.matches();   
					if(b)
						vo.fin_time = fin_time;
					else{
						out.println("<script>alert('时间输入格式不正确！');window.location='financesUI.jsp';</script>");
						out.close();
						return;
					}
				}
				if(fin_summary==null || "".equals(fin_summary)){
					out.println("<script>alert('请输入记录说明！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}else{
					vo.fin_summary = fin_summary;
				}
				//调用FinanceTypeServerce中的add方法
				FinanceServerce serverce = new FinanceServerce();
				boolean rtn = serverce.financeUpdateDo(vo);
				if(rtn){
					out.println("<script>alert('修改成功！');window.location='financesUI.jsp';</script>");
					out.close();
				}else{
					out.println("<script>alert('添加失败，请检查网络连接！');window.location='financesUI.jsp';</script>");
					out.close();
				}
				return;
			}
			case(2):{
				//delete操作
				FinanceServerce server = new FinanceServerce();
				FinanceDeleteVO vo = new FinanceDeleteVO();
				vo.fin_money = Double.parseDouble((String)request.getParameter("fin_money"));
				try{
					vo.fin_id = Integer.parseInt((String)request.getParameter("fin_id"));
				}catch (NumberFormatException e) {
					// TODO: handle exception
					e.printStackTrace();
					out.println("<script>alert('非法操作！');window.location='financesUI.jsp';</script>");
					out.close();
					return;
				}
				
				vo.user_id = user_id;
				boolean rtn = server.financeDeleteDo(vo);
				//判断是否 执行成功
				if(rtn){
					out.println("<script>alert('添加成功！');window.location='financesUI.jsp';</script>");
					//out.close();
				}else{
					out.println("<script>alert('添加失败，请检查网络连接！');window.location='financesUI.jsp';</script>");
					out.close();
				}
				return;
			}
		}
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
		throws ServletException ,IOException{
		doGet(request,response);
	}
}
