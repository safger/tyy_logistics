package com.sn.controller.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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

import com.alibaba.fastjson.JSON;
import com.sn.common.UUIDCreater;
import com.sn.entity.Menu;
import com.sn.entity.Operating;
import com.sn.service.MenuService;
import com.sn.service.OperatingService;
import com.sn.service.OperationLogService;
import com.sn.type.Result;
import com.sn.util.PagedResult;

/**
 * @author xiaofeng
 * @version 1.0
 * @since 1.0
 */

@Controller
@RequestMapping("system/operating/")
public class OperatingAction {
	
	@Autowired
	private  HttpServletRequest request;
	@Autowired
	private  HttpServletResponse response;
	@Autowired
	private OperationLogService operationLogService;
	@Autowired
	private OperatingService operatingService;
	@Autowired
	private MenuService menuService;
	
	@RequestMapping("show")
	public String show(){
		return "system/operation";
	}
	@RequestMapping("Operatingshow")
	@ResponseBody
	public Map<String,Object> Operatingshow(String MenuId,Integer draw,Map<String,Object>model){
		
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
			case "2" : orderByStr = " description";break;
		}
		
		orderByStr = orderByStr + " " + desc[0];
		Operating operating=new Operating();
		if(value != null && value.length > 0){
			if(!StringUtils.isEmpty(value[0])){
				operating.setFullname(value[0]);
			}
		}
		operating.setMenuid(MenuId);
		operating.setDeletemark(0);
		PagedResult<Operating> page_list = operatingService.findByPageCustom(operating, indexPage, pageSize, orderByStr);
		List<Operating> operating_list = page_list.getDataList();
		 model.put("recordsTotal", page_list.getTotal()); 
		 model.put("recordsFiltered", page_list.getTotal()); 
		 model.put("draw", draw);  
		 model.put("data", operating_list); 
		 return model;
	}
	
	@RequestMapping("operating_info_edit")
	public String operating_info_edit(){
		return "system/operating_info_edit";
	}
	@RequestMapping("edit")
	@ResponseBody
	public Result edit(Operating operating,Map<String,Object>model){
		Result result = new Result();
		
		String username=(String)request.getSession().getAttribute("username");
		String userid=(String)request.getSession().getAttribute("userid");
		String id=operating.getFuid();
		if(id!=null&&id.length()>0){
			operating.setModifydate(new Date());
			operating.setModifyuserid(userid);
			operating.setModifyuserrealname(username);
			operatingService.updateSelective(operating);
			/*
			 * 记录操作日志
			 */
			Menu  baseMenu =menuService.findById(operating.getMenuid());
			operationLogService.saveLog("修改菜单"+baseMenu.getMenuName()+operating.getFullname()+"的操作权限");
		}else{
			Operating param = new Operating();
			param.setCode(operating.getCode());
			param.setDeletemark(0);
			int count = operatingService.countByColum(param);
			if(count > 0){
				result.setCode("1");
				result.setMsg("该代码已经存在,请重新输入");
				return result;
			}
			
			operating.setFuid(UUIDCreater.getUUID());
			operating.setDeletemark(0);
			operating.setCreatedate(new Date());
			operating.setCreateuserid(userid);
			operating.setCreateuserrealname(username);
			operating.setModifydate(new Date());
			operating.setModifyuserid(userid);
			operating.setModifyuserrealname(username);
			operatingService.insert(operating);
			/*
			 * 记录操作日志
			 */
			Menu  baseMenu =menuService.findById(operating.getMenuid());
			operationLogService.saveLog("新增菜单"+baseMenu.getMenuName()+operating.getFullname()+"的操作权限");
		}
		
		return result;
	}
	@RequestMapping("update_show")
	@ResponseBody
	public Map<String,Object> update_show(String id,Map<String,Object> model){
		Operating baseOperating=operatingService.findById(id);
		model.put("baseOperating", baseOperating);
		return model;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Map<String,Object> delete(String id,String MenuId,Map<String,Object> model){
		Operating baseOperating= operatingService.findById(id);
		baseOperating.setDeletemark(1);
		operatingService.update(baseOperating);
		/*
		 * 记录操作日志
		 */
		Menu  baseMenu =menuService.findById(MenuId);
		operationLogService.saveLog("删除菜单"+baseMenu.getMenuName()+baseOperating.getFullname()+"的操作权限");
		return model;
	}
	@RequestMapping("tree")
	@ResponseBody
	public String tree() throws IOException{
		response.setCharacterEncoding("UTF-8");
		PrintWriter out=response.getWriter();
		List<Menu> parentList=new ArrayList<Menu>();
		List<Menu> baseMenu_list = menuService.selectAll("MENU_ORDER,fuid");
		for(int i=0;i<baseMenu_list.size();i++){
			Menu m = (Menu) baseMenu_list.get(i);
			m.setText(m.getMenuName());
			m.setId(m.getFuid());
    		if(m.getMenuParentid().equals("1")){
    			m = getChild(baseMenu_list, m.getFuid(), m);
    			parentList.add(m);
    		}
    	}
		String strs = JSON.toJSONString(parentList);
		out.print(strs);
		return null;
	}
	 public Menu getChild(List<?> list,String id,Menu baseMenu){
	    	for(int i=0;i<list.size();i++){
	    		Menu m = (Menu) list.get(i);
	    		if(!m.getMenuParentid().equals("1")&&m.getMenuParentid().equals(id)){
	    			m = getChild(list, m.getFuid(), m);
	    			m.setText(m.getMenuName());
	    			m.setId(m.getFuid());
	    			baseMenu.getChildren().add(m);
	    		}
	    	}
	    	return baseMenu;
	    }
	 
	 
 
}
