<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

	m.p("USER_ID : " + userId);

//	f.addElement("login_id", null, "title:'login_id', required:'Y'");
//	f.addElement("passwd", null, "title:'password', required:'Y'");

	ListManager lm = new ListManager();

	if(m.isPost() && f.validate()) {
		lm.setRequest(request);
		lm.setTable("tb_user a");
		lm.setFields("a.login_id, a.passwd");
		lm.addWhere("a.status != -1");
		lm.addSearch("a.login_id", f.get("login_id"));
		lm.addSearch("a.passwd", f.get("passwd"));

		if("admin".equals(f.get("login_id")) && "1234".equals(f.get("passwd"))) {

			auth.put("user_id", "admin");
			auth.save();

			m.jsAlert("Login success");
			m.jsReplace("index.jsp");
		} else {
			m.jsError("id, password is not correct.");
		}
		return;
	}

	p.setBody("example/admin/login");
	p.setVar("form_script", f.getScript());
	p.print();

%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
