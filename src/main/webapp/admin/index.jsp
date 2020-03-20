<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

		String pagetitle = "Admin"; 
		p.setVar("pagetitle", pagetitle);
     	p.setVar("userId", userId);
        p.setLayout("blog");
        p.setBody("admin/index");	
        p.print();
   
%>
