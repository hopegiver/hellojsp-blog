<%@ page import="java.util.*,java.io.*,hellojsp.db.*,hellojsp.util.*,dao.*" %><%

Hello m = new Hello(request, response, out);

Form f = new Form();
f.setRequest(request);

Page p = new Page();
p.setWriter(out);
p.setVar("m", m);

Message msg = new Message();
p.setVar("msg", msg);

String userId = null;

String UploadPath = "E:/hellojsp/hellojsp-blog/src/main/webapp/uploads";

Auth auth = new Auth(request, response);
if(auth.validate()) {
	userId = auth.get("user_id");
}

if(userId == null){
	//m.jsAlert("Need to login");
	m.jsReplace("/admin/login.jsp", "window");
}

AdminUserDao adminuser = new AdminUserDao();
BannerDao banner = new BannerDao();
NewsDao news = new NewsDao();
AdminMenuDao adminmenu = new AdminMenuDao();
AdminMenuDao parentadminmenu = new AdminMenuDao();

DataSet adminparentMenu = parentadminmenu .find("status != -1 AND parent_id = 0 AND menu_cat='admin'", "*", "sort");

p.setVar("adminparentMenu", adminparentMenu);

%>