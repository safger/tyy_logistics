package com.sn.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class Organize  {
	 
	
		private String fuid;
		private String parentid;
		private String code;
		private String fullname;
		private Integer layer;
		private String outerphone;
		private String innerphone;
		private String manager;
		private Integer deletemark;
		private Integer enabled;
		private Integer sortcode;
		private String description;
		private String address;
		private String businesslicense;
		private String managerid;
		private String possonoapplicare;
		private Double registeredcapital;
		private String contact;
		private String email;
		private String fax;
		private String operatingarea;
		private java.util.Date createdate;
		private String createuserid;
		private String createuserrealname;
		private java.util.Date modifydate;
		private String modifyuserid;
		private String modifyuserrealname;
		private String iscargo;
		private String emergency;

		
		//---------tree
		private String id;
		private String text;
		private Boolean checked;
		private Boolean hasChild;
		private Map<String,Boolean> state;
		private String url;
		 private List<Object> children=new ArrayList<Object>();
		
		public void setFuid(String value) {
			this.fuid = value;
		}
		
		public String getFuid() {
			return this.fuid;
		}
		public void setParentid(String value) {
			this.parentid = value;
		}
		
		public String getParentid() {
			return this.parentid;
		}
		public void setCode(String value) {
			this.code = value;
		}
		
		public String getCode() {
			return this.code;
		}
		public void setFullname(String value) {
			this.fullname = value;
		}
		
		public String getFullname() {
			return this.fullname;
		}
		public void setLayer(Integer value) {
			this.layer = value;
		}
		
		public Integer getLayer() {
			return this.layer;
		}
		public void setOuterphone(String value) {
			this.outerphone = value;
		}
		
		public String getOuterphone() {
			return this.outerphone;
		}
		public void setInnerphone(String value) {
			this.innerphone = value;
		}
		
		public String getInnerphone() {
			return this.innerphone;
		}
		public void setManager(String value) {
			this.manager = value;
		}
		
		public String getManager() {
			return this.manager;
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
		public void setSortcode(Integer value) {
			this.sortcode = value;
		}
		
		public Integer getSortcode() {
			return this.sortcode;
		}
		public void setDescription(String value) {
			this.description = value;
		}
		
		public String getDescription() {
			return this.description;
		}
		public void setAddress(String value) {
			this.address = value;
		}
		
		public String getAddress() {
			return this.address;
		}
		public void setBusinesslicense(String value) {
			this.businesslicense = value;
		}
		
		public String getBusinesslicense() {
			return this.businesslicense;
		}
		public void setManagerid(String value) {
			this.managerid = value;
		}
		
		public String getManagerid() {
			return this.managerid;
		}
		public void setPossonoapplicare(String value) {
			this.possonoapplicare = value;
		}
		
		public String getPossonoapplicare() {
			return this.possonoapplicare;
		}
		public void setRegisteredcapital(Double value) {
			this.registeredcapital = value;
		}
		
		public Double getRegisteredcapital() {
			return this.registeredcapital;
		}
		public void setContact(String value) {
			this.contact = value;
		}
		
		public String getContact() {
			return this.contact;
		}
		public void setEmail(String value) {
			this.email = value;
		}
		
		public String getEmail() {
			return this.email;
		}
		public void setFax(String value) {
			this.fax = value;
		}
		
		public String getFax() {
			return this.fax;
		}
		public void setOperatingarea(String value) {
			this.operatingarea = value;
		}
		
		public String getOperatingarea() {
			return this.operatingarea;
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
		public void setIscargo(String value) {
			this.iscargo = value;
		}
		
		public String getIscargo() {
			return this.iscargo;
		}
		public void setEmergency(String value) {
			this.emergency = value;
		}
		
		public String getEmergency() {
			return this.emergency;
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

		 

		public String getUrl() {
			return url;
		}

		public void setUrl(String url) {
			this.url = url;
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

