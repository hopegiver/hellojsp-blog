<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

        //Step2
        f.addElement("s_keyword", null, null);

        //Step3
        ListManager lm = new ListManager();
        //lm.setDebug(out);
        lm.setRequest(request);
        lm.setTable("tb_news a");
        lm.setFields("a.*");
        lm.addWhere("a.status != -1");
        lm.addSearch("a.user_id, a.subject, a.content", f.get("s_keyword"), "LIKE");
        lm.setOrderBy("a.id DESC");

        //Step3
        DataSet list = lm.getDataSet();
        while(list.next()) {
            list.put("reg_date", m.time("yyyy-MM-dd", list.s("reg_date")));
            list.put("mod_date", m.time("yyyy-MM-dd", list.s("mod_date")));
        }

        //Step4
        //p.setDebug(out);
        String pagetitle = "News"; 
		String pageaction = "list"; 
		p.setVar("pagetitle", pagetitle);
		p.setVar("pageaction", pageaction);
        p.setLayout("blog");
        p.setBody("admin/news/index");
        p.setLoop("list", list);
        p.setVar("total_cnt", lm.getTotalNum());
        p.setVar("pagebar", lm.getPaging());
        p.setVar("form_script", f.getScript());
        p.print();

%>