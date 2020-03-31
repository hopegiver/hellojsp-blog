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

f.addElement("id", info.s("id"), "title:'ID', required:true");

//Step5
if(m.isPost() && f.validate()) {

	newsTypes.item("status", -1);
	//blog.setDebug(out);
	if(!newsTypes.update("id = " + id)) {
		m.jsAlert("Error occurred(delete)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
String pagetitle = "News Type"; 
String pageaction = "delete"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/newstypes/delete");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>