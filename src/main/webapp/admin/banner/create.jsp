<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

	if(userId == null){
		m.jsAlert("Need to login");
		m.jsReplace("/admin/login.jsp", "window");
	}
//Step1
BannerDao banner = new BannerDao();

//Step2
f.addElement("title", null, "title:'title', required:true");
f.addElement("content", null, "title:'content', required:true");
f.addElement("att_file", null, "title:'file'");

//Step3
if(m.isPost() && f.validate()) {

	banner.item("title", f.get("title"));
	banner.item("content", f.get("content"));

	File attFile = f.saveFile("att_file");
	if(attFile != null) {
		banner.item("photo_name", f.getFileName("att_file"));
		banner.item("photo_url", attFile.getName());
	}
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
p.setDebug(out);
p.setLayout("blog");
p.setBody("admin/banner/create");
p.setVar("form_script", f.getScript());
p.print();

%>