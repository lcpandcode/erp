package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;



import DAO.FinanceDAO;
import DTO.financeDTO.FinanceDTO;
import VO.financeVO.FinanceAddVO;
import VO.financeVO.FinanceUpdateVO;
import VO.financeVO.FinanceViewVO;
import VO.financeVO.FinanceDeleteVO;

public class FinanceServerce {
	public static void main(String [] args){
		FinanceServerce serverce = new FinanceServerce();
		FinanceDeleteVO vo = new FinanceDeleteVO();
		vo.fin_money = -2000;
		vo.fin_id = 5;
		vo.user_id = 1;
		serverce.financeDeleteDo(vo);
	}
	/*
	 * part2：财务管理方法
	 */
	//查看财务,返回一个结果集
	/*
	public List<FinanceViewVO> financeViewDo(int user_id){
		FinanceDAO dto = new FinanceDAO();
		List<Fi>
		return ;
	}
	*/
	//修改财务,成功返回true,否则返回false
	public boolean financeUpdateDo(FinanceUpdateVO vo){
		boolean rtn = false ;
		FinanceDAO dao = new FinanceDAO();
		FinanceDTO dto = new FinanceDTO();
		dto.fin_type = vo.fin_typeName;
		dto.fin_id = vo.fin_id;
		dto.fin_money = vo.fin_money;
		dto.fin_summary = vo.fin_summary;
		dto.fin_time = vo.fin_time;
		dto.fin_typeAttribute = vo.fin_typeAttribute;
		dto.fin_moneyTotal = vo.fin_moneyTotal;
		dto.user_id = vo.user_id;
		rtn = dao.updateFinance(dto);
		return rtn;
	}
	
	//增加财务,成功返回true,否则返回false
	public boolean financeAddDo(FinanceAddVO vo ){
		boolean rtn = false;
		FinanceDTO dto = new FinanceDTO();
		dto.fin_money = vo.fin_money;
		dto.fin_summary = vo.fin_summary;
		dto.fin_time = vo.fin_time;
		dto.fin_type = vo.fin_typeName;
		dto.fin_typeAttribute = vo.fin_typeAttribute;
		dto.user_id = vo.user_id;
		FinanceDAO dao = new FinanceDAO();
		rtn = dao.createFinance(dto);
		return rtn;
	}
	//删除财务
	public boolean financeDeleteDo(FinanceDeleteVO vo){
		int user_id = vo.user_id;
		int fin_id = vo.fin_id;
		double fin_money = vo.fin_money;
		boolean rtn = false;
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			//根据fin_id获取该记录的fin_moneyTotal值，相应地更新其他记录的fin_totalMoney值,由该条记录开始，所有该用户的记录相应地减去要删除的数据的fin_moneyTotal
			Statement stmt_update = null;
			try{
				stmt_update = conn.createStatement();
				//获取最后一条数据对应的user_id
				Statement stmt_getLast = null;
				ResultSet rs_getLast = null;
				int fin_idLast = fin_id + 1;//user_idLast初始化为user_id+1
				try{
					stmt_getLast = conn.createStatement();
					String sql_get = "select max(fin_id) from finance where user_id='" + user_id + "'";
					rs_getLast = stmt_getLast.executeQuery(sql_get);
					if(rs_getLast.next()){
						fin_idLast = rs_getLast.getInt(1);
					}
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}finally{
					rs_getLast.close();
					stmt_getLast.close();
				}
				String sql_update = "update finance set fin_moneyTotal=(fin_moneyTotal - " + fin_money + ") where user_id='" + user_id
						+ "'and fin_id between '"+ (fin_id+1) + "'and '" + (fin_idLast+1) + "'";
				stmt_update.executeUpdate(sql_update);
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			stmt = conn.createStatement();
			String sql = "delete from finance where fin_id='" + fin_id + "'";
			stmt.executeUpdate(sql);
			rtn = true;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
		}finally{
			try{
				if(stmt!=null){
					stmt.close();
				}
				if(conn!=null){
					conn.close();
				}
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}
		return rtn ;
	}
}
