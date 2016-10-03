package service;

import VO.collectVO.CollectAddVO;
import VO.scheduleVO.ScheduleAddVO;
import DAO.CollectDAO;
import DAO.ScheduleDAO;
import DTO.collectDTO.CollectDTO;

public class CollectServerce {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	//add方法
	public boolean collectAdd(CollectAddVO  vo){
		boolean rtn = false;
		CollectDAO dao = new CollectDAO();
		CollectDTO dto = new CollectDTO();
		dto.col_address = vo.col_address;
		dto.col_name = vo.col_name;
		dto.user_id = vo.user_id;
		rtn = dao.createCollect(dto);
		return rtn;
	}
	
}
