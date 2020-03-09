<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

        AdminMenuDao menu = new AdminMenuDao();

        DataSet menuInfo = menu.find("status != -1", "menu_name, menu_type, menu_url, sort");
        if(!menuInfo.next()) { m.jsError("No Data"); return; }

        BannerDao banner = new BannerDao();

        DataSet bannerList = banner.find("status != -1", "title, content, photo_name");
        if(!bannerList.next()) { m.jsError("No Data"); return; }

        NewsDao news = new NewsDao();

        DataSet newsList = news.find("status != -1 AND type = 'photo'", "type, subject, content, photo_url");
        if(!newsList.next()) { m.jsError("No Data"); return; }

        p.setBody("front/index");
        p.setVar("form_script", f.getScript());
        p.setVar("menuInfo", menuInfo);
        p.setVar("bannerList", bannerList);
        p.setVar("newsList", newsList);
        p.print();

%>