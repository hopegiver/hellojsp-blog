<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
NewsTypesDao newsTypes = new NewsTypesDao();
AdminMenuDao adminmenu = new AdminMenuDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = newsTypes.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
f.addElement("title", info.s("title"), "title:'title', required:true");
f.addElement("use_yn", info.s("use_yn"), "title:'use_yn'");
f.addElement("sort", info.s("sort"), "title:'sort'");

//Step5
if(m.isPost() && f.validate()) {

	newsTypes.item("title", f.get("title"));
	newsTypes.item("use_yn", f.get("use_yn"));
	newsTypes.item("sort", f.get("sort"));

	//blog.setDebug(out);
	if(!newsTypes.update("id = " + id)) {
		m.jsAlert("Error occurred(update)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
String pagetitle = "News Types"; 
String pageaction = "update"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/newstypes/update");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>