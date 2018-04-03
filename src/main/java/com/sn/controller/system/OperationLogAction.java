package com.sn.controller.system;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sn.entity.OperationLog;
import com.sn.service.OperationLogService;
import com.sn.util.PagedResult;

/**
 * @author gly
 * @version 1.0
 * @since 1.0
 */

@Controller
@RequestMapping("system/operatinglog")
public class OperationLogAction {
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private OperationLogService baseOperationLogService;
	
	private ComData com;
	
	@RequestMapping("show")
	public String show(){ 
		return "system/operation_log";
	}

	@RequestMapping("getData")
	@ResponseBody
	public Map<String,Object> getData(Integer draw,Map<String,Object>model){
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
			case "1" : orderByStr = " username";break;
			case "2" : orderByStr = " createdate";break;
			case "3" : orderByStr = " operating";break;
		}
		
		orderByStr = orderByStr + " " + desc[0];
		
		OperationLog operationLog=new OperationLog();
		if(value != null && value.length > 0){
			if(!StringUtils.isEmpty(value[0])){
				operationLog.setUsername(value[0]);
			}
		}
		
		PagedResult<OperationLog> page_list = baseOperationLogService.findByPageCustom(operationLog, indexPage, pageSize, orderByStr);
		List<OperationLog> operationlog_list = page_list.getDataList();
		model.put("recordsTotal", page_list.getTotal()); 
		model.put("recordsFiltered", page_list.getTotal()); 
		model.put("draw", draw);  
		model.put("com", com);
		model.put("data", operationlog_list); 
		return model;
	}
	 
}
