<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%
        
		NewsDao news = new NewsDao();
		
        DataSet singlePost = news.find("status != -1 AND type='Single post' AND use_yn='Y'", "subject, content, photo_name, reg_date");
        if(!singlePost.next()) {m.jsError("No data");}
        
        p.setBody("front/single-post");
        p.setVar("singlePost", singlePost);
        p.setVar("form_script", f.getScript());
        p.print();
        
%>