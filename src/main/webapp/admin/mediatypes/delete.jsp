<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
MediaTypesDao mediaTypes = new MediaTypesDao();
AdminMenuDao adminmenu = new AdminMenuDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = mediaTypes.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

f.addElement("id", info.s("id"), "title:'ID', required:true");

//Step5
if(m.isPost() && f.validate()) {

	mediaTypes.item("status", -1);
	//blog.setDebug(out);
	if(!mediaTypes.update("id = " + id)) {
		m.jsAlert("Error occurred(delete)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
String pagetitle = "Media Types"; 
String pageaction = "delete"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/mediatypes/delete");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>