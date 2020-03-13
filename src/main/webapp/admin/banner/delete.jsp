<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

	if(userId == null){
		m.jsAlert("Need to login");
		m.jsReplace("/admin/login.jsp", "window");
	}
//Step1
	BannerDao banner = new BannerDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = banner.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

f.addElement("id", info.s("id"), "title:'ID', required:true");

//Step5
if(m.isPost() && f.validate()) {

	if(!"".equals(info.s("photo_url"))) {
		m.delFile(UploadPath + "/" + info.s("photo_url"));
	}
	banner.item("status", -1);

	//blog.setDebug(out);
	if(!banner.update("id = " + id)) {
		m.jsAlert("Error occurred(delete)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
p.setLayout("blog");
p.setBody("admin/banner/delete");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>