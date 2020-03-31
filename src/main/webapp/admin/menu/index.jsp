<%@ page contentType="text/html; charset=utf-8" %><%@ include file="../init.jsp" %><%


        //Step1   
        
        AdminMenuDao adminmenu = new AdminMenuDao();

        DataSet menuInfo = adminmenu.find("status != -1", "*", "sort");
        
        DataSet subMenu = adminmenu.find("status != -1 AND parent_id != 0", "*", "sort");
 
     /*    while(menuInfo.next()) {
        	menuInfo.put("reg_date", m.time("yyyy-MM-dd", menuInfo.s("reg_date")));
        }
        while(subMenu.next()) {
            subMenu.put("reg_date", m.time("yyyy-MM-dd", subMenu.s("reg_date")));
        } */
        
        DataSet parent = adminmenu.find("status != -1 AND parent_id = 0");
        
        int id = m.reqInt("id");
        int del = m.reqInt("del");
       // if(id == 0) { m.jsError("Primary Key is required"); return; }
        DataSet info = adminmenu.find("id = " + id);
       	//if(!info.next()) { m.jsError("No Data"); return; } 
	
        if(id != 0){
        	if(del == 1){
        		adminmenu.item("status", -1);

        		//blog.setDebug(out);
        		if(!adminmenu.update("id = " + id)) {
        			m.jsAlert("Error occurred(delete)");
        			return;
        		}

        		m.redirect("index.jsp");
        		return;
        	} else {
        		if(!info.next()) { m.jsError("No Data"); return; }
        		
        		f.addElement("menu_name", info.s("menu_name"), "title:'menu_name', required:true");
            	f.addElement("menu_cat", info.s("menu_cat"), "title:'menu_cat', required:false");
            	f.addElement("parent_id", info.s("parent_id"), "title:'parent_id', required:true");
            	f.addElement("sort", info.s("sort"), "title:'sort', required:true");
            	f.addElement("menu_url", info.s("menu_url"), "title:'menu_url', required:true");
            	f.addElement("menu_type", info.s("menu_type"), "title:'menu_type', required:false");
            	f.addElement("menu_depth", info.s("menu_depth"), "title:'menu_depth', required:true");
            	f.addElement("target", info.s("target"), "title:'target', required:false");
            	f.addElement("use_yn", info.s("use_yn"), "title:'use_yn', required:false");

            	//Step5
            	if(m.isPost() && f.validate()) {

            		adminmenu.item("parent_id", f.get("parent_id"));
            		adminmenu.item("menu_name", f.get("menu_name"));
            		adminmenu.item("menu_cat", f.get("menu_cat"));
            		adminmenu.item("menu_type", f.get("menu_type"));
            		adminmenu.item("target", f.get("target"));	
            		adminmenu.item("menu_depth", f.get("menu_depth"));
            		adminmenu.item("menu_url", f.get("menu_url"));
            		adminmenu.item("sort", f.get("sort"));
            		adminmenu.item("use_yn", f.get("use_yn"));	

            		//blog.setDebug(out);
            		if(!adminmenu.update("id = " + id)) {
            			m.jsAlert("Error occurred(update)");
            			return;
            		}

            		m.redirect("index.jsp");
            		return; 
            	}
        	}      	
        }
        else {
        	f.addElement("menu_name", null, "title:'menu_name', required:true");
        	f.addElement("menu_cat", null, "title:'menu_cat', required:false");
        	f.addElement("parent_id", null, "title:'parent_id', required:true");
        	f.addElement("sort", null, "title:'sort', required:true");
        	f.addElement("menu_url", null, "title:'menu_url', required:true");
        	f.addElement("menu_type", null, "title:'menu_type', required:false");
        	f.addElement("menu_depth", null, "title:'menu_depth', required:true");
        	f.addElement("target", null, "title:'target', required:false");
        	f.addElement("use_yn", null, "title:'use_yn', required:false");

        	//Step3

        	if(m.isPost() && f.validate()) {
        		f.addElement("s_keyword", null, null);

        		adminmenu.item("parent_id", f.get("parent_id"));
        		adminmenu.item("menu_name", f.get("menu_name"));
        		adminmenu.item("menu_cat", f.get("menu_cat"));
        		adminmenu.item("menu_type", f.get("menu_type"));
        		adminmenu.item("target", f.get("target"));	
        		adminmenu.item("menu_depth", f.get("menu_depth"));
        		adminmenu.item("menu_url", f.get("menu_url"));
        		adminmenu.item("sort", f.get("sort"));	
        		adminmenu.item("use_yn", f.get("use_yn"));
        		adminmenu.item("reg_date", m.time("yyyyMMddHHmmss"));
        		adminmenu.item("status", 1);

        		//blog.setDebug(out);
        		if(!adminmenu.insert()) {
        			m.jsError(" occurred(insert)");
        			return;
        		}
        		
        		m.redirect("index.jsp");
        		return; 
        	}
        	
        	
        }
        String arrayMenu = menuInfo.toJson();
        //Step4
		String pagetitle = "Menu"; 
		String pageaction = "list"; 
		p.setVar("pagetitle", pagetitle);
		p.setVar("pageaction", pageaction);
        p.setLayout("blog");
        p.setBody("admin/menu/index");
        p.setLoop("menuInfo", menuInfo);
        p.setVar("arrayMenu", arrayMenu);
        p.setVar("id", id);
        p.setLoop("subMenu", subMenu);
        p.setLoop("parent", parent);
        p.setVar("form_script", f.getScript());
        p.print();

%>