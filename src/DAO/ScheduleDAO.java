package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


import DTO.scheduleDTO.ScheduleDTO;
import DTO.userDTO.UserDTO;

public class ScheduleDAO {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//测试代码
		ScheduleDAO dao = new ScheduleDAO();
		
		ScheduleDTO dto = new ScheduleDTO();
		dto.sch_id = 1;
		dto.sch_summary = "修改了id一";
		dao.findAllFinishScheduleInBatch(0,6,1,1);
		/*
		dao.createSchedule(dto);
		*/
		
	}
	//增加数据
	public boolean createSchedule(ScheduleDTO dto){
		boolean rtn = false;
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "insert into schedule (sch_isDone,sch_summary,sch_name,user_id) values ('0','"
					+ dto.sch_summary + "','" + dto.sch_name + "','" + dto.user_id + "')";
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
		return rtn;
	}
	//修改数据
	public boolean updateSchedule(ScheduleDTO dto){
		boolean rtn = false;
		//数据库操作
		Connection conn = null;
		Statement stmt = null;
		try{
			//修改和插入数据基本一样，只是sql操作不同而已
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "update schedule set sch_id=sch_id";
			if(dto.sch_isDone!=-1){
				sql = sql + ",sch_isDone='" + dto.sch_isDone + "' ";
			}
			if(dto.sch_summary!=null && !"".equals("dto.sch_summary")){
				sql = sql + ",sch_summary='" + dto.sch_summary + "' ";
			}
			
			if(dto.sch_completeTime!=null && !"".equals("dto.sch_completeTime")){
				sql = sql + ",sch_completeTime='" + dto.sch_completeTime + "' ";
			}else{
				sql = sql + ",sch_completeTime=" + dto.sch_completeTime + " ";
			}
			
			if(dto.sch_name!=null && !"".equals(dto.sch_name)){
				sql = sql + ",sch_name='" + dto.sch_name + "'";
			}
			sql = sql + "where sch_id='" + dto.sch_id + "'";
			stmt.executeUpdate(sql);
			rtn = true;
		}catch(Exception e){
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
		return rtn;
	}
	//根据主键查找数据
	public ScheduleDTO findScheduleByPrimaryKey(int sch_id){
		ScheduleDTO dto = new ScheduleDTO();
		//数据库操作
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from schedule where sch_id='" + sch_id + "'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				dto.sch_isDone = rs.getInt("sch_isDone");
				dto.sch_completeTime = rs.getString("sch_completeTime");
				dto.sch_summary = rs.getString("sch_summary");
				dto.user_id = rs.getInt("user_id");
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
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
		return dto;
	}
	//查找对应用户的所有数据
	public List<ScheduleDTO> findAllSchedule(int user_id){
		List<ScheduleDTO> list =  new ArrayList<ScheduleDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from schedule where user_id='" + user_id + "'";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				ScheduleDTO dto = new ScheduleDTO();
				dto.sch_completeTime = rs.getString("sch_completeTime");
				dto.sch_isDone = rs.getInt("sch_isDone");
				dto.user_id = rs.getInt("user_id");
				dto.sch_summary = rs.getString("sch_summary");
				list.add(dto);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
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
		return list;
	}
	//查找一批数据(根据user_id，完成状态
	public List<ScheduleDTO> findAllScheduleInBatch(int page,int per,int user_id){
		List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from schedule where user_id='" + user_id + "' order by sch_createTime desc limit " + page + "," + per;
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				ScheduleDTO dto = new ScheduleDTO();
				dto.sch_completeTime = rs.getString("sch_completeTime");
				dto.sch_isDone = rs.getInt("sch_isDone");
				dto.user_id = rs.getInt("user_id");
				dto.sch_summary = rs.getString("sch_summary");
				dto.sch_name = rs.getString("sch_name");
				list.add(dto);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
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
		return list;
	}
	//根据完成状态读取一批数据
	public List<ScheduleDTO> findAllFinishScheduleInBatch(int page,int per,int user_id,int sch_isDone){
		List<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from schedule where user_id='" + user_id + "'and sch_isDone='" + sch_isDone + "' order by sch_createTime desc limit " + page + "," + per;
			rs = stmt.executeQuery(sql);
			if(sch_isDone==1){
				while(rs.next()){
					ScheduleDTO dto = new ScheduleDTO();
					dto.sch_completeTime = rs.getString("sch_completeTime");
					dto.user_id = rs.getInt("user_id");
					dto.sch_summary = rs.getString("sch_summary");
					dto.sch_id = rs.getInt("sch_id");
					dto.sch_createTime = rs.getString("sch_createTime");
					dto.sch_name = rs.getString("sch_name");
					list.add(dto);
				}
			}else{
				while(rs.next()){
					ScheduleDTO dto = new ScheduleDTO();
					dto.sch_createTime = rs.getString("sch_createTime");
					dto.user_id = rs.getInt("user_id");
					dto.sch_summary = rs.getString("sch_summary");
					dto.sch_id = rs.getInt("sch_id");
					dto.sch_name = rs.getString("sch_name");
					list.add(dto);
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
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
		return list;
	} 
	//统计所有数据的条数
	public int findAllScheduleCount(int user_id){
		int count=0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select count(*) from schedule where user_id='" + user_id + "'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				count = rs.getInt(1);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
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
		return count;
	}
	//根据sch_id删除数据
	public boolean deleteScheduleBySchId(int sch_id){
		boolean rtn = false;
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "delete from schedule where sch_id='" + sch_id + "'";
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
		return rtn;
	}

}
