<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
DataSet menuInfo = adminmenu.find("status != -1 and menu_cat='user'", "parent_id, menu_name", "sort");

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = news.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
f.addElement("type", info.s("type"), "title:'type', required:true");
f.addElement("media_type", info.s("media_type"), "title:'media_type', required:true");
f.addElement("subject", info.s("subject"), "title:'subject', required:true");
f.addElement("content", info.s("content"), "title:'content', required:true");
f.addElement("photo_name", info.s("photo_name"), "title:'photo_name'");
f.addElement("video_url", info.s("video_url"), "title:'video_url'");
f.addElement("use_yn", null, "title:'use_yn'");

//Step5
if(m.isPost() && f.validate()) {

	news.item("type", f.get("type"));
	news.item("media_type", f.get("media_type"));
	news.item("subject", f.get("subject"));
	news.item("content", f.get("content"));
	news.item("video_url", f.get("video_url"));
	news.item("use_yn", f.get("use_yn"));
	news.item("mod_user", f.get("mod_user")); 
	news.item("mod_date", m.time("yyyyMMddHHmmss"));
	
	if("Y".equals(f.get("photo_name_del"))) {
		news.item("photo_name", "");
		m.delFile(f.uploadDir + "/" + info.s("photo_name"));
	}
	
	File attFile = f.saveFile("photo_name");
	if(attFile != null) {
		news.item("photo_name", attFile.getName());

		if(!"".equals(info.s("photo_name"))) {
			m.delFile(UploadPath + "/" + info.s("att_file_code"));
		}
	}

	//blog.setDebug(out);
	if(!news.update("id = " + id)) {
		m.jsAlert("Error occurred(update)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
String pagetitle = "News"; 
String pageaction = "update"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/news/update");
p.setVar("info", info);
p.setVar("menuInfo", menuInfo);
p.setVar("form_script", f.getScript());
p.print();

%>