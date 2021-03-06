<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

if(userId == null){
	m.jsAlert("Need to login");
	m.jsReplace("/admin/login.jsp", "window");
}
//Step1
AdminUserDao adminuser = new AdminUserDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = adminuser.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
info.put("login_id", m.htt(info.s("login_id")));
info.put(m.sha256("passwd"), m.htt(info.s("passwd")));
info.put("reg_date", m.time("yyyy-MM-dd HH:mm", info.s("reg_date")));

//Step5
p.setLayout("blog");
p.setBody("admin/user/read");
p.setVar("info", info);
p.print();

%>