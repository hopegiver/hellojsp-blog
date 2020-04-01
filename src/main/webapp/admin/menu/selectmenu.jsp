<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%
   

    int id = m.reqInt("id");
 
    p.setBody("admin/menu/menuselect");

    p.print();
%>