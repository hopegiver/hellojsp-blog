<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
UserDao user = new UserDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = user.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
info.put("login_id", m.htt(info.s("login_id")));
info.put(m.sha256("passwd"), m.htt(info.s("passwd")));
info.put("reg_date", m.time("yyyy-MM-dd HH:mm", info.s("reg_date")));

//Step5
p.setLayout("blog");
p.setBody("sample/admin/read");
p.setVar("info", info);
p.print();

%>