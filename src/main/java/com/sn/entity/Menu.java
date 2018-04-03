package com.sn.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class Menu  {
	 
	
		private String fuid;
		private String menuName;
		private String menuParentid;
		private String menuUrl;
		private Integer menuOrder;
		private String images;
		private java.util.Date createdate;
		private java.util.Date modifydate;
		private String createuserrealname;
		private String createuserid;
		private String modifyuserrealname;
		private String modifyuserid;
		
		//---------tree
		private String id;
		private String text;
		private Boolean checked;
		private Boolean hasChild;
		private Map<String,Boolean> state;
		//--------------
		private List<Operating> Operating_list;
		
		private List<Object> children=new ArrayList<Object>();
		
		
		public void setFuid(String value) {
			this.fuid = value;
		}
		
		public String getFuid() {
			return this.fuid;
		}
		public void setMenuName(String value) {
			this.menuName = value;
		}
		
		public String getMenuName() {
			return this.menuName;
		}
		public void setMenuParentid(String value) {
			this.menuParentid = value;
		}
		
		public String getMenuParentid() {
			return this.menuParentid;
		}
		public void setMenuUrl(String value) {
			this.menuUrl = value;
		}
		
		public String getMenuUrl() {
			return this.menuUrl;
		}
		public void setMenuOrder(Integer value) {
			this.menuOrder = value;
		}
		
		public Integer getMenuOrder() {
			return this.menuOrder;
		}
		public void setImages(String value) {
			this.images = value;
		}
		
		public String getImages() {
			return this.images;
		}
		public void setCreatedate(java.util.Date value) {
			this.createdate = value;
		}
		
		public java.util.Date getCreatedate() {
			return this.createdate;
		}
		public void setModifydate(java.util.Date value) {
			this.modifydate = value;
		}
		
		public java.util.Date getModifydate() {
			return this.modifydate;
		}
		public void setCreateuserrealname(String value) {
			this.createuserrealname = value;
		}
		
		public String getCreateuserrealname() {
			return this.createuserrealname;
		}
		public void setCreateuserid(String value) {
			this.createuserid = value;
		}
		
		public String getCreateuserid() {
			return this.createuserid;
		}
		public void setModifyuserrealname(String value) {
			this.modifyuserrealname = value;
		}
		
		public String getModifyuserrealname() {
			return this.modifyuserrealname;
		}
		public void setModifyuserid(String value) {
			this.modifyuserid = value;
		}
		
		public String getModifyuserid() {
			return this.modifyuserid;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getText() {
			return text;
		}

		public void setText(String text) {
			this.text = text;
		}

		public Boolean getChecked() {
			return checked;
		}

		public void setChecked(Boolean checked) {
			this.checked = checked;
		}

		public Boolean getHasChild() {
			return hasChild;
		}

		public void setHasChild(Boolean hasChild) {
			this.hasChild = hasChild;
		}

		  
		public List<Operating> getOperating_list() {
			return Operating_list;
		}

		public void setOperating_list(List<Operating> operating_list) {
			Operating_list = operating_list;
		}

		public List<Object> getChildren() {
			return children;
		}

		public void setChildren(List<Object> children) {
			this.children = children;
		}

		public Map<String, Boolean> getState() {
			return state;
		}

		public void setState(Map<String, Boolean> state) {
			this.state = state;
		}
	

}	 

