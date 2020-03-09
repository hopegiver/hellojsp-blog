<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
int pmenu = m.reqInt("pmenu");
AdminMenuDao adminmenu = new AdminMenuDao();
UserMenuDao usermenu = new UserMenuDao();
AdminUserDao adminuser = new AdminUserDao();

int maxSort = 0;
DataSet pinfo = new DataSet();
if(0 != pmenu){
	pinfo = adminmenu.find("id = " + pmenu + "");
	if(!pinfo.next()){
		m.jsError("Parent menu information is not there!");
		return;
	}
	maxSort = adminmenu.findCount("menu_type = 'admin' AND parent_id = " + pinfo.s("id") + " AND menu_depth = " + (pinfo.i("menu_depth") + 1));
} else {
	pinfo.addRow();
	pinfo.put("parent_id", "0");
	pinfo.put("menu_depth", 0);
	maxSort = adminmenu.findCount("menu_type = 'admin' AND menu_depth = 1");
}

DataSet sortList = new DataSet();
for(int i=0; i<=maxSort; i++){
	sortList.addRow();
	sortList.put("sort", i+1);
}
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
	adminmenu.item("sort", f.get("sort"));
	adminmenu.item("use_yn", f.get("use_yn"));
	adminmenu.item("reg_date", m.time("yyyyMMddHHmmss"));
	adminmenu.item("status", 1);

	//blog.setDebug(out);
	if(!adminmenu.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}
	
	if(0 != f.getInt("pmenu_id")){
		m.setCookie("mmdIns", f.get("pmenu_id"));
	}
	int newId = adminmenu.getInsertId();
	
	adminmenu.sortMenu(newId, f.getInt("sort"), maxSort + 1);
	
	adminmenu.createFile(f.get("menu_url"), "" + newId);
	
	DataSet list = adminuser.find("status = 1");
	while(list.next()){
		usermenu.item("menu_id", newId);
		usermenu.item("user_id", list.i("id"));
		
		if(!usermenu.insert()){}
	}
	
	out.print("<script>parent.left.location.href = 'menu_tree.jsp?sid=" + pmenu + "';</script>");
	m.jsReplace("menu_insert.jsp?pmenu=" + pmenu + "");
	return;
}

String names = "";
if(0 != pmenu) {
	adminmenu.name = "id";
	adminmenu.pName = "parent_id";
	adminmenu.nName = "menu_nm";
	adminmenu.rootNode = "0";
	adminmenu.setData(adminmenu.find("status = 1"));
	Vector pName = adminmenu.getParentNames(""+pmenu);
	for(int i=(pName.size() - 1); i>=0; --i) {
		names += pName.get(i).toString() + (i == 0 ? "" : " > ");
	}
}


//Step4
//p.setDebug(out);
p.setLayout("blank");
p.setBody("admin/menu/create");
p.setVar("p_title", "관리자 메뉴");
p.setVar("form_script", f.getScript());
p.setVar("query", m.qs());
p.setVar("list_query", m.qs("menu_id"));
p.setVar("admin_block", true);
p.setVar("pinfo", pinfo);
p.setLoop("sort_list", sortList);
p.setVar("parent_name", "".equals(names) ? "-" : names);

p.display();

%>