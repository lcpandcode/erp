package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.*;
import VO.collectVO.*;

public class CollectServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;//默认序列化，解决兼容性问题

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	/*
	 * 参数（int）对应前端的服务请求如下：0:add; 1:update; 2:delete
	 */
	public void doGet(HttpServletRequest request,HttpServletResponse response)
		throws ServletException ,IOException{
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
		//设置编码格式
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html,utf-8");
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
		
		switch(id){
			case(0):{
				//collectAddDo
				//获取前端参数
				String col_name = request.getParameter("col_name");
				//进行非法拦截
				if(col_name==null || "".equals(col_name)){
					response.sendRedirect("../reminder/collectReminder.jsp?rtn=0");
					out.close();
					return;
				}
				String col_address = request.getParameter("col_address");
				if(col_address==null || "".equals(col_address)){
					response.sendRedirect("../reminder/collectReminder.jsp?rtn=1");
					out.close();
					return;
				}
				CollectServerce serverce = new CollectServerce();
				CollectAddVO vo = new CollectAddVO();
				vo.col_name = col_name;
				vo.col_address = col_address;
				vo.user_id = user_id;
				boolean rtn = serverce.collectAdd(vo);
				if(rtn){
					response.sendRedirect("collectsUI.jsp");
					out.println("<script>alert('添加成功！')</script>");
					out.close();
					return;
				}else{
					response.sendRedirect("<script>alert('添加成功！')</script>");
					out.println("<script>alert('添加失败，请检测网络连接！')</script>");
					out.close();
				}
				break;
			}
			case(1):{
				//Update操作
				
			}
			case(2):{
				//delete操作
			}
		}
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws ServletException ,IOException{
		PrintWriter out = response.getWriter();
		try{
			doGet(request,response);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			out.println("<script>alert('添加失败，请检测网络连接！')</script>");
			out.close();
			return;
		}
	}
}
