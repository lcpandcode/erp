package VO.scheduleVO;

public class ScheduleUpdateVO {
	public int sch_id;
	public int sch_isDone;
	public String sch_createTime = null;
	public String sch_completeTime = null;
	public int sch_updateTypeId;//用于标记修改说明内容，1的时候表示修改状态，2的时候哦表示修改内容
	public String sch_summary = null;
	public String sch_name = null;
	/*
	public ScheduleUpdateVO(int sch_id) {
		// TODO Auto-generated constructor stub
		this.sch_id = sch_id;
	}
	public void setSch_id(int sch_id){
		this.sch_id = sch_id;
	}
	public void setSch_isdone(int sch_isdone){
		this.sch_isdone = sch_isdone;
	}
	public void setSch_createtime(String sch_createtime){
		this.sch_createtime = sch_createtime;
	}
	public void setSch_completetime(String sch_completetime){
		this.sch_completetime = sch_completetime;
	}
	*/
}
