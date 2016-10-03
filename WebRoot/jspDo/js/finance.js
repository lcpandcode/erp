function close_project1(){
	document.getElementById("new-project1").style.display = "none";
	document.getElementById("new-project2").style.display = "";
	alert("test");
}
function close_project2(){
	document.getElementById("new-project2").style.display = "none";
	document.getElementById("new-project1").style.display = "";
}
function alter(){
	var fin_typeAttribute = document.getElementById(elementId)
}
function reminder_finTypeSelect(){
	if(document.getElementById("fin_typeAttribute3").value=="-- 消费类型 --"){
		alert("请选择消费记录的类型！");
	}
	if(document.getElementById("fin_type3").value="")
}
function fin_show(){
	var rowValue = this.parentNode;
	document.getElementById("new-project3").diplay.type="";
	document.getElementById("fin_typeAttribute3").value=rowValue.cells[0];
	document.getElementById("fin_type3").value=roeValue.cells[1];
	document.getElementById("fin_money3").value=roeValue.cells[2];
	document.getElementById("fin_time3").value=rowValue.cells[3];
	document.getElementById("fin_summary3").value=rowValue.cells[4];
	
}
//用户选择了记录类型为收入时调用该函数
function fin_shoeIncome(){
	document.getElementById("fin_moneyLabel").value="收入金额";
	document.getElementById("fin_timeLabel").value="收入时间";
	document.getElementById("fin_summaryLabel").value="收入说明";
	document.getElementById("fin_type3Div1").value="";
	document.getElementById("fin_type3Div1").value="none";
}
function fin_showOutLay (){
	document.getElementById("fin_moneyLabel").value="消费金额";
	document.getElementById("fin_timeLabel").value="消费时间";
	document.getElementById("fin_summaryLabel").value="消费说明";
	document.getElementById("fin_type3Div1").value="none";
	document.getElementById("fin_type3Div1").value="";
}