<%@ page language="java" contentType="text/html; charset=UTF-8"%><%@ include file="/init.jsp" %><%

//Step1
BlogDao blog = new BlogDao();

//Step2
f.addElement("s_keyword", null, null);

//Step3
ListManager lm = new ListManager();
//lm.setDebug(out);
lm.setRequest(request);
lm.setTable("tb_blog a");
lm.setFields("a.*");
lm.addWhere("status != -1");
lm.addSearch("a.subject, a.content", f.get("s_keyword"), "LIKE");
lm.setOrderBy("a.id DESC");

//Step3
DataSet list = lm.getDataSet();
while(list.next()){
	list.put("reg_date", m.time("YYYY-MM-DD", list.s("reg_date")));
}

//Step4
p.setDebug(out);
p.setLayout("blog");
p.setBody("sample/index");
p.setVar("list", list);
p.setVar("total_cnt", lm.getTotalNum());
p.setVar("pagevar", lm.getPaging());
p.setVar("form_script", f.getScript());
p.print();

%>
