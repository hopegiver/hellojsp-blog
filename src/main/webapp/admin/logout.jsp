<%@ page import="javax.xml.crypto.Data" %>
<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

AdminUserDao adminuser = new AdminUserDao();
	m.p("USER_ID : " + userId);

	auth.destroy();
	m.jsReplace("login.jsp");


%>

