<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

if(userId == null){
	m.jsAlert("Need to login");
	m.jsReplace("/admin/login.jsp", "window");
}
//Step1
AdminUserDao adminuser = new AdminUserDao();

//Step2
f.addElement("login_id", null, "title:'login_id', required:true");
f.addElement("passwd", null, "title:'passwd', required:true");
f.addElement("nickname", null, "title:'nickname'");
f.addElement("email", null, "title:'email'");
f.addElement("photo_url", null, "title:'photo_url'");

//Step3
if(m.isPost() && f.validate()) {

	adminuser.item("login_id", f.get("login_id"));
	adminuser.item("passwd", m.sha256(f.get("passwd")));
	adminuser.item("nickname", f.get("nickname"));
	adminuser.item("email", f.get("email"));

	File attFile = f.saveFile("photo_url");
	if(attFile != null) {
		adminuser.item("photo_url", attFile.getName());
	}
	adminuser.item("reg_date", m.time("yyyyMMddHHmmss"));
	adminuser.item("status", 1);

	//blog.setDebug(out);
	if(!adminuser.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
p.setLayout("blog");
p.setBody("admin/user/create");
p.setVar("form_script", f.getScript());
p.print();

%>