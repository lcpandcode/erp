package tool;

import java.util.ArrayList;
import java.util.List;

import DAO.FinanceDAO;
import DTO.financeDTO.FinanceDTO;

public class Paging<E> {
	int limit = 5;
	int page = 1;
	String dataBaseName = null;
	/*
	 * 实现说明：分页类用于数据的分页读取，接收的参数包括每页多少条数据limit,当前页数page,要进行分页读取的
	 * 数据库的名字dataBaseName,返回的信息是一个读取数据的列表集合，其中，limit默认是5，page默认是1（首页）
	 */
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	//构造方法
	public Paging(int limit,int page,String dataBaseName){
		this.limit = limit;
		this.page = page;
		this.dataBaseName = dataBaseName;
	}
	//使用泛型进行分页读取功能得实现
	public  List<E> paging(int limit,int page,String dataBaseName){
		//List<E> list = new ArrayList<E>();
		if("finance".equals(dataBaseName)){
			int beginRead = page * (limit-1) + 1;
			int endRead = beginRead + limit;
			FinanceDAO dao = new FinanceDAO();
			return FinanceDAO.findAllUserInBatch(beginRead, endRead);
		}
		return null;
	}
}
