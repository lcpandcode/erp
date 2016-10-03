package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



public class ModelServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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
		//业务代码
		switch(id){
			case(0):{
				//add操作
				break;
			}
			case(1):{
				//update操作
				
				break;
			}
			case(2):{
				//delete操作
				
				break;
			}
		}
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)
		throws ServletException ,IOException{
		doGet(request,response);
	}
}
