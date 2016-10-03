function checkNull(){
	var user_name = document.getElementById("user_name").value;
	var user_pass = document.getElementById("user_pass").value;
	if(user_name==null || user_name==""){
		alert("账号不能为空！");
		return false;
	}else if(user_pass==null || user_pass==""){
		alert("密码不能为空！");
		return false;
	}
}

function show(o){
	//单击图片，即触发本命令，使得img标签的src改变，ie重新加载验证图片
	o.src="jspTool/checkCodeCreate.jsp?" + Math.random();
}