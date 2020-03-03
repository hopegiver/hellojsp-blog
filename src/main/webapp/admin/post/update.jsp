<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
	PostDao post = new PostDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = post.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
f.addElement("user_id", info.s("user_id"), "title:'user_id', required:true");
f.addElement("type", info.s("type"), "title:'type', required:true");
f.addElement("subject", info.s("subject"), "title:'subject', required:true");
f.addElement("content", info.s("content"), "title:'content', required:true");
f.addElement("photo_url", info.s("photo_url"), "title:'photo_url'");
f.addElement("comment_cnt", info.s("comment_cnt"), "title:'comment_cnt'");

//Step5
if(m.isPost() && f.validate()) {

	post.item("user_id", f.get("user_id"));
	post.item("type", f.get("type"));
	post.item("subject", f.get("subject"));
	post.item("content", f.get("content"));
	post.item("comment_cnt", f.get("comment_cnt"));

	if("Y".equals(f.get("photo_url_del"))) {
		post.item("photo_url", "");
		m.delFile(f.uploadDir + "/" + info.s("photo_url"));
	}
	
	File attFile = f.saveFile("photo_url");
	if(attFile != null) {
		post.item("photo_url", attFile.getName());

		if(!"".equals(info.s("photo_url"))) {
			m.delFile(f.uploadDir + "/" + info.s("att_file_code"));
		}
	}

	//blog.setDebug(out);
	if(!post.update("id = " + id)) {
		m.jsAlert("Error occurred(update)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
p.setLayout("blog");
p.setBody("admin/post/update");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>