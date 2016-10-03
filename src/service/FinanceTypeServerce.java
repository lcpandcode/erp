package service;

import VO.financeTypeVO.FinanceTypeAddVO;
import VO.financeTypeVO.FinanceTypeUpdateVO;

public class FinanceTypeServerce {
	int fin_typeNameId;//全局变量，方便查找对应数据
	public FinanceTypeServerce(int fin_typeNameId) {
		// TODO Auto-generated constructor stub
		this.fin_typeNameId = fin_typeNameId;
	}
	//查看，由于查看finance类型时根据user_id来查询的，所以要将user_id传进查看方法
	public String [] financeTypeViewDo(int user_id){
		String [] rtn = null;
		
		return rtn;
	}
	//增加fin_type
	public boolean financeTypeAddDo(FinanceTypeAddVO finTypeAddVO){
		boolean rtn = false; 
		
		return rtn ;
	}
	//删除类型
	public boolean financeTypeDeleteDo(){
		boolean rtn = false;
		
		return rtn;
	}
	//修改类型
	public boolean financeTypeUpdateDo(FinanceTypeUpdateVO finTypeUpdateVO){
		boolean rtn = false;
		
		return rtn ;
	}
}
