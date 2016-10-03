package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DTO.userDTO.UserDTO;

public class UserDAO {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UserDAO dao= new UserDAO();
		
		UserDTO dto = new UserDTO();
		dto.user_id = 2;
		dto.user_name = "修改了user_name";
		dao.updateUser(dto);
		
		//dao.findAllUserCount();
	}
	//增加数据
	public boolean createUser(UserDTO dto){
		boolean rtn = false;
		//进行数据库操作
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "insert into user (user_name,user_pass,user_phone,user_email,user_photo,user_summary) values('"
					+ dto.user_name + "','" + dto.user_pass + "','" + dto.user_phone + "','" 
					+dto.user_email + "','" + dto.user_photo + "','" + dto.user_summary + "')";
			stmt.executeUpdate(sql);
			rtn = true;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return rtn;
	}
	//修改数据
	public boolean updateUser(UserDTO dto){
		boolean rtn = false;
		//数据库操作
		Connection conn = null;
		Statement stmt = null;
		try{
			//修改和插入数据基本一样，只是sql操作不同而已
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			//根据要修改的业务项进行sql拼接
			String sql = "update user set user_id=user_id ";
			if(dto.user_name!=null && !"".equals(dto.user_name)){
				sql = sql + ",user_name='" + dto.user_name + "' ";
			}
			if(dto.user_pass!=null && !"".equals(dto.user_pass)){
				sql = sql + ",user_pass='" + dto.user_pass + "' ";
			}
			if(dto.user_email!=null && !"".equals(dto.user_email)){
				sql = sql + ",user_email='" + dto.user_email + "'";
			}
			if(dto.user_photo!=null && !"".equals(dto.user_photo)){
				sql = sql + ",user_photo='" + dto.user_photo + "'";
			}
			if(dto.user_phone!=-1){
				sql = sql + ",user_phone='" + dto.user_phone + "'";
			}
			if(dto.user_summary!=null && !"".equals(dto.user_summary)){
				sql = sql + ",user_summary='" + dto.user_summary + "'";
			}
			sql = sql + "where user_id='" + dto.user_id + "'";
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
	public UserDTO findUserByPrimaryKey(int user_id){
		UserDTO dto = new UserDTO();
		//数据库操作
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from user where user_id='" + user_id + "'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				dto.user_email = rs.getString("user_email");
				dto.user_name = rs.getString("user_name");
				dto.user_pass = rs.getString("user_pass");
				dto.user_photo = rs.getString("user_photo");
				dto.user_phone = rs.getInt("user_phone");
				dto.user_summary = rs.getString("user_summary");
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
	//查找所有数据
	public List<UserDTO> findAllUser(){
		List<UserDTO> list =  new ArrayList<UserDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from user";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				UserDTO dto = new UserDTO();
				dto.user_name = rs.getString("user_name");
				dto.user_pass = rs.getString("user_pass");
				dto.user_email = rs.getString("user_email");
				dto.user_photo = rs.getString("user_photo");
				dto.user_phone = rs.getInt("user_phone");
				dto.user_summary = rs.getString("user_summary");
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
	//查找一批数据
	public List<UserDTO> findAllUserInBatch(int page,int per){
		List<UserDTO> list = new ArrayList<UserDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from user where user_id between '" + page  + "' and '" + per + "'";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				UserDTO dto = new UserDTO();
				dto.user_name = rs.getString("user_name");
				dto.user_pass = rs.getString("user_pass");
				dto.user_email = rs.getString("user_email");
				dto.user_photo = rs.getString("user_photo");
				dto.user_phone = rs.getInt("user_phone");
				dto.user_summary = rs.getString("user_summary");
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
	//统计所有数据的条数
	public int findAllUserCount(){
		int count=0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select count(user_id) from user";
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

}
