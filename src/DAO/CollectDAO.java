package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DTO.collectDTO.CollectDTO;

public class CollectDAO {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		CollectDAO dao = new CollectDAO();
		CollectDTO dto = new CollectDTO();
		dto.col_address = "address_test";
		dto.col_name = "name_test";
		dto.user_id = 1;
		dao.createCollect(dto);
	}
	//增加数据
	public boolean createCollect(CollectDTO dto){
		boolean rtn = false;
		//先根据fin_id 读取数据，用于显示在编辑栏
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			String sql = "insert collect(col_address,col_name,user_id) values ('" + dto.col_address
			+ "','" + dto.col_name + "','" + dto.user_id + "')";
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			rtn = true;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(stmt!=null)
					stmt.close();
				if(conn!=null)
					conn.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return rtn;
	}
	//修改数据
	public boolean updateCollect(CollectDTO dto){
		boolean rtn = false;
		
		return rtn;
	}
	//根据主键查找数据
	public CollectDTO findCollectByPrimaryKey(int fin_id){
		CollectDTO dto = new CollectDTO();
		return dto;
	}
	//查找所有数据
	public List<CollectDTO> findAllCollect(){
		List<CollectDTO> list =  new ArrayList<CollectDTO>();
		
		return list;
	}
	//查找一批数据
	public List<CollectDTO> findAllUserInBatch(int page,int per){
		List<CollectDTO> list = new ArrayList<CollectDTO>();
		
		return list;
	}
	//统计所有数据的条数
	public int findAllCollectCount(int user_id){
		int count=0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			//order by id limit 5,10 按照id的正序排序 从第5条开始取10条
			String sql = "select count(*) from collect where user_id='" + user_id + "'";
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
