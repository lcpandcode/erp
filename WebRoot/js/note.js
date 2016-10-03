//修改时数据加载函数
function whenUpdate(){
	var rowValue = this.parentNode;
	var note_title = rowValue.cells[0];
	var note_typeName = rowValue.cells[1];
	var note_summary = rowValue.cells[2];
}
//取消修改
function cancel_update(){
	document.getElementById("new-project2").style.display="none";
}
//取消增加
function cancel_add(){
	document.getElementById("new-project1").style.display="none";
}
function addNewNote(){
	document.getElementById("new-project1").style.display="";
	return false;
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