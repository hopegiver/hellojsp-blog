<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
MediaTypesDao mediaTypes = new MediaTypesDao();
AdminMenuDao adminmenu = new AdminMenuDao();

DataSet adminparentMenu = adminmenu .find("status != -1 AND parent_id = 0 AND menu_cat='admin'", "*", "sort");

p.setVar("adminparentMenu", adminparentMenu);
//Step2
f.addElement("media_type", null, "title:'media_type', required:true");
f.addElement("use_yn", null, "title:'use_yn'");
f.addElement("sort", null, "title:'sort'");

//Step3
if(m.isPost() && f.validate()) {

	mediaTypes.item("media_type", f.get("media_type"));
	mediaTypes.item("use_yn", f.get("use_yn"));
	mediaTypes.item("sort", f.get("sort"));
	mediaTypes.item("reg_date", m.time("yyyyMMddHHmmss"));
	mediaTypes.item("status", 1);

	//blog.setDebug(out);
	if(!mediaTypes.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
String pagetitle = "Media Types"; 
String pageaction = "add"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/mediatypes/create");
p.setVar("form_script", f.getScript());
p.print();

%>