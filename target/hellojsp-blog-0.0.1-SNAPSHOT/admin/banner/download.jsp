<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

    if(userId == null){
        m.jsAlert("Need to login");
        m.jsReplace("/admin/login.jsp", "window");
    }

BannerDao blog = new BannerDao();

int id = m.reqInt("id");
if(id == 0) { m.jsError("Primary Key is required"); return; }

DataSet info = blog.find("id = " + id);
if(!info.next()) { m.jsError("No Data"); return; }

m.download(f.uploadDir + "/" + info.s("att_file_name"), info.s("att_file_name"));

%>