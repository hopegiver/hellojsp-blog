<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

if(userId == null){
	m.jsAlert("Need to login");
	m.jsReplace("/admin/login.jsp", "window");
}
//Step1
AdminUserDao adminuser = new AdminUserDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = adminuser.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
f.addElement("login_id", info.s("login_id"), "title:'login_id', required:true");
f.addElement("passwd", info.s("passwd"), "title:'passwd', required:true");
f.addElement("nickname", info.s("nickname"), "title:'nickname', required:true");
f.addElement("email", info.s("email"), "title:'email', required:true");
f.addElement("photo_url", info.s("photo_url"), "title:'photo_url'");

//Step5
if(m.isPost() && f.validate()) {

	adminuser.item("login_id", f.get("login_id"));
	adminuser.item("passwd", f.get("passwd"));
	adminuser.item("nickname", f.get("nickname"));
	adminuser.item("email", f.get("email"));

	if("Y".equals(f.get("photo_url_del"))) {
		adminuser.item("photo_url", "");
		m.delFile(f.uploadDir + "/" + info.s("photo_url"));
	}
	
	File attFile = f.saveFile("photo_url");
	if(attFile != null) {
		adminuser.item("photo_url", attFile.getName());

		if(!"".equals(info.s("photo_url"))) {
			m.delFile(f.uploadDir + "/" + info.s("att_file_code"));
		}
	}

	//blog.setDebug(out);
	if(!adminuser.update("id = " + id)) {
		m.jsAlert("Error occurred(update)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
p.setLayout("blog");
p.setBody("admin/user/update");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>