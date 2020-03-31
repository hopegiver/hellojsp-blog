<%@ page import="java.util.*,java.io.*,hellojsp.db.*,hellojsp.util.*,dao.*" %><%

Hello m = new Hello(request, response, out);

Form f = new Form();
f.setRequest(request);

Page p = new Page();
p.setWriter(out);
p.setVar("m", m);

Message msg = new Message();
p.setVar("msg", msg);

String userId = null;

String UploadPath = "E:/hellojsp/hellojsp-blog/src/main/webapp/uploads";

Auth auth = new Auth(request, response);
if(auth.validate()) {
	userId = auth.get("user_id");
}

if(userId == null){
	//m.jsAlert("Need to login");
	m.jsReplace("/admin/login.jsp", "window");
}

%>