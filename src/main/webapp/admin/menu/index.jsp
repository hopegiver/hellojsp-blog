<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%

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
		
        DataSet parentMenu = adminmenu.find("status != -1", "id, menu_name, menu_type, menu_cat, menu_url, use_yn, parent_id, sort, reg_date", "sort");
        
        DataSet subMenu = adminmenu.find("status != -1 AND parent_id != 0", "id, menu_name, menu_type, menu_cat, menu_url, use_yn, parent_id, sort, reg_date", "sort");
        
        while(parentMenu.next()) {
        	parentMenu.put("reg_date", m.time("yyyy-MM-dd", list.s("reg_date")));
        }
        while(subMenu.next()) {
            subMenu.put("reg_date", m.time("yyyy-MM-dd", list.s("reg_date")));
        }
        
        DataSet parent = adminmenu.find("status != -1 AND parent_id = 0");

        //Step4
		String pagetitle = "Menu"; 
		String pageaction = "list"; 
		p.setVar("pagetitle", pagetitle);
		p.setVar("pageaction", pageaction);
        p.setLayout("blog");
        p.setBody("admin/menu/index");
        p.setVar("list", list);
        p.setVar("parentMenu", parentMenu);
        p.setVar("subMenu", subMenu);
        p.setVar("parent", parent);
        p.setVar("total_cnt", lm.getTotalNum());
        p.setVar("pagebar", lm.getPaging());
        p.setVar("form_script", f.getScript());
        p.print();

%>