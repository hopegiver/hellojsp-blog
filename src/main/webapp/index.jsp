<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%
		
        BannerDao banner = new BannerDao();

        DataSet bannerList = banner.find("status != -1", "title, content, photo_name");
        
		NewsDao news = new NewsDao();
		
		DataSet singleVideoPosts = news.find("status != -1 AND video_url != '' AND use_yn='Y'", " * ", "reg_date DESC", 8);

        DataSet onePoliticNews = news.find("status != -1 AND use_yn='Y' AND type='Politics'", " * ", "reg_date DESC", 1);
        if(!onePoliticNews.next()){m.jsError("No Data"); return;}
        onePoliticNews.put("reg_date", m.time("MM-dd", onePoliticNews.s("reg_date")));
        
        NewsMediaTypesDao newsMediaTypes = new NewsMediaTypesDao();
        NewsNewsTypesDao newsNewsTypes = new NewsNewsTypesDao();
        
       /*  DataSet breakingnews = news.query(
        		"select a.*, b.news_type, c.media_type" + " from " + news + " a " + "inner join " + newsNewsTypes + " b on a.id = b.news_id" +
        		" inner join " + newsMediaTypes + " c on a.id = c.news_id where a.status != -1 AND a.video_url != '' AND a.use_yn ='Y' AND a.type = 'Today' AND b.news_type = 'breaking news' a.reg_date DESK Limit 2");
        DataSet popular1 = news.query(
        		"select a.*, b.news_type, c.media_type" + " from " + news + " a " + "inner join " + newsNewsTypes + " b on a.id = b.news_id" +
        		" inner join " + newsMediaTypes + " c on a.id = c.news_id where a.status != -1 AND a.video_url != '' AND a.use_yn ='Y' AND a.type = 'Today' AND b.news_type = 'popular' a.reg_date DESK Limit 4");
        
        DataSet popular2 = news.query(
        		"select a.*, b.news_type, c.media_type" + " from " + news + " a " + "inner join " + newsNewsTypes + " b on a.id = b.news_id" +
        		" inner join " + newsMediaTypes + " c on a.id = c.news_id where a.status != -1 AND a.video_url != '' AND a.use_yn ='Y' AND a.type = 'Today' AND b.news_type = 'popular' a.reg_date DESK Limit 4");
        
        DataSet popular3 = news.query(
        		"select a.*, b.news_type, c.media_type" + " from " + news + " a " + "inner join " + newsNewsTypes + " b on a.id = b.news_id" +
        		" inner join " + newsMediaTypes + " c on a.id = c.news_id where a.status != -1 AND a.video_url != '' AND a.use_yn ='Y' AND a.type = 'Today' AND b.news_type = 'popular' a.reg_date DESK Limit 4");	 */
    	
        
        p.setBody("front/index");
        p.setVar("form_script", f.getScript());
        p.setVar("parentMenu", parentMenu);
        p.setVar("subMenu", subMenu);
        p.setVar("singleVideoPosts", singleVideoPosts);
        p.setVar("onePoliticNews", onePoliticNews);
       /*  p.setVar("breakingnews", breakingnews);
        p.setVar("popular1", popular1);
        p.setVar("popular2", popular2);
        p.setVar("popular3", popular3); */
        p.setVar("form_script", f.getScript());
        p.print();
        
%>
