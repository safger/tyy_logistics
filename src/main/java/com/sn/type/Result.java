package com.sn.type;

import java.util.Map;

/**
 * 结果类(用于ajax返回)
 * @author gly
 *
 */
public class Result {
	/**
	 * 常量 成功
	 */
	public static String SUCCESS = "0";
	
	/**
	 * 常量 失败
	 */
	public static String FAIL = "1";
	
	/**
	 * 结果码 0成功 1失败
	 */
	private String code = "0";
	
	/**
	 * 错误信息
	 */
	private String msg;
	
	/**
	 * 附带数据
	 */
	private Map<String,Object> data;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}
	
}
