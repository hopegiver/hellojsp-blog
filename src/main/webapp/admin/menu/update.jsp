<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
AdminMenuDao adminmenu = new AdminMenuDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = adminmenu.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
f.addElement("menu_name", info.s("menu_name"), "title:'menu_name', required:true");
f.addElement("menu_cat", info.s("menu_cat"), "title:'menu_cat', required:false");
f.addElement("parent_id", info.s("parent_id"), "title:'parent_id', required:true");
f.addElement("sort", info.s("sort"), "title:'sort', required:true");
f.addElement("menu_url", info.s("menu_url"), "title:'menu_url', required:true");
f.addElement("menu_type", info.s("menu_type"), "title:'menu_type', required:false");
f.addElement("menu_depth", info.s("menu_depth"), "title:'menu_depth', required:true");
f.addElement("target", info.s("target"), "title:'target', required:false");
f.addElement("use_yn", info.s("use_yn"), "title:'use_yn', required:false");

//Step5
if(m.isPost() && f.validate()) {

	adminmenu.item("parent_id", f.get("parent_id"));
	adminmenu.item("menu_name", f.get("menu_name"));
	adminmenu.item("menu_cat", f.get("menu_cat"));
	adminmenu.item("menu_type", f.get("menu_type"));
	adminmenu.item("target", f.get("target"));	
	adminmenu.item("menu_depth", f.get("menu_depth"));
	adminmenu.item("menu_url", f.get("menu_url"));
	adminmenu.item("sort", f.get("sort"));
	adminmenu.item("use_yn", f.get("use_yn"));	

	//blog.setDebug(out);
	if(!adminmenu.update("id = " + id)) {
		m.jsAlert("Error occurred(update)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
p.setLayout("blog");
p.setBody("admin/menu/update");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>