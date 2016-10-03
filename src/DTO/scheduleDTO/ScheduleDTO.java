package DTO.scheduleDTO;

public class ScheduleDTO {
	public int user_id;
	public String sch_summary;
	public String sch_name;
	public int sch_isDone = -1;//初始化为-1,如果该变量被修改，表明要对日程表进行修改
	public String sch_completeTime;
	public int sch_id; 
	public String sch_createTime = null;
}
