<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
NewsTypesDao newsTypes = new NewsTypesDao();
AdminMenuDao adminmenu = new AdminMenuDao();

//Step2
f.addElement("news_type", null, "title:'news_type', required:true");
f.addElement("use_yn", null, "title:'use_yn'");
f.addElement("sort", null, "title:'sort'");

//Step3
if(m.isPost() && f.validate()) {

	newsTypes.item("news_type", f.get("news_type"));
	newsTypes.item("use_yn", f.get("use_yn"));
	newsTypes.item("sort", f.get("sort"));
	newsTypes.item("reg_date", m.time("yyyyMMddHHmmss"));
	newsTypes.item("status", 1);

	//blog.setDebug(out);
	if(!newsTypes.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
String pagetitle = "News Types"; 
String pageaction = "add"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/newstypes/create");
p.setVar("form_script", f.getScript());
p.print();

%>