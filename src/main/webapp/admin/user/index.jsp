<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

    if(userId != null){
        //Step1
        UserDao user = new UserDao();

        //Step2
        f.addElement("s_keyword", null, null);

        //Step3
        ListManager lm = new ListManager();
        //lm.setDebug(out);
        lm.setRequest(request);
        lm.setTable("tb_user a");
        lm.setFields("a.*");
        lm.addWhere("a.status != -1");
        lm.addSearch("a.login_id, a.nickname, a.passwd , a.email", f.get("s_keyword"), "LIKE");
        lm.setOrderBy("a.id DESC");

        //Step3
        DataSet list = lm.getDataSet();
        while(list.next()) {
            list.put("reg_date", m.time("yyyy-MM-dd", list.s("reg_date")));
        }

        //Step4
        //    p.setDebug(out);
        p.setLayout("blog");
        p.setBody("sample/admin/index");
        
        p.setVar("list", list);
        p.setVar("total_cnt", lm.getTotalNum());
        p.setVar("pagebar", lm.getPaging());
        p.setVar("form_script", f.getScript());
        p.print();

    } else {
        m.jsAlert("Need to login");
        m.jsReplace("/admin/login.jsp", "window");
    }

%>