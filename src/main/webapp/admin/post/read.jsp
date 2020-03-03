<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
    PostDao post = new PostDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = post.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
info.put("user_id", m.htt(info.s("user_id")));
info.put("reg_date", m.time("yyyy-MM-dd HH:mm", info.s("reg_date")));

//Step5
p.setLayout("blog");
p.setBody("admin/post/read");
p.setVar("info", info);
p.print();

%>