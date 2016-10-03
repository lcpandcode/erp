package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.jms.Session;

import DAO.UserDAO;
import DTO.userDTO.UserDTO;
import VO.userVO.userAddVO;
import VO.userVO.userLoginVO;
import VO.userVO.userUpdateVO;

public class UserServerce {
	//全局变量,存储用户id
	public int user_id = 0;
	/*
	public ResumeServerce(int user_id) {
		// TODO Auto-generated constructor stub
		this.user_id = user_id;
	}
	*/
	/*
	 * part 1：用户信息相关
	 */
	//登录方法,通过验证，返回user_id，账号或者密码错误返回-1,数据库操作错误，返回-2
	public int loginDo(userLoginVO resLoginVO){
		int rtn = -1;
		//进行数据库操作
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select user_id from user where user_name='" + resLoginVO.user_name + "'and user_pass='" 
					+ resLoginVO.user_pass + "'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				rtn = rs.getInt("user_id");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		return rtn;
	}
	//注册方法,成功返回true,否则返回false
	public boolean registerDo(userAddVO vo){
		boolean rtn = false;
		UserDTO dto = new UserDTO();
		dto.user_email = vo.user_email;
		dto.user_name = vo.user_name;
		dto.user_pass = vo.user_pass;
		dto.user_phone = vo.user_phone;
		dto.user_photo = vo.user_photo;
		dto.user_summary = vo.user_summary;
		UserDAO dao = new UserDAO();
		rtn = dao.createUser(dto);
		return rtn;
	}
	//修改用户信息,成功返回true,否则返回false
	public boolean alterResumeDo(userUpdateVO  resUpdateVO){
		boolean rtn = false;
		
		return rtn;
	}
	public boolean deleteResumeDo(){
		boolean rtn = false; 
		
		return rtn ;
	}
	
	
}
