package dao;

import hellojsp.db.DataObject;
import hellojsp.util.DataSet;
import hellojsp.util.Page;

public class UserMenuDao extends DataObject{

	public UserMenuDao(){
		this.table = "tb_user_menu";
		this.PK = "user_id, menu_id";
	}
	
	/*public UserMenuDao(Page p){
		this.table = "tb_user_menu";
		this.p = p;
	}*/
	
	/*public UserMenuDao(Querylog qlog){
		this.table ="tb_user_menu";
		this.PK = "user_id, menu_id";
		this.setQuerylog(qlog);
	}*/
	
	public int sortMenu(int id, int num, int pnum) {
		if(id == 0 || num == 0 || pnum == 0) return -1;
		DataSet info = this.find("id = " + id);
		if(!info.next()) return -1;
		this.execute("UPDATE " + table + " SET sort = sort * 1000 WHERE depth = " + info.i("depth") + " AND menu_type = '" + info.s("menu_type") + "' AND parent_id = " + info.i("parent_id") + "");
		this.execute("UPDATE " + table + " SET sort = " + num + " * 1000" + (pnum <= num ? "+1" : "-1") + " WHERE id = " + id);
		return autoSort(info.i("depth"), info.i("parent_id"), info.s("menu_type"));
	}
	
	public int autoSort(int depth, int pmenu, String type) {
		DataSet list = this.find("menu_type = '" + type + "' AND depth = " + depth + " AND parent_id = " + pmenu + "", "id, sort", "sort ASC");
		int sort = 1;
		while(list.next()) {
			this.execute("UPDATE " + table + " SET sort = " + sort + " WHERE id = " + list.i("id") + "");
			sort++;
		}
		return 1;
	}
}