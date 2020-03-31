<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
AdminMenuDao adminmenu = new AdminMenuDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = adminmenu.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
info.put("parent_id", m.htt(info.s("parent_id")));
info.put("menu_name", m.htt(info.s("menu_name")));
info.put("menu_url", m.htt(info.s("menu_url")));
info.put("menu_type", m.htt(info.s("menu_type")));
info.put("menu_depth", m.htt(info.s("menu_depth")));
info.put("menu_cat", m.htt(info.s("menu_cat")));
info.put("target", m.htt(info.s("target")));
info.put("sort", m.htt(info.s("sort")));
info.put("use_yn", m.htt(info.s("use_yn")));
info.put("reg_date", m.time("yyyy-MM-dd HH:mm", info.s("reg_date")));

//Step5
p.setLayout("blog");
p.setBody("admin/menu/read");
p.setVar("info", info);
p.print();

%>