<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

//Step1
BannerDao banner = new BannerDao();
DataSet bannerList = banner.find("status != -1 AND use_yn='Y'", "*", "sort");

//Step2
f.addElement("title", null, "title:'title', required:true");
f.addElement("content", null, "title:'content', required:true");
f.addElement("att_file", null, "title:'file'");
f.addElement("use_yn", null, "title:'use_yn'");
f.addElement("sort", null, "title:'sort'");

//Step3
if(m.isPost() && f.validate()) {

	banner.item("title", f.get("title"));
	banner.item("content", f.get("content"));

	File attFile = f.saveFile("att_file", UploadPath);
	if(attFile != null) {
		banner.item("photo_name", f.getFileName("att_file"));
		banner.item("photo_url", attFile.getName());
	}
	banner.item("use_yn", f.get("use_yn"));
	banner.item("sort", f.get("sort"));
	banner.item("reg_date", m.time("yyyyMMddHHmmss"));
	banner.item("status", 1);

	//blog.setDebug(out);
	if(!banner.insert()) {
		m.jsError(" occurred(insert)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step4
//p.setDebug(out);
String pagetitle = "Banner"; 
String pageaction = "add"; 
p.setVar("pagetitle", pagetitle);
p.setVar("pageaction", pageaction);
p.setLayout("blog");
p.setBody("admin/banner/create");
p.setVar("bannerList", bannerList);
p.setVar("form_script", f.getScript());
p.print();

%>