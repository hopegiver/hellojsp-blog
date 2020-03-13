<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

AdminUserDao adminuser = new AdminUserDao();
	m.p("USER_ID : " + userId);

	f.addElement("login_id", null, "title:'login_id', required:'Y'");
	f.addElement("passwd", null, "title:'password', required:'Y'");

	if(m.isPost() && f.validate()) {
		
		File attFile = f.saveFile("att_file");
		
		String pass = m.sha256(f.get("passwd"));
		adminuser.find("");
		DataSet info = adminuser.find("login_id = ? AND passwd = ? AND status = 1", new Object[] { f.get("login_id"), pass });
	    if(info.next()) {
	    	auth.put("user_id", f.get("login_id"));
			auth.save();
			
			m.jsAlert("Login success");
			m.jsReplace("user/index.jsp");
		} else {
			m.jsError("id or password is not correct.");
			return;
		}
		return;		
	}

	p.setBody("admin/login");
	p.setVar("form_script", f.getScript());
	p.print();

%>

