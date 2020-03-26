<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = mediaTypes.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
f.addElement("media_type", info.s("media_type"), "title:'media_type', required:true");
f.addElement("use_yn", info.s("use_yn"), "title:'use_yn'");
f.addElement("sort", info.s("sort"), "title:'sort'");

//Step5
if(m.isPost() && f.validate()) {

	mediaTypes.item("media_type", f.get("media_type"));
	mediaTypes.item("use_yn", f.get("use_yn"));
	mediaTypes.item("sort", f.get("sort"));

	//blog.setDebug(out);
	if(!mediaTypes.update("id = " + id)) {
		m.jsAlert("Error occurred(update)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
String pagetitle = "Media Types"; 
String pageaction = "update"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/mediatypes/update");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>