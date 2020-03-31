<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
BannerDao banner = new BannerDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = banner.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

//Step4
f.addElement("title", info.s("title"), "title:'title', required:true");
f.addElement("content", info.s("content"), "title:'content', required:true");
f.addElement("att_file_name", info.s("att_file_name"), "title:'file'");
f.addElement("use_yn", info.s("use_yn"), "title:'use_yn'");
f.addElement("sort", info.s("sort"), "title:'sort'");

//Step5
if(m.isPost() && f.validate()) {

	banner.item("title", f.get("title"));
	banner.item("content", f.get("content"));

	if("Y".equals(f.get("photo_del"))) {
		banner.item("photo_name", "");
		banner.item("photo_url", "");
		info.put("photo_url", "");
		m.delFile(UploadPath + "/" + info.s("photo_url"));
	}
	
	File attFile = f.saveFile("att_file");
	if(attFile != null) {
		banner.item("photo_name", f.getFileName("att_file"));
		banner.item("photo_url", attFile.getName());

		if(!"".equals(info.s("photo_url"))) {
			m.delFile(UploadPath + "/" + info.s("photo_url"));
		}
	}
	banner.item("use_yn", f.get("use_yn"));
	banner.item("sort", f.get("sort"));

	//blog.setDebug(out);
	if(!banner.update("id = " + id)) {
		m.jsAlert("Error occurred(update)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
String pagetitle = "Banner"; 
String pageaction = "update"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/banner/update");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>