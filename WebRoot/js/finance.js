// 检查跳转页码输入框是否为空
function checkPageInput() {
	var rtn = true;
	// 判断页码输入是否为空
	if (document.getElementById("pages").value == null
			|| document.getElementById("pages").value == "") {
		alert("请输入页码！");
		rtn = false;
	}
	return rtn;
}
// 检查添加表单输入是否为空
function checkAddFinanceForm1() {
	var fin_money = document.getElementById("fin_money1").value;
	var fin_time = document.getElementById("fin_time1").value;
	var fin_type = document.getElementById("fin_type1").value;
	var fin_summary = document.getElementById("fin_summary1").value;
	if (fin_money == "" || fin_money == null) {
		alert("请输入消费金额！");
		return false;
	} else if (fin_time == null || fin_time == "") {
		alert("请输入消费时间");
		return false;
	} else if (fin_type == "-- 消费类型 --") {
		alert("请选择消费类型！");
		return false;
	} else if (fin_summary == null || fin_summary == "") {
		alert("请输入消费内容");
		return false;
	}
	return true;
}
function checkAddFinanceForm2() {
	var fin_money = document.getElementById("fin_money2").value;
	var fin_time = document.getElementById("fin_time2").value;
	var fin_type = document.getElementById("fin_type2").value;
	var fin_summary = document.getElementById("fin_summary2").value;
	if (fin_money == "" || fin_money == null) {
		alert("请输入收入金额！");
		return false;
	} else if (fin_time == null || fin_time == "") {
		alert("请输入收入时间");
		return false;
	} else if (fin_type == "-- 收入类型 --") {
		alert("请选择收入类型！");
		return false;
	} else if (fin_summary == null || fin_summary == "") {
		alert("请输入收入内容");
		return false;
	}
	return true;
}
function close_project1() {
	document.getElementById("new-project1").style.display = "none";
	document.getElementById("new-project2").style.display = "";
}
function close_project2() {
	document.getElementById("new-project2").style.display = "none";
	document.getElementById("new-project1").style.display = "";
}
function alter() {
	var fin_typeAttribute = document.getElementById(elementId)
}
function reminder_finTypeSelect() {
	if (document.getElementById("fin_typeAttribute3").value == "-- 消费类型 --") {
		alert("请选择消费记录的类型！");
	}
	// if(document.getElementById("fin_type3").value="")
}
function fin_show() {
	var rowValue = this.parentNode;
	var cells = rowValue.cells;
	document.getElementById("new-project3").style.diplay = "";
	document.getElementById("fin_typeAttribute3").value = rowValue.cells[0];
	document.getElementById("fin_type3").value = roeValue.cells[1];
	document.getElementById("fin_money3").value = roeValue.cells[2];
	document.getElementById("fin_time3").value = rowValue.cells[3];
	document.getElementById("fin_summary3").value = rowValue.cells[4];

}
// 用户选择了记录类型为收入时调用该函数
function finChangeUpdate() {
	var selectValue = document.getElementById("fin_typeAttribute3").value;
	if (selectValue == "支出") {
		document.getElementById("fin_moneyLabel").value = "消费金额";
		document.getElementById("fin_timeLabel").value = "消费时间";
		document.getElementById("fin_summaryLabel").value = "消费说明";
		document.getElementById("fin_type3Income").style.display = "none";
		document.getElementById("fin_type3Income").disabled = "disabled";
		document.getElementById("fin_type3Outlay").style.display = "";
	} else {
		document.getElementById("fin_moneyLabel").value = "收入金额";
		document.getElementById("fin_timeLabel").value = "收入时间";
		document.getElementById("fin_summaryLabel").value = "收入说明";
		document.getElementById("fin_type3Income").style.display = "";
		document.getElementById("fin_type3Outlay").style.display = "none";
		document.getElementById("fin_type3Outlay").disabled = "disabled";
	}
}

// 取消修改
function cancel_update() {
	document.getElementById("new-project3").style.display = "none";
}
// 取消增加收入记录
function cancel_addAddIncome() {
	document.getElementById("new-project2").style.display = "none";
}
// 取消增加支出记录
function cancel_addAddOutlay() {
	document.getElementById("new-project1").style.display = "none";
}
function checkDoLastPage(page) {
	var rtn = true;
	if (page == 1) {
		alert("当前是首页！");
		rtn = false;
	}
	return rtn;
}
function checkDoNextPage(page, totalPage) {
	var rtn = true;
	if (page == totalPage) {
		alert("当前已是最后一页");
		rtn = false;
	}
	return rtn;
}
function financeViewLoad(fin_money) {
	if (fin_money >= 0) {
		document.getElementById("recordTypeInput").value = "收入";
		document.getElementById("financeTypeLabel").innerHTML = "收入类型";
		document.getElementById("financeMoneyLabel").innerHTML = "收入金额";
		document.getElementById("financeSummaryLabel").innerHTML = "收入说明";
		document.getElementById("financeTimeLabel").innerHTML = "收入时间";
	} else {
		document.getElementById("recordTypeInput").value = "支出";
		document.getElementById("financeTypeLabel").innerHTML = "支出类型";
		document.getElementById("financeMoneyLabel").innerHTML = "支出金额";
		document.getElementById("financeSummaryLabel").innerHTML = "支出说明";
		document.getElementById("financeTimeLabel").innerHTML = "消费时间";
	}
}