package com.sn.controller.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sn.common.UUIDCreater;
import com.sn.entity.Datadictionary;
import com.sn.service.DatadictionaryService;
import com.sn.type.Result;
import com.sn.util.PagedResult;

@Controller
@RequestMapping("system/data/")
public class DatadictionaryAction  {
	
	@Autowired
	private  HttpServletRequest request;
	@Autowired
	private  HttpServletResponse response;
	@Autowired
	private DatadictionaryService datadictionaryService;
	private ComData com;
	
	@RequestMapping("show") 
	public String show(String skey,String parentcode,Integer indexPage,Integer pageSize,Map<String,Object>model){
		String roleid=(String)request.getSession().getAttribute("roleid");
		com=CompetenceManager.getCom(roleid, "system/data/show.html");
		if(!com.getHisSelect()){
			return "error";
		}
		model.put("com", com);
		
		return "system/data_dictionary"; 
	}
	
	/**
	 * 
	 * @param draw  datatable固定参数
	 * @param level 用于记录页面级数
	 * @param model
	 * @return
	 */
	@RequestMapping("getData")
	@ResponseBody
	public Map<String,Object> getData(Integer draw,Integer level,Map<String,Object>model){
		String roleid=(String)request.getSession().getAttribute("roleid");
		com=CompetenceManager.getCom(roleid, "system/data/show.html");
		if(!com.getHisSelect()){
			model.put("code", "1");
			model.put("msg", "无此权限");
			return model;
		}
		int pageSize = 10;
		String length = request.getParameter("length");
		if(!StringUtils.isEmpty(length)){
			pageSize = Integer.parseInt(length);
		}
		int start = Integer.parseInt(request.getParameter("start"));
		int indexPage = start / pageSize + 1;
		Map<String, String[]> params = request.getParameterMap();
		String[] sort = params.get("order[0][column]");
		String[] desc = params.get("order[0][dir]");
		String[] value = params.get("search[value]");
		
		String orderByStr = null;
		switch(sort[0]){ 
			case "1" : orderByStr = " fullname";break;
			case "2" : orderByStr = " code";break;
			case "3" : orderByStr = " sequence";break;
		}
		
		orderByStr = orderByStr + " " + desc[0];
		
		String parentcode = request.getParameter("parentcode");
		
		Datadictionary datadictionary=new Datadictionary();
		if(value != null && value.length > 0){
			if(!StringUtils.isEmpty(value[0])){
				datadictionary.setFullname(value[0]);
			}
		}
		
		if(parentcode!=null&&parentcode.length()>0){
			datadictionary.setParentcode(parentcode);
		}else{
			datadictionary.setFuid("3");
		}
		
		PagedResult<Datadictionary> page_list = datadictionaryService.findByPageCustom(datadictionary, indexPage, pageSize, orderByStr);
		List<Datadictionary> datadictionary_list = page_list.getDataList();
		model.put("recordsTotal", page_list.getTotal()); 
		model.put("recordsFiltered", page_list.getTotal()); 
		model.put("draw", draw);  
		model.put("com", com);
		model.put("data", datadictionary_list); 
		return model;
	}

	@RequestMapping("edit")
	@ResponseBody
	public Result edit(Datadictionary baseDatadictionary,String parentcode,Map<String,Object>model){
		Result result = new Result();
		
		String roleid=(String)request.getSession().getAttribute("roleid");
		com=CompetenceManager.getCom(roleid, "system/data/show.html");
		if(!com.getHisSelect()){
			result.setCode("1");
			result.setMsg("无此操作权限");
			return result;
		}
		
		String fuid = baseDatadictionary.getFuid();
		if(StringUtils.isEmpty(fuid)){
			Datadictionary datadictionary=new Datadictionary();
			datadictionary.setCode(baseDatadictionary.getCode());
			int length=datadictionaryService.countByColum(datadictionary);
			if (length>0) {
				result.setCode("1");
				result.setMsg("该代码已经存在,请重新输入");
				return result;
			}
			
			baseDatadictionary.setFuid(UUIDCreater.getUUID());
			baseDatadictionary.setCreatedate(new Date());
			baseDatadictionary.setModifydate(new Date());
			datadictionaryService.insertSelective(baseDatadictionary);
		}else{
			baseDatadictionary.setModifydate(new Date());
			datadictionaryService.updateSelective(baseDatadictionary);
		}
		
		return result;
	}

	/**
	 * @see 获得编辑数据
	 * @author gly
	 * @throws IOException 
	 */
	@RequestMapping("getEditData") 
	@ResponseBody
	public Result getEditData(String fuid,Map<String,Object> model) throws IOException{
		Result result = new Result();
		Datadictionary datadictionary = datadictionaryService.findById(fuid);
		model.put("datadictionary", datadictionary);
		result.setData(model);
		return result;
	}
	
	
	@RequestMapping("delete")
	@ResponseBody
	public Result delete(String fuid,Map<String,Object> model){
		Result result = new Result();
		String roleid=(String)request.getSession().getAttribute("roleid");
		com=CompetenceManager.getCom(roleid, "system/data/show.html");
		if(!com.getHisSelect()){
			result.setCode("1");
			result.setMsg("无此权限");
			return result;
		}
		
		datadictionaryService.deleteById(fuid);
		return result;
	}
	
	@RequestMapping("IsExist")
	@ResponseBody
	public String IsExist(String code) throws IOException{
		PrintWriter out = response.getWriter();
		Datadictionary datadictionary=new Datadictionary();
		datadictionary.setCode(code);
		int a=datadictionaryService.countByColum(datadictionary);
		if (a>0) {
			out.print("true");
		} else {
			out.print("false");
		}
		return null;
	}
	
}
