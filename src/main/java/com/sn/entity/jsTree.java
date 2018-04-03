package com.sn.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class jsTree {
	private String id;
	private String text;
	private Map<String,Boolean> state;
	private List<jsTree> children=new ArrayList<jsTree>();
	private String parentid;
	private Integer layer;
	private String icon; 

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

	public List<jsTree> getChildren() {
		return children;
	}

	public void setChildren(List<jsTree> children) {
		this.children = children;
	}

	public String getParentid() {
		return parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	public Integer getLayer() {
		return layer;
	}

	public void setLayer(Integer layer) {
		this.layer = layer;
	}

 
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Map<String, Boolean> getState() {
		return state;
	}

	public void setState(Map<String, Boolean> state) {
		this.state = state;
	}
	
	
}
  class  State {
	private Boolean opened;
	private Boolean selected;
	 
	public State(){
		opened=true; 
		selected=false;
	}
	
	public Boolean getOpened() {
		return opened;
	}
	public void setOpened(Boolean opened) {
		this.opened = opened;
	}
	public Boolean getSelected() {
		return selected;
	}
	public void setSelected(Boolean selected) {
		this.selected = selected;
	}
}
