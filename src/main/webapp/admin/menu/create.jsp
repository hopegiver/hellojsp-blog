<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

if(userId == null){
	m.jsAlert("Need to login");
	m.jsReplace("/admin/login.jsp", "window");
}
//Step1
AdminMenuDao adminmenu = new AdminMenuDao();

DataSet parentMenu = adminmenu.find("status != -1 AND parent_id = 0", "*", "sort");

DataSet subMenu = adminmenu.find("status != -1 AND parent_id != 0", "*", "sort");

//Step2
f.addElement("menu_name", null, "title:'menu_name', required:true");
f.addElement("menu_cat", null, "title:'menu_cat', required:false");
f.addElement("parent_id", null, "title:'parent_id', required:true");
f.addElement("sort", null, "title:'sort', required:true");
f.addElement("menu_url", null, "title:'menu_url', required:true");
f.addElement("menu_type", null, "title:'menu_type', required:false");
f.addElement("menu_depth", null, "title:'menu_depth', required:true");
f.addElement("target", null, "title:'target', required:false");
f.addElement("use_yn", null, "title:'use_yn', required:false");

//Step3
if(m.isPost() && f.validate()) {
	f.addElement("s_keyword", null, null);

	adminmenu.item("parent_id", f.get("parent_id"));
	adminmenu.item("menu_name", f.get("menu_name"));
	adminmenu.item("menu_cat", f.get("menu_cat"));
	adminmenu.item("menu_type", f.get("menu_type"));
	adminmenu.item("target", f.get("target"));	
	adminmenu.item("menu_depth", f.get("menu_depth"));
	adminmenu.item("menu_url", f.get("menu_url"));
	adminmenu.item("sort", f.get("sort"));	adminmenu.item("use_yn", f.get("use_yn"));
	adminmenu.item("reg_date", m.time("yyyyMMddHHmmss"));
	adminmenu.item("status", 1);

	//blog.setDebug(out);
	if(!adminmenu.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}
	
	m.redirect("index.jsp");
	return;
}
//Step4
//p.setDebug(out);
p.setLayout("blog");
p.setBody("admin/menu/create");
p.setVar("form_script", f.getScript());
p.setVar("parentMenu", parentMenu);
p.setVar("subMenu", subMenu);
p.print();

%>