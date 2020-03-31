<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
	AdminMenuDao adminmenu = new AdminMenuDao();
	MediaTypesDao mediaTypes = new MediaTypesDao();
	NewsTypesDao newsTypes = new NewsTypesDao();
	NewsDao news = new NewsDao();
	NewsMediaTypesDao newsMediaTypes = new NewsMediaTypesDao();
	NewsNewsTypesDao newsNewsTypes = new NewsNewsTypesDao();

	DataSet menuInfo = adminmenu.find("status != -1 and menu_cat='user'", "parent_id, menu_name", "sort");
	DataSet newstype = newsTypes.find("status != -1 and use_yn='Y'", "news_type");
	DataSet mediatype = mediaTypes.find("status != -1 and use_yn='Y'", "media_type");
	
	int newsCount = newsTypes.findCount("status != -1");
	int mediaCount = mediaTypes.findCount("status != -1");
//Step2
	f.addElement("type", null, "title:'type', required:true");
	for(int i = 1; i <= newsCount; i++){ 
		f.addElement("news_type" + i, null, "title:'news_type'");
		}
	for(int i = 1; i <= mediaCount; i++){ 
	f.addElement("media_type" + i, null, "title:'media_type'");
	}
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
	
	File attFile = f.saveFile("photo_name");
	if(attFile != null) {
		news.item("photo_name", attFile.getName());
	}
	news.item("reg_date", m.time("yyyyMMddHHmmss"));
	news.item("status", 1);
	int id = news.insertWithId();
	if(id == 0) {
		m.jsError(" occurred(insert)");
		return;
	}
	
	for(int i = 1; i <= newsCount; i++){ 
		if(f.get("news_type" + i) != ""){
			newsNewsTypes.item("news_id", id);
			newsNewsTypes.item("news_type", f.get("news_type" + i));	
			if(!newsNewsTypes.insert()) {
				m.jsError(" occurred(news)");
				return;
			}
		}		
	}
	
	for(int i = 1; i <= mediaCount; i++){ 
		if(f.get("media_type" + i) != ""){
			newsMediaTypes.item("news_id", id);
			newsMediaTypes.item("media_type", f.get("media_type" + i));	
			if(!newsMediaTypes.insert()) {
				m.jsError(" occurred(media)");
				return;
			}
		}		
	}
	m.redirect("index.jsp");
	return;
}
	 	
	//blog.setDebug(out);
	
//Step4
//p.setDebug(out);
String pagetitle = "News"; 
String pageaction = "add"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/news/create");
p.setVar("form_script", f.getScript());
p.setLoop("menuInfo", menuInfo);
p.setLoop("newstypes", newstype);
p.setLoop("mediatypes", mediatype);
/* p.setVar("medias", medias); */
p.print();

%>