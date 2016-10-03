//取消增加
function cancelAdd(){
	document.getElementById("sch_name").value="";
	document.getElementById("sch_summary").value="";
	document.getElementById("new-task").style.display="none";
}

//确定删除弹出窗口
function confirmDelete(){
	
}
//修改日程记录时初始化修改页面数据的函数
function showUpdateScheudle(sch_id){
	changeAction(sch_id);
	var sch_summary = document.getElementById("schSummaryShow").innerHTML;
	var sch_name = document.getElementById("schNameShow").innerHTML;
	document.getElementById("new-task2").style.display="";
	document.getElementById("sch_summary2").value=sch_summary;
	document.getElementById("sch_name2").value=sch_name;
}
function cancelAdd(){
	document.getElementById("new-task1").style.display="none";
}
function cancelUpdate(){
	document.getElementById("new-task2").style.display="none";
}
function showAddSchedule(){
	document.getElementById("new-task1").style.display="";
}
function changeAction(sch_id){
	document.getElementById("new-task2").action="jspDo/schedulesUpdateDo.jsp?sch_updateTypeId=2&sch_id=" + sch_id + "&sch_updateIsDoType=0";
}
function checkDoLastPage(page){
	var rtn = true;
	if(page==1){
		alert("当前是首页！");
		rtn =  false;
	}
	return rtn;
}
function checkDoNextPage(page,totalPage){
	var rtn = true;
	if(page==totalPage){
		alert("当前已是最后一页");
		rtn = false;
	}
	return rtn;
}
function addSchedule(){
	document.getElementById("new-task").style.display="";
	return false;
}