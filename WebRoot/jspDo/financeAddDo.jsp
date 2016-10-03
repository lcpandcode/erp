<%@page import="service.FinanceServerce"%>
<%@page import="VO.financeVO.FinanceAddVO"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//登录验证
	Integer user_idInt = (Integer)session.getAttribute("user_id");
	int user_id = 0;
	if(user_idInt==null ){
		response.sendRedirect("../reminder/notLoginReminder.jsp");
		return ;
	}else{
		user_id = user_idInt;
	}
	//获取前端的输入值(根据url传参的type来确定用户是添加收入的数据还是支出消费的数据)
	//设置编码格式避免乱码
	request.setCharacterEncoding("utf-8");
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
		response.sendRedirect("../reminder/financeReminder.jsp?rtn=-1");
		return;
	}else{
		try{
			fin_money = Integer.parseInt(fin_moneyStr);
		}catch(NumberFormatException e){
			System.out.println("异常出现地方：FinanceAddDo, 42行");
			e.printStackTrace();
			//出现异常，表示输入格式不对，跳转至提示页面
			response.sendRedirect("../reminder/financeReminder.jsp?rtn=-2");
		}
	}
	//判断用户是否选择收入类型，若否，跳转至提示界面
	if("收入类型".equals(fin_type)){
		response.sendRedirect("../reminder/financeReminder.jsp?rtn=-3");
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
	//添加成功，跳转至reminder界面,并通过url传递参数1表示添加成功,添加失败传递-4
	if(rtn){
		response.sendRedirect("../reminder/financeReminder.jsp?rtn=1");
		return ;
	}else{
		response.sendRedirect("../reminder/financeReminder.jsp?rtn=-4");
	}
 %>

