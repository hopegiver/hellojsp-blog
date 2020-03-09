<%@ page import="javax.xml.crypto.Data" %>
<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%
AdminUserDao adminuser = new AdminUserDao();
	m.p("USER_ID : " + userId);

	auth.destroy();
	m.jsReplace("login.jsp");


%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
