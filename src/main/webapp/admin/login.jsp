<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%
UserDao user = new UserDao();
	m.p("USER_ID : " + userId);

	f.addElement("login_id", null, "title:'login_id', required:'Y'");
	f.addElement("passwd", null, "title:'password', required:'Y'");

	

	if(m.isPost() && f.validate()) {
		
		ListManager lm = new ListManager();
		lm.setRequest(request);
	    lm.setTable("tb_admin a");
	    lm.setFields("a.*");
	    lm.addSearch("a.login_id", f.get("login_id"));
	    lm.addSearch("a.passwd", m.sha256(f.get("passwd")));
	    lm.setOrderBy("a.id DESC");
		DataSet list = lm.getDataSet();
	    if(list.next()) {
	    	auth.put("user_id", f.get("login_id"));
			auth.save();
			
			m.jsAlert("Login success");
			m.jsReplace("user/index.jsp");
		} else {
			m.jsError("id or password is not correct.");
			auth.destroy();
		}
		return;
		
	}

	p.setBody("example/admin/login");
	p.setVar("form_script", f.getScript());
	p.print();

%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
