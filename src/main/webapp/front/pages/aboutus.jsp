<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

        AdminUserDao adminuser = new AdminUserDao();

        DataSet staffs = adminuser.find("status != -1 AND id > 2", "nickname, email, job, photo_url");
        
		NewsDao news = new NewsDao();
		
		DataSet aboutUsNews = news.find("status != -1 AND type = 'About us'", "type, subject, content");
		if(!aboutUsNews.next()) {m.jsError("No data");}
		
        p.setBody("front/about-us");
        p.setVar("staffs", staffs);
        p.setVar("aboutUsNews", aboutUsNews);
        p.setVar("form_script", f.getScript());
        p.print();
        
%>