package service;


import DAO.ScheduleDAO;
import DTO.scheduleDTO.ScheduleDTO;
import VO.financeVO.FinanceViewVO;
import VO.scheduleVO.ScheduleAddVO;
import VO.scheduleVO.ScheduleUpdateVO;

public class ScheduleServerce {
	/*
	 * 日程管理
	 * 
	 */
	//添加日程方法,成功返回true,否则返回false
	public boolean scheduleAddDo(ScheduleAddVO vo){
		boolean rtn = false;
		ScheduleDAO dao = new ScheduleDAO();
		ScheduleDTO dto = new ScheduleDTO();
		dto.sch_isDone = vo.sch_isDone;
		dto.sch_summary = vo.sch_summary;
		dto.sch_name = vo.sch_name;
		dto.user_id = vo.user_id;
		rtn = dao.createSchedule(dto);
		return rtn;
	}
	//修改日程方法，成功返回true,否则返回false
	public boolean scheduleUpdate(ScheduleUpdateVO vo){
		boolean rtn = false;
		ScheduleDAO dao = new ScheduleDAO();
		ScheduleDTO dto = new ScheduleDTO();
		dto.sch_id = vo.sch_id;
		if(vo.sch_updateTypeId==1){
			//修改完成状态
			dto.sch_completeTime = vo.sch_completeTime;
			dto.sch_isDone = vo.sch_isDone;
		}else if(vo.sch_updateTypeId==2){
			//修改内容
			dto.sch_summary = vo.sch_summary;
			dto.sch_name = vo.sch_name;
		}
		rtn = dao.updateSchedule(dto);
		return rtn ;
	}
	//删除日程方法
	public boolean scheduleDelete(int sch_id){
		boolean rtn = false;
		ScheduleDAO dao = new ScheduleDAO();
		rtn = dao.deleteScheduleBySchId(sch_id);
		return rtn;
	}
}
