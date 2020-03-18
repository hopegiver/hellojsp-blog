<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

        AdminMenuDao adminmenu = new AdminMenuDao();

        DataSet parentMenu = adminmenu.find("status != -1 AND parent_id = 0 AND menu_cat = 'user'", "*", "sort");
        
        DataSet subMenu = adminmenu.find("status != -1 AND parent_id != 0 AND menu_cat = 'user'", "*", "sort");
		
        BannerDao banner = new BannerDao();

        DataSet bannerList = banner.find("status != -1", "title, content, photo_name");
        
		NewsDao news = new NewsDao();
		
		DataSet mediaNews = news.find("status != -1 AND video_url != ''", " * ", "id DESC", 4);

        DataSet newsPhoto = news.find("status != -1 AND type = 'photo'", "photo_name");
        
        p.setBody("front/index");
        p.setVar("form_script", f.getScript());
        p.setVar("parentMenu", parentMenu);
        p.setVar("subMenu", subMenu);
        p.setVar("form_script", f.getScript());
        p.print();
        
%>
