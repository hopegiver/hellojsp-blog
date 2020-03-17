package dao;

import java.io.*;
import java.util.*;

import hellojsp.db.DataObject;
import hellojsp.util.*;


public class AdminMenuDao extends DataObject {
	
	private Page p;
	
	public AdminMenuDao(){
		this.table = "tb_menu";
	}
	
	public AdminMenuDao(Page p){
		this.table = "tb_menu";
		this.p = p;		
	}
	
	public boolean accessible(int id, int userId, String userCd) throws Exception {
		boolean isAuth = false;
		if(this.p != null) {
			DataSet info = find("id = " + id);
			if(info.next()) {
				UserMenuDao userMenu = new UserMenuDao();
				if("05".equals(userCd)) isAuth = true;

				else if(!"".equals(userId) && userMenu.findCount("user_id = " + userId + "") > 0) isAuth = true;
				p.setLayout(info.s("layout"));
				p.setVar("p_title", info.s("menu_nm"));
				p.setVar("Menu", info);
			} else return isAuth;
		}
		return isAuth;
	}
	
	public void createFile(String url, String MID) throws Exception {
		if(url.indexOf("http://") == -1) {
			String docRoot = Config.getDocRoot() + "/sysop";
			url = Hello.replace(url.substring(0, (url.indexOf("?") != -1 ? url.indexOf("?") : url.length())), "..", "");
			String path = docRoot + url;
			String path2 = docRoot + "/html" + Hello.replace(url, ".jsp", ".html");
			File jsp = new File(path);
			File html = new File(path2);
			String[] arr = url.split("\\/");
			String ownerAccount = Config.get("ownerAccount");

			if(arr.length == 3) {
				if(!jsp.exists()) {
					if(!jsp.getParentFile().isDirectory()) jsp.getParentFile().mkdirs();
					StringBuffer buff = new StringBuffer();
					buff.append("<__@ page contentType=\"text/html; charset=utf-8\" __><__@ include file=\"init.jsp\" __><__");
					buff.append("\n");
					buff.append("\nif(!Menu.accessible(" + MID + ", userId, userType)) { m.jsError(\"접근 권한이 없습니다.\"); return; }");
					buff.append("\n");
					buff.append("\n//객체");
					buff.append("\n");
					buff.append("\n//출력");
					buff.append("\np.setBody(\"" + arr[1] + "." + Hello.replace(arr[2], ".jsp", "") + "\");");
					buff.append("\np.setVar(\"list_query\", m.qs(\"id\"));");
					buff.append("\np.setVar(\"query\", m.qs());");
					buff.append("\np.setVar(\"form_script\", f.getScript());");
					buff.append("\n");
					buff.append("\np.display();");
					buff.append("\n");
					buff.append("\n__>");
					BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path), "UTF8"));
					bw.write(Hello.replace(buff.toString().trim(), "__", "%"));
					bw.close();

					String initPath = jsp.getParentFile() + "/init.jsp";
					if(!new File(initPath).exists()) {
						StringBuffer buff2 = new StringBuffer();
						buff2.append("<__@ include file=\"../init.jsp\" __><__");
						buff2.append("\n");
						buff2.append("\nString ch = \"admin\";");
						buff2.append("\n");
						buff2.append("\n__>");
						BufferedWriter bw2 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(initPath), "UTF8"));
						bw2.write(Hello.replace(buff2.toString().trim(), "__", "%"));
						bw2.close();
					}

					if(!"".equals(ownerAccount)) {
						try { Runtime.getRuntime().exec("chown -R " + ownerAccount + ":" + ownerAccount + " " + jsp.getParentFile()); }
						catch(Exception e) {}
					}
				}

				if(!html.exists()) {
					if(!html.getParentFile().isDirectory()) html.getParentFile().mkdirs();
					BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path2), "UTF8"));
					bw.write(path2);
					bw.close();

					if(!"".equals(ownerAccount)) {
						try { Runtime.getRuntime().exec("chown -R " + ownerAccount + ":" + ownerAccount + " " + html.getParentFile()); }
						catch(Exception e) {}
					}
				}
			}
		}
	}


	public DataSet getLayouts(String path) throws Exception {
		DataSet ds = new DataSet();
		File dir = new File(path);
		if(!dir.exists()) return ds;

		File[] files = dir.listFiles();
		for(int i=0; i<files.length; i++) {
			String filename = files[i].getName();
			if("layout_".equals(filename.substring(0, 7))) {
				ds.addRow();
				ds.put("id", filename.substring(7, filename.length() - 5));
				ds.put("name", filename);
			}
		}
		return ds;
	}
	
	public int sortMenu(int id, int num, int pnum) {
		if(id == 0 || num == 0 || pnum == 0) return -1;
		DataSet info = this.find("id = " + id);
		if(!info.next()) return -1;
		this.execute("UPDATE " + table + " SET sort = sort * 1000 WHERE menu_depth = " + info.i("menu_depth") + " AND menu_type = '" + info.s("menu_type") + "' AND parent_id = " + info.i("parent_id") + "");
		this.execute("UPDATE " + table + " SET sort = " + num + " * 1000" + (pnum <= num ? "+1" : "-1") + " WHERE id = " + id);
		return autoSort(info.i("menu_depth"), info.i("parent_id"), info.s("menu_type"));
	}

	public int autoSort(int menu_depth, int pmenu, String menu_type) {
		DataSet list = this.find("menu_type = '" + menu_type + "' AND menu_depth = " + menu_depth + " AND parent_id = " + pmenu + "", "id, sort", "sort ASC");
		int sort = 1;
		while(list.next()) {
			this.execute("UPDATE " + table + " SET sort = " + sort + " WHERE id = " + list.i("id") + "");
			sort++;
		}
		return 1;
	}
	
	public DataSet getList(String menu_type) throws Exception {
		DataSet list = find("status = 1 AND menu_type = '" + menu_type + "'", "*", "depth ASC, sort ASC");
		setData(list);
		return getTreeList(menu_type);
	}


	public DataSet getTreeList(String menu_type) throws Exception {
		DataSet tops = find("status = 1 AND menu_depth = 1 AND menu_type = '" + menu_type + "'", "*", "sort ASC");
		DataSet tree = new DataSet();
		while(tops.next()) {
			tree.addRow(tops.getRow());
			tree.put("name_conv", tops.s("menu_name"));
			DataSet ds = getTree(tops.s("id"));
			while(ds.next()) {
				if(ds.i("menu_depth") > 1) {
					ds.put("name_conv", getTreeNames(ds.s("id")));
					tree.addRow(ds.getRow());
				}
			}
		}
		tree.first();
		return tree;
	}

	public String getTreeNames(int id) throws Exception {
		return getTreeNames(""+id);
	}

	public String getTreeNames(String id) throws Exception {
		Vector<String> v = getParentNames(id);
		Collections.reverse(v);
		return Hello.join(" > ", v.toArray());
	}

	public String getNames(int id) {
		DataSet info = this.find("id = " + id);
		if(!info.next()) return "";
		String names = info.s("menu_nm");
		int pid = info.i("parent_id");
		for(int i = info.i("depth"); i > 1; i--) {
			DataSet pinfo = this.find("id = " + pid);
			if(pinfo.next()) {
				names =	pinfo.s("menu_nm") + " > " + names;
				pid = pinfo.i("parent_id");
			} else { break;	}
		}
		return names;
	}

	/*
 	 *  Make Tree by Hierarchy data
	 */

	public String name = "id";
	public String pName = "parent_id";
	public String nName = "menu_name";
	public String rootNode = "0";
	private DataSet data;
	private Hashtable map;
	private Hashtable pMap;
	private DataSet result;
	private Vector pNodes;
	private Vector pNames;
	private int menu_depth = 0;

	public void setData(DataSet data) throws Exception {
		data.first();
		DataSet list = new DataSet();
		while(data.next()) { list.addRow(data.getRow()); }
		this.data = list;
		data.first();
	}

	public DataSet getTree() throws Exception {
		return getTree(rootNode);
	}

	public DataSet getTree(String id) throws Exception {
		if(null == data) return new DataSet();
		data.first();
		pMap = new Hashtable();
		DataSet sRow = new DataSet(); int i = 0;
		while(data.next()) {
			String pid = data.s(pName);
			Vector nodes = pMap.containsKey(pid) ? (Vector)pMap.get(pid) : new Vector();
			nodes.add(data.getRow());
			pMap.put(pid, nodes);
			if(!rootNode.equals(id) && data.s(name).equals(id)) sRow.addRow(data.getRow());
			if(rootNode.equals(id) && i++ == 0) sRow.addRow(data.getRow());
		}
		result = new DataSet(); sRow.first();
		if(sRow.next()) {
			result.addRow(sRow.getRow());
			childNodes(sRow.s(name));
			result.first();
		}
		return result;
	}

	private void childNodes(String pid) throws Exception { //private
		if(pMap.containsKey(pid)) {
			Object[] nodes = ((Vector)pMap.get(pid)).toArray();
			for(int i=0; i<nodes.length; i++) {
				Hashtable row = (Hashtable)nodes[i];
				result.addRow(row);
				childNodes(row.get(name).toString());
			}
		}
	}

	public Vector getChildNodes(String[] nodes) throws Exception {
		Vector<String> result = new Vector<String>();
		for(int i=0, max=nodes.length; i<max; i++) {
			result.add(nodes[i]);
		}
		return result;
	}

	public String[] getChildNodes(String id) throws Exception {
		DataSet list = getTree(id);
		String[] nodes = new String[list.size()]; int i = 0;
		while(list.next()) nodes[i++] = list.s("id");
		return nodes;
	}

	public String[] getParentNodes(String id) throws Exception {
		if(null == data) return new String[] {};
		data.first();
		map = new Hashtable();
		while(data.next()) map.put(data.s(name), data.getRow());
		pNodes = new Vector();
		parentNodes(id + "");
		String[] nodes = new String[pNodes.size()];
		return (String[])pNodes.toArray(nodes);
	}

	private void parentNodes(String id) throws Exception { //private
		if(map.containsKey(id)) {
			pNodes.add(id);
			Hashtable row = (Hashtable)map.get(id);
			pNames.add(row.containsKey(nName) ? row.get(nName).toString() : "");
			parentNodes(row.get(pName).toString());
		}
	}

	public Vector getParentNames(String id) throws Exception {
		if(null == data) return new Vector();
		data.first();
		map = new Hashtable();
		while(data.next()) map.put(data.s(name), data.getRow());
		pNodes = new Vector(); pNames = new Vector();
		parentNodes(id + "");
		return pNames;
	}

	public DataSet getTreeData(String id) throws Exception {
		if(null == data) return new DataSet();
		data.first();
		pMap = new Hashtable();
		DataSet sRow = new DataSet();
		while(data.next()) {
			String key = data.s(pName);
			DataSet ds = pMap.containsKey(key) ? (DataSet) pMap.get(key) : new DataSet();
			ds.addRow(data.getRow());
			ds.first(); int i = 1;
			while(ds.next()) ds.put("__last", ds.size() == i++);
			pMap.put(key, ds);
			if(data.s(pName).equals(id)) sRow.addRow(data.getRow());
		}
		sRow.first(); int j = 1;
		while(sRow.next()) {
			String key = sRow.s(name);
			sRow.put(".sub", pMap.containsKey(key) ? childNodeData(key) : new DataSet());
			sRow.put("__last", sRow.size() == j++);
		}
		return sRow;
	}

	private DataSet childNodeData(String pid) throws Exception { //private
		DataSet nodes = (DataSet) pMap.get(pid);
		nodes.first(); menu_depth++;
		while(nodes.next()) {
			String key = nodes.s(name);
			nodes.put(".sub" + menu_depth, pMap.containsKey(key) ? childNodeData(key) : new DataSet());
		}
		menu_depth--;
		return nodes;
	}


}