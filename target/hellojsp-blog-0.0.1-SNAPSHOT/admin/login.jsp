<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

    m.p("USER_ID : " + userId);

    f.addElement("id", null, "title:'id', required:'Y'");
    f.addElement("passwd", null, "title:'password', required:'Y'");

    if(m.isPost() && f.validate()) {

        if("abcd".equals(f.get("id")) && "1234".equals(f.get("passwd"))) {

            auth.put("user_id", "abcd");
            auth.save();

            m.jsAlert("Login success");
            m.jsReplace("login.jsp");
        } else {
            m.jsError("id, password is not correct.");
        }
        return;
    }

    p.setBody("example/adminLogin");
    p.setVar("form_script", f.getScript());
    p.print();

%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%--<pre>--%>
<%--m.p("USER_ID : " + userId);--%>

<%--f.addElement("id", null, "title:'id', required:'Y'");--%>
<%--f.addElement("passwd", null, "title:'password', required:'Y'");--%>

<%--if(m.isPost() && f.validate()) {--%>

<%--	if("abcd".equals(f.get("id")) && "1234".equals(f.get("passwd"))) {--%>

<%--		auth.put("user_id", "abcd");--%>
<%--		auth.save();--%>

<%--		m.jsAlert("Login success");--%>
<%--		m.jsReplace("login.jsp");--%>
<%--	} else {--%>
<%--		m.jsError("id, password is not correct.");--%>
<%--	}--%>
<%--	return;--%>
<%--}--%>

<%--p.setBody("example/login");--%>
<%--p.setVar("form_script", f.getScript());--%>
<%--p.print();--%>
<%--</pre>--%>