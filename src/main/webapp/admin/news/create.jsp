<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%
	if(userId == null){
		m.jsAlert("Need to login");
		m.jsReplace("/admin/login.jsp", "window");
	}
//Step1
	NewsDao news = new NewsDao();

//Step2
	f.addElement("type", null, "title:'type', required:true");
	f.addElement("subject", null, "title:'subject', required:true");
	f.addElement("content", null, "title:'content', required:true");
	f.addElement("photo_url", null, "title:'photo_url'");
//Step3
if(m.isPost() && f.validate()) {

	news.item("type", f.get("type"));
	news.item("subject", f.get("subject"));
	news.item("content", f.get("content"));

	File attFile = f.saveFile("photo_url");
	if(attFile != null) {
		news.item("photo_url", attFile.getName());
	}
	news.item("reg_date", m.time("yyyyMMddHHmmss"));
	news.item("status", 1);

	//blog.setDebug(out);
	if(!news.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
p.setLayout("blog");
p.setBody("admin/news/create");
p.setVar("form_script", f.getScript());
p.print();

%>