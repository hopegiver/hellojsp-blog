<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step2
f.addElement("s_keyword", null, null);

//Step3
ListManager lm = new ListManager();
//lm.setDebug(out);
lm.setRequest(request);
lm.setTable("tb_media_types a");
lm.setFields("a.*");
lm.addWhere("a.status != -1");
lm.addSearch("a.media_type", f.get("s_keyword"), "LIKE");
lm.setOrderBy("a.id DESC");

//Step3
DataSet list = lm.getDataSet();
while(list.next()) {
	list.put("reg_date", m.time("yyyy-MM-dd", list.s("reg_date")));
}

//Step4
//p.setDebug(out);
String pagetitle = "Media Types"; 
String pageaction = "list"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/mediatypes/index");
p.setVar("list", list);
p.setVar("total_cnt", lm.getTotalNum());
p.setVar("pagebar", lm.getPaging());
p.setVar("form_script", f.getScript());
p.print();

%>