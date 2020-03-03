<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
	PostDao post = new PostDao();

//Step2
	f.addElement("user_id", null, "title:'user_id', required:true");
	f.addElement("type", null, "title:'type', required:true");
	f.addElement("subject", null, "title:'subject', required:true");
	f.addElement("content", null, "title:'content', required:true");
	f.addElement("photo_url", null, "title:'photo_url'");
	f.addElement("comment_cnt", null, "title:'comment_cnt'");

//Step3
if(m.isPost() && f.validate()) {

	post.item("user_id", f.get("user_id"));
	post.item("type", f.get("type"));
	post.item("subject", f.get("subject"));
	post.item("content", f.get("content"));
	post.item("comment_cnt", f.get("comment_cnt"));

	File attFile = f.saveFile("photo_url");
	if(attFile != null) {
		post.item("photo_url", attFile.getName());
	}
	post.item("reg_date", m.time("yyyyMMddHHmmss"));
	post.item("status", 1);

	//blog.setDebug(out);
	if(!post.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
p.setLayout("blog");
p.setBody("admin/post/create");
p.setVar("form_script", f.getScript());
p.print();

%>