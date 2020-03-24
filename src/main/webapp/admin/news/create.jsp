<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
	DataSet menuInfo = adminmenu.find("status != -1 and menu_cat='user'", "parent_id, menu_name", "sort");

//Step2
	f.addElement("type", null, "title:'type', required:true");
	f.addElement("news_type", null, "title:'news_type', required:false");
	f.addElement("media_type", null, "title:'media_type', required:false");
	f.addElement("subject", null, "title:'subject', required:true");
	f.addElement("content", null, "title:'content', required:true");
	f.addElement("photo_name", null, "title:'photo_name'");
	f.addElement("video_url", null, "title:'video_url'");
	f.addElement("use_yn", null, "title:'use_yn'");
	f.addElement("flow", null, "title:'flow'");
//Step3
if(m.isPost() && f.validate()) {

	news.item("type", f.get("type"));
	news.item("subject", f.get("subject"));
	news.item("content", f.get("content"));
	news.item("video_url", f.get("video_url"));
	news.item("use_yn", f.get("use_yn"));
	news.item("flow", f.get("flow"));
	mediaTypes.item("news_id", f.get(news.id));
	mediaTypes.item("news_type", f.get("news_type"));
	mediaTypes.item("media_type", f.get("media_type"));
	

	File attFile = f.saveFile("photo_name");
	if(attFile != null) {
		news.item("photo_name", attFile.getName());
	}
	news.item("reg_date", m.time("yyyyMMddHHmmss"));
	news.item("status", 1);

	//blog.setDebug(out);
	if(!news.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}
	if(!mediaTypes.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
String pagetitle = "News"; 
String pageaction = "add"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/news/create");
p.setVar("form_script", f.getScript());
p.setVar("menuInfo", menuInfo);
p.print();

%>