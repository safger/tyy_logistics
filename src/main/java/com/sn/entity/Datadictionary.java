package com.sn.entity;


public class Datadictionary  {
	 
	
		private String fuid;
		private String fullname;
		private String code;
		private String parentcode;
		private Integer sequence;
		private String description;
		private java.util.Date createdate;
		private java.util.Date modifydate;
		private String modifyuserrealname;

		public void setFuid(String value) {
			this.fuid = value;
		}
		
		public String getFuid() {
			return this.fuid;
		}
		public void setFullname(String value) {
			this.fullname = value;
		}
		
		public String getFullname() {
			return this.fullname;
		}
		public void setCode(String value) {
			this.code = value;
		}
		
		public String getCode() {
			return this.code;
		}
		
		public String getParentcode() {
			return parentcode;
		}

		public void setParentcode(String parentcode) {
			this.parentcode = parentcode;
		}

		public void setSequence(Integer value) {
			this.sequence = value;
		}
		
		public Integer getSequence() {
			return this.sequence;
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
		public void setModifydate(java.util.Date value) {
			this.modifydate = value;
		}
		
		public java.util.Date getModifydate() {
			return this.modifydate;
		}
		public void setModifyuserrealname(String value) {
			this.modifyuserrealname = value;
		}
		
		public String getModifyuserrealname() {
			return this.modifyuserrealname;
		}
	

}	 

