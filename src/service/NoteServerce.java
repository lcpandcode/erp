package service;

import DAO.NoteDAO;
import DTO.noteDTO.NoteDTO;
import VO.noteVO.NoteAddVO;
import VO.noteVO.NoteUpdateVO;
import VO.noteVO.NoteViewVO;

public class NoteServerce {
	public static void main(String [] args){
		NoteServerce serverce = new NoteServerce();
		NoteAddVO vo = new NoteAddVO();
		vo.note_summary = "test222";
		vo.note_title = "test2222";
		vo.note_typeName = "高数笔记";
		vo.user_id = 1;
		serverce.noteAddDo(vo);
	}
	//新增方法
	public boolean noteAddDo(NoteAddVO vo){
		boolean rtn = false;
		NoteDAO dao = new NoteDAO();
		NoteDTO dto = new NoteDTO();
		dto.note_title = vo.note_title;
		dto.note_typeName = vo.note_typeName;
		dto.note_summary = vo.note_summary;
		dto.user_id = vo.user_id;
		rtn = dao.createNote(dto);
		return rtn;
	}
	//修改方法
	public boolean noteUpdateDo(NoteUpdateVO noteUpdateVO){
		boolean rtn = false;
		
		return rtn;
	}
	//删除方法
	public boolean noteDeleteDo(int note_id){
		boolean rtn = false;
		NoteDAO dao = new NoteDAO();
		rtn = dao.deleteNoteByNoteId(note_id);
		return rtn ;
	}
}
