<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
UserDao user = new UserDao();

//Step2
f.addElement("login_id", null, "title:'login_id', required:true");
f.addElement("passwd", null, "title:'passwd', required:true");
f.addElement("nickname", null, "title:'nickname'");
f.addElement("email", null, "title:'email'");
f.addElement("photo_url", null, "title:'photo_url'");

//Step3
if(m.isPost() && f.validate()) {

	user.item("login_id", f.get("login_id"));
	user.item("passwd", m.sha256(f.get("passwd")));
	user.item("nickname", f.get("nickname"));
	user.item("email", f.get("email"));

	File attFile = f.saveFile("photo_url");
	if(attFile != null) {
		user.item("photo_url", attFile.getName());
	}
	user.item("reg_date", m.time("yyyyMMddHHmmss"));
	user.item("status", 1);

	//blog.setDebug(out);
	if(!user.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
p.setLayout("blog");
p.setBody("sample/admin/create");
p.setVar("form_script", f.getScript());
p.print();

%>