<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%
		
        BannerDao banner = new BannerDao();

        DataSet bannerList = banner.find("status != -1", "title, content, photo_name");
        
		NewsDao news = new NewsDao();
		
		DataSet singleVideoPosts = news.find("status != -1 AND video_url != '' AND use_yn='Y'", " * ", "reg_date DESC", 8);

        DataSet onePoliticNews = news.find("status != -1 AND use_yn='Y' AND type='Politics'", " * ", "reg_date DESC", 1);
        if(!onePoliticNews.next()){m.jsError("No Data"); return;}
        onePoliticNews.put("reg_date", m.time("MM-dd", onePoliticNews.s("reg_date")));
    	
        
        p.setBody("front/index");
        p.setVar("form_script", f.getScript());
        p.setVar("parentMenu", parentMenu);
        p.setVar("subMenu", subMenu);
        p.setVar("singleVideoPosts", singleVideoPosts);
        p.setVar("onePoliticNews", onePoliticNews);
        p.setVar("form_script", f.getScript());
        p.print();
        
%>
