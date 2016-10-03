package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DTO.financeDTO.FinanceDTO;


public class FinanceDAO {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		FinanceDAO dao = new FinanceDAO();
		FinanceDTO dto = new FinanceDTO();
		dto.fin_id=13;
		dto.fin_money = -20000;
		dto.fin_summary = "summaryTest";
		dto.fin_type = "其他";
		dto.fin_time = "2000-01-01";
		dao.updateFinance(dto);
	}
	//增加数据
	public boolean createFinance(FinanceDTO dto){
		boolean rtn = false;
		//由于findAddVO中没有fin_moneyTotal(剩余金额)的值，所以需要通过数据库操作获取计算该值
		double fin_moneyTotal = 0.00;
		//定义布尔变量，用于存储标记fin_moneyTotal的数据库读取操作是否成功，该布尔值用于判断是否执行下一步的财务数据插入操作
		boolean fin_monTotal = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs_id = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			String sql = "select max(fin_id) from finance where user_id='" + dto.user_id + "'";
			stmt = conn.createStatement();
			rs_id = stmt.executeQuery(sql);
			//获取当前用户最大的fin_id值，该值关联着上次最新的fin_moneyTotal值
			int max_id;
			if(rs_id.next()){
				max_id = rs_id.getInt(1);
				//根据最大fin_id获取最新的fin_moneyTotal
				Statement stmt_money = null;
				ResultSet rs_money = null;
				try{
					String sql_id = "select fin_moneyTotal from finance where fin_id='" + max_id + "'";
					stmt_money = conn.createStatement();
					rs_money = stmt_money.executeQuery(sql_id);
					if(rs_money.next()){
						fin_moneyTotal = dto.fin_money + rs_money.getDouble("fin_moneyTotal");
						//修改布尔值，存储读取成功的状态
						fin_monTotal = true;
					}else{
						//如果插入的数据是首条数据，则fin_totalMoney就是fin_money
						fin_moneyTotal = dto.fin_money;
					}
				}catch (Exception e) {
					// TODO: handle exception
					System.out.println("异常地方：FinanceServerce类，62行");
					e.printStackTrace();
				}finally{
					try{
						if(rs_money!=null)
							rs_money.close();
						if(stmt_money!=null)
							stmt_money.close();
					}catch (Exception e) {
						// TODO: handle exception
						System.out.println("异常地方：FinanceServerce类，72行");
						e.printStackTrace();
					}
					
				}
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println("异常地方：FinanceServerce类，81行");
			e.printStackTrace();
		}finally{
			try{
				if(rs_id!=null)
					rs_id.close();
				if(stmt!=null)
					stmt.close();
			}catch (Exception e) {
				// TODO: handle exception
				System.out.println("异常地方：FinanceServerce类，91行");
				e.printStackTrace();
			}
		}
		
		
		//由于传输过来的fin_typeName,所以要读取数据库查询对应的fin_typeNameId
		int fin_type = -1;
		ResultSet rs_type = null;
		try{
			stmt = conn.createStatement();
			String sql = "select fin_typeNameId from finance_type where fin_typeName='" + dto.fin_type
					+ "'and fin_typeAttribute='" + dto.fin_typeAttribute + "'";
			rs_type = stmt.executeQuery(sql);
			if(rs_type.next()){
				fin_type = rs_type.getInt("fin_typeNameId");
			}
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println("异常地方：FinanceServerce类，110行");
			e.printStackTrace();
			
		}finally{
			try{
				if(rs_type!=null)
				 rs_type.close();
				if(stmt!=null)
					stmt.close();
			}catch(Exception e){
				System.out.println("异常地方：FinanceServerce类,119行");
				e.printStackTrace();
			}
			
		}
		
		//进行数据库数据插入操作
		if(fin_type!=-1){
			try{
				stmt = conn.createStatement();
				String sql = "insert into finance (fin_type,fin_money,fin_moneyTotal,fin_time,fin_summary,user_id) values('"
						+ fin_type + "','" + dto.fin_money + "','" + fin_moneyTotal + "','" 
						+dto.fin_time + "','" + dto.fin_summary + "','" + dto.user_id + "')";
				stmt.executeUpdate(sql);
				rtn = true;
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				try{
					if(stmt!=null)
						stmt.close();
					if(conn!=null)
						conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
		}
		return rtn;
	}
	//修改数据
	public boolean updateFinance(FinanceDTO dto){
		boolean rtn = false;
		//先根据fin_id 读取数据，用于显示在编辑栏
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			
			/*修改从该行起所有的fin_moneyTotal的值，主要分为以下几步：
			 * 首先，读取要修改的数据对应得记录的money，计算fin_money修改前后的差值
			 * 然后，从该条数据起，下面的所有的数据都要相应地加上该差值
			 */
			Statement stmt_money;
			ResultSet rs_money;
			double fin_moneyOld;//更新前该条数据的消费或者收入金额
			double money = 0.00;//更改前后fin_money的差值
			try{
				//读取该条记录修改前的fin_money值
				stmt_money = conn.createStatement();
				String sql_money = "select fin_money from finance where fin_id='" + dto.fin_id + "'";
				rs_money = stmt_money.executeQuery(sql_money);
				if(rs_money.next()){
					fin_moneyOld = rs_money.getDouble("fin_money");
					money = dto.fin_money - fin_moneyOld;
					//从该条数据起，所有的记录的fin_totalMoney均加上前后之差
					Statement stmt_update = null;
					try{
						stmt_update = conn.createStatement();
						String sql_update = "update finance set fin_moneyTotal=fin_moneyTotal+ " + money + " where fin_id between '1' and " + dto.fin_id;
						stmt_update.executeUpdate(sql_update);
					}catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			//由于传输过来的fin_typeName,所以要读取数据库查询对应的fin_typeNameId
			int fin_type = 0;
			ResultSet rs_type = null;
			try{
				stmt = conn.createStatement();
				String sql = "select fin_typeNameId from finance_type where fin_typeName='" + dto.fin_type
						+ "' and fin_typeAttribute='" + dto.fin_typeAttribute + "'";
				rs_type = stmt.executeQuery(sql);
				if(rs_type.next()){
					fin_type = rs_type.getInt("fin_typeNameId");
				}
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				try{
					if(rs_type!=null)
					 rs_type.close();
					if(stmt!=null)
						stmt.close();
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
			String sql = "update finance set fin_type='" + fin_type + "',fin_money='" + dto.fin_money + "',fin_moneyTotal=fin_moneyTotal+"
					+ money + ",fin_time='" + dto.fin_time + "',fin_summary='" + dto.fin_summary + "' where fin_id='" + dto.fin_id + "'";
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			rtn = true;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return rtn;
	}
	//根据主键查找数据
	public FinanceDTO findFinanceByPrimaryKey(int fin_id){
		FinanceDTO dto = new FinanceDTO();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			String sql = "select * from finance where fin_id='" + fin_id + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				dto.user_id = rs.getInt("user_id");
				dto.fin_summary = rs.getString("fin_summary");
				dto.fin_time = rs.getString("fin_time");
				dto.fin_money = rs.getDouble("fin_money");
				dto.fin_moneyTotal = rs.getDouble("fin_moneyTotal");
				System.out.println(dto.fin_summary);
				//根据fin_typeNameId获取fin_typeName
				Statement stmt_type = null;
				ResultSet rs_type = null;
				try{
					stmt_type = conn.createStatement();
					String sql_type = "select fin_typeName from finance_type where fin_typeNameId='" 
							+ rs.getInt("fin_type") + "'";
					rs_type = stmt_type.executeQuery(sql_type);
					if(rs_type.next()){
						dto.fin_type = rs_type.getString("fin_typeName");
					}
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}finally{
					try{
						if(rs_type!=null){
							rs_type.close();
						}
						if(stmt_type!=null){
							stmt_type.close();
						}
						
					}catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null)
					rs.close();
				if(stmt!=null)
					stmt.close();
				if(conn!=null)
					conn.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}
		return dto;
	}
	//查找所有数据
	public List<FinanceDTO> findAllFinance(int user_id){
		ArrayList<FinanceDTO> voList = new ArrayList<FinanceDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			String sql = "select * from finance where user_id='" + user_id + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				FinanceDTO vo = new FinanceDTO();
				vo.fin_id = rs.getInt("fin_id");
				vo.fin_summary = rs.getString("fin_summary");
				vo.fin_time = rs.getString("fin_time");
				vo.fin_money = rs.getDouble("fin_money");
				vo.fin_moneyTotal = rs.getDouble("fin_moneyTotal");
				System.out.println(vo.fin_summary);
				//根据fin_typeNameId获取fin_typeName
				Statement stmt_type = null;
				ResultSet rs_type = null;
				try{
					stmt_type = conn.createStatement();
					String sql_type = "select fin_typeName from finance_type where fin_typeNameId='" 
							+ rs.getInt("fin_type") + "'";
					rs_type = stmt_type.executeQuery(sql_type);
					if(rs_type.next()){
						vo.fin_type = rs_type.getString("fin_typeName");
					}
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}finally{
					try{
						if(rs_type!=null){
							rs_type.close();
						}
						if(stmt_type!=null){
							stmt_type.close();
						}
						
					}catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
				voList.add(vo);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null)
					rs.close();
				if(stmt!=null)
					stmt.close();
				if(conn!=null)
					conn.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}
		return voList;
	}
	//查找一批数据
	public List<FinanceDTO> findAllFinanceInBatch(int page,int per,int user_id){
		List<FinanceDTO> list = new ArrayList<FinanceDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			String sql = "select * from finance where user_id='" + user_id + "' order by fin_id desc limit " + page + "," + per;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				FinanceDTO vo = new FinanceDTO();
				vo.fin_id = rs.getInt("fin_id");
				vo.fin_summary = rs.getString("fin_summary");
				vo.fin_time = rs.getString("fin_time");
				vo.fin_money = rs.getDouble("fin_money");
				vo.fin_moneyTotal = rs.getDouble("fin_moneyTotal");
				System.out.println(vo.fin_summary);
				//根据fin_typeNameId获取fin_typeName
				Statement stmt_type = null;
				ResultSet rs_type = null;
				try{
					stmt_type = conn.createStatement();
					String sql_type = "select fin_typeName from finance_type where fin_typeNameId='" 
							+ rs.getInt("fin_type") + "'";
					rs_type = stmt_type.executeQuery(sql_type);
					if(rs_type.next()){
						vo.fin_type = rs_type.getString("fin_typeName");
					}
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}finally{
					try{
						if(rs_type!=null){
							rs_type.close();
						}
						if(stmt_type!=null){
							stmt_type.close();
						}
						
					}catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
				list.add(vo);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null)
					rs.close();
				if(stmt!=null)
					stmt.close();
				if(conn!=null)
					conn.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}
		return list;
	}
	//统计所有数据的条数
	public int findAllFinanceCount(int user_id){
		int count=0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			//order by id limit 5,10 按照id的正序排序 从第5条开始取10条
			String sql = "select count(*) from finance where user_id='" + user_id + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				count = rs.getInt(1);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null)
					rs.close();
				if(stmt!=null)
					stmt.close();
				if(conn!=null)
					conn.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}
		return count;
	}

}
