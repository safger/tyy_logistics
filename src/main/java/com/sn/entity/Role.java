package com.sn.entity;

import java.util.ArrayList;
import java.util.List;


public class Role  {
	 
	
		private String fuid;
		private String systemid;
		private String organizeid;
		private String code;
		private String realname;
		private String category;
		private Integer sortcode;
		private Integer deletemark;
		private Integer enabled;
		private String description;
		private java.util.Date createdate;
		private String createuserid;
		private String createuserrealname;
		private java.util.Date modifydate;
		private String modifyuserid;
		private String modifyuserrealname;
		private List<Object> children=new ArrayList<Object>();

		public void setFuid(String value) {
			this.fuid = value;
		}
		
		public String getFuid() {
			return this.fuid;
		}
		public void setSystemid(String value) {
			this.systemid = value;
		}
		
		public String getSystemid() {
			return this.systemid;
		}
		public void setOrganizeid(String value) {
			this.organizeid = value;
		}
		
		public String getOrganizeid() {
			return this.organizeid;
		}
		public void setCode(String value) {
			this.code = value;
		}
		
		public String getCode() {
			return this.code;
		}
		public void setRealname(String value) {
			this.realname = value;
		}
		
		public String getRealname() {
			return this.realname;
		}
		public void setCategory(String value) {
			this.category = value;
		}
		
		public String getCategory() {
			return this.category;
		}
		public void setSortcode(Integer value) {
			this.sortcode = value;
		}
		
		public Integer getSortcode() {
			return this.sortcode;
		}
		public void setDeletemark(Integer value) {
			this.deletemark = value;
		}
		
		public Integer getDeletemark() {
			return this.deletemark;
		}
		public void setEnabled(Integer value) {
			this.enabled = value;
		}
		
		public Integer getEnabled() {
			return this.enabled;
		}
		public void setDescription(String value) {
			this.description = value;
		}
		
		public String getDescription() {
			return this.description;
		}
		public void setCreatedate(java.util.Date value) {
			this.createdate = value;
		}
		
		public java.util.Date getCreatedate() {
			return this.createdate;
		}
		public void setCreateuserid(String value) {
			this.createuserid = value;
		}
		
		public String getCreateuserid() {
			return this.createuserid;
		}
		public void setCreateuserrealname(String value) {
			this.createuserrealname = value;
		}
		
		public String getCreateuserrealname() {
			return this.createuserrealname;
		}
		public void setModifydate(java.util.Date value) {
			this.modifydate = value;
		}
		
		public java.util.Date getModifydate() {
			return this.modifydate;
		}
		public void setModifyuserid(String value) {
			this.modifyuserid = value;
		}
		
		public String getModifyuserid() {
			return this.modifyuserid;
		}
		public void setModifyuserrealname(String value) {
			this.modifyuserrealname = value;
		}
		
		public String getModifyuserrealname() {
			return this.modifyuserrealname;
		}

		public List<Object> getChildren() {
			return children;
		}

		public void setChildren(List<Object> children) {
			this.children = children;
		}
	

}	 

