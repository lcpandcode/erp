package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import DTO.financeType.FinanceTypeDTO;



public class FinanceTypeDAO {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		FinanceTypeDAO dao = new FinanceTypeDAO();
		dao.findAllTypeByAttribute(1);
	}
	public FinanceTypeDTO findAllTypeByAttribute(int fin_typeAttribute){
		FinanceTypeDTO dto = new FinanceTypeDTO();
		dto.fin_typeName = new ArrayList<String>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			String sql = "select fin_typeName from finance_type where fin_typeAttribute='" + fin_typeAttribute + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				dto.fin_typeName.add(rs.getString("fin_typeName"));
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
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
}
