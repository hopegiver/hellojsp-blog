<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%
m.p("USER_ID : " + userId);
     /* if(userId != null){ */
         
     	p.setVar("userId", userId);
         p.setLayout("blog");
         p.setBody("admin/index");	
         p.print();

  /*    } else {
         m.jsAlert("Need to login");
         m.jsReplace("/admin/login.jsp", "window");
     } */
   
%>
