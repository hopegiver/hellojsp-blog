<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

     if(userId != null){ 
        //Step1

        //Step2
        f.addElement("s_keyword", null, null);

        //Step3
        ListManager lm = new ListManager();
        //lm.setDebug(out);
        lm.setRequest(request);
        lm.setTable("tb_menu a");
        lm.setFields("a.*");
        lm.addWhere("a.status != -1");
        lm.addSearch("a.menu_name, a.parent_id, a.reg_date, a.use_yn", f.get("s_keyword"), "LIKE");
        lm.setOrderBy("a.id DESC");

        //Step3
        DataSet list = lm.getDataSet();
        while(list.next()) {
            list.put("reg_date", m.time("yyyy-MM-dd", list.s("reg_date")));
        }
		
        ListManager sub = new ListManager();
        //lm.setDebug(out);
        sub.setRequest(request);
        sub.setTable("tb_menu a");
        sub.setFields("a.*");
        sub.addWhere("a.status != -1");
        sub.addSearch("a.menu_name, a.parent_id, a.reg_date, a.use_yn", f.get("s_keyword"), "LIKE");
        sub.setOrderBy("a.id DESC");

        //Step3
        DataSet sublist = lm.getDataSet();
        while(sublist.next()) {
            sublist.put("reg_date", m.time("yyyy-MM-dd", sublist.s("reg_date")));
        }
        DataSet parent = adminmenu.find("status != -1 AND parent_id = 0 ");

        //Step4

        p.setLayout("blog");
        p.setBody("admin/menu/index");
        p.setVar("list", list);
        p.setVar("sublist", sublist);
        p.setVar("total_cnt", lm.getTotalNum());
        p.setVar("pagebar", lm.getPaging());
        p.setVar("form_script", f.getScript());
        p.print();

       } else {
        m.jsAlert("Need to login");
        m.jsReplace("/admin/login.jsp", "window");
    } 

%>