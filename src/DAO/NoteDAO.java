package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DTO.financeDTO.FinanceDTO;
import DTO.noteDTO.NoteDTO;
import DTO.scheduleDTO.ScheduleDTO;

public class NoteDAO {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		NoteDAO dao = new NoteDAO();
		//NoteDTO dto = new NoteDTO();
		
		//ArrayList<NoteDTO> list = (ArrayList<NoteDTO>)dao.findAllNote(1);
		NoteDTO dto = new NoteDTO();
		dao.deleteNoteByNoteId(1);
	}
	//增加数据
	public boolean createNote(NoteDTO dto){
		boolean rtn = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int note_typerNameId = -1 ;
		//根据note_typeName获取note_typeNameId
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select note_typeNameId from note_type where note_typeName='" + dto.note_typeName + "'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				note_typerNameId = rs.getInt("note_typeNameId");
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null)
					rs.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		//进行数据插入操作
		if(note_typerNameId!=-1){
			try{
				String sql = "insert note (note_title,note_type,note_summary,user_id) values ('" + dto.note_title
						+ "','" + note_typerNameId + "','" + dto.note_summary + "','" + dto.user_id + "')";
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
		}
		
		return rtn;
	}
	//修改数据
	public boolean updateNote(NoteDTO dto){
		boolean rtn = false;
		
		return rtn;
	}
	//根据主键查找数据
	public NoteDTO findNoteByPrimaryKey(int fin_id){
		NoteDTO dto = new NoteDTO();
		
		return dto;
	}
	//根据user_id查找所有数据
	public List<NoteDTO> findAllNote(int user_id){
		List<NoteDTO> list =  new ArrayList<NoteDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select * from note,note_type where note.note_type=note_type.note_typeNameId and note.user_id='" + user_id + "'";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				NoteDTO dto = new NoteDTO();
				dto.note_createTime = rs.getString("note_createTime");
				dto.note_title = rs.getString("note_title");
				dto.note_typeName = rs.getString("note_typeName");
				dto.note_id = rs.getInt("note_id");
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
	public List<NoteDTO> findAllNoteInBatch(int page,int per,int user_id){
		List<NoteDTO> list = new ArrayList<NoteDTO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			String sql = "select * from note,note_type where user_id='" + user_id + "' and note.note_type=note_type.note_typeNameId order by note_id desc limit " + page + "," + per;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				NoteDTO vo = new NoteDTO();
				vo.note_id = rs.getInt("note_id");
				vo.note_summary = rs.getString("note_summary");
				vo.note_createTime = rs.getString("note_createTime");
				vo.note_title = rs.getString("note_title");
				vo.note_typeName = rs.getString("note_typeName");
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
	public int findAllNoteCount(int user_id){
		int count=0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			//order by id limit 5,10 按照id的正序排序 从第5条开始取10条
			String sql = "select count(*) from note where user_id='" + user_id + "'";
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
	
	//其他方法、
	//根据note_id获取note_summary
	public String findNoteSummaryByNoteId(int note_id){
		String rtn = "该条笔记没有内容！";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "select note_summary from note where note_id='" + note_id + "'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				rtn = rs.getString(1);
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
		return rtn;
	}
	//删除数据
	public boolean deleteNoteByNoteId(int note_id){
		boolean rtn = false;
		//数据库操作
		Connection conn = null;
		Statement stmt = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mynote","root","root");
			stmt = conn.createStatement();
			String sql = "delete from note where note_id='" + note_id + "'";
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
