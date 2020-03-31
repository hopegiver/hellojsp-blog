<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
NewsDao news = new NewsDao();
MediaTypesDao mediaTypes = new MediaTypesDao();
NewsTypesDao newsTypes = new NewsTypesDao();
NewsMediaTypesDao newsMediaTypes = new NewsMediaTypesDao();
NewsNewsTypesDao newsNewsTypes = new NewsNewsTypesDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = news.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

int newsCount = newsTypes.findCount("status != -1 AND news_id = " + id);
int mediaCount = mediaTypes.findCount("status != -1 AND news_id = " + id);

f.addElement("id", info.s("id"), "title:'ID', required:true");

//Step5
if(m.isPost() && f.validate()) {

	if(!"".equals(info.s("att_file_code"))) {
		m.delFile(f.uploadDir + "/" + info.s("att_file_code"));
	}
	news.item("status", -1);
		

	//blog.setDebug(out);
	if(!news.update("id = " + id)) {
		m.jsAlert("Error occurred(delete)");
		return;
	}
	
	for(int i = 1; i <= newsCount; i++){
	newsNewsTypes.item("status", -1);
	if(!newsNewsTypes.update("news_id = " + id)) {
		m.jsAlert("Error occurred(news type delete)");
		return;
		}
	}
	
	for(int i = 1; i <= mediaCount; i++){
	newsMediaTypes.item("status", -1);
	if(!newsMediaTypes.update("news_id = " + id)) {
		m.jsAlert("Error occurred(media type delete)");
		return;
		}
	}
	
	m.redirect("index.jsp");
	return;
}

//Step6
String pagetitle = "News"; 
String pageaction = "delete"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/news/delete");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>