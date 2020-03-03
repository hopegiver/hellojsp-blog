<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

//Step1
	PostDao post = new PostDao();

//Step2
int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

//Step3
DataSet info = post.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

f.addElement("id", info.s("id"), "title:'ID', required:true");

//Step5
if(m.isPost() && f.validate()) {

	if(!"".equals(info.s("att_file_code"))) {
		m.delFile(f.uploadDir + "/" + info.s("att_file_code"));
	}
	post.item("status", -1);

	//blog.setDebug(out);
	if(!post.update("id = " + id)) {
		m.jsAlert("Error occurred(delete)");
		return;
	}

	m.redirect("index.jsp");
	return;
}

//Step6
p.setLayout("blog");
p.setBody("admin/post/delete");
p.setVar("info", info);
p.setVar("form_script", f.getScript());
p.print();

%>