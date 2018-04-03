package com.sn.controller.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.alibaba.fastjson.JSONArray;
import com.sn.common.UUIDCreater;
import com.sn.entity.MenuRole;
import com.sn.entity.Role;
import com.sn.entity.UserRole;
import com.sn.service.MenuRoleService;
import com.sn.service.OperationLogService;
import com.sn.service.RoleService;
import com.sn.service.UserRoleService;
import com.sn.util.PagedResult;

/**
 * @author xiaofeng
 * @version 1.0
 * @since 1.0
 */

@Controller
@RequestMapping("system/role/")
public class RoleAction  {
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpServletResponse response;
	@Autowired
	private OperationLogService operationLogService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private MenuRoleService menuRoleService;
	@Autowired
	private UserRoleService userRoleService;
	
	@RequestMapping("show")
	public String show(String skey,Integer pageSize,Integer indexPage,Map<String,Object>model){
		String SqlWhere="";
		if(skey!=null&&skey.length()>0){
			if(SqlWhere.length()==0){
				SqlWhere+=" fname like '%"+skey+"%'";
			}else{
				SqlWhere+=" and fname like '%"+skey+"%'";
			}
		} 
		Role role=new Role();
		role.setRealname(skey);
		role.setDeletemark(0);
		PagedResult<Role> page_list=roleService.findByPageCustom(role, indexPage, pageSize," ORGANIZEID,REALNAME,fuid");
		List<Role>baseRole_list=page_list.getDataList();
		model.put("baseRole_list", baseRole_list);
		model.put("indexPage", indexPage);
		model.put("pageSize", pageSize);
		return "system/role";
	}
	/**
	 * @see 根据组织显示角色
	 * @param OrganizeId
	 * @param draw
	 * @param model
	 * @return
	 */
	@RequestMapping("showRole")
	@ResponseBody
	public Map<String,Object> showRole(String OrganizeId,Integer draw,Map<String,Object>model){
		
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
			case "1" : orderByStr = " realname";break;
			case "4" : orderByStr = " sortcode";break;
		}
		
		orderByStr = orderByStr + " " + desc[0];
		Role role=new Role();
		if(value != null && value.length > 0){
			role.setRealname(value[0]);
		}
		role.setDeletemark(0);
		role.setOrganizeid(OrganizeId);
		PagedResult<Role> page_list = roleService.findByPageCustom(role, indexPage, pageSize, null);
		List<Role> baseRole_list = page_list.getDataList();
		 model.put("recordsTotal", page_list.getTotal()); 
		 model.put("recordsFiltered", page_list.getTotal()); 
		 model.put("draw", draw);  
		 model.put("data", baseRole_list); 
		return model;
	}
	@RequestMapping("roleCompetence")
	public String roleCompetence(){
		return "system/role_competence";
	}
	@RequestMapping("scopeRole")
	public String scopeRole(String OrganizeId,Map<String,Object>model){
		Role role=new Role();
		role.setDeletemark(0);
		role.setOrganizeid(OrganizeId);
		List<Role> baseRole_list=roleService.selectByColum(role,"REALNAME,ORGANIZEID,fuid");
		model.put("OrganizeId", OrganizeId);
		model.put("baseRole_list", baseRole_list);
		return "scopeRole";
	}
	/**
	 * @see 显示角色
	 * @param OrganizeId
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("showChange")
	@ResponseBody
	public String showChange(String OrganizeId) throws IOException{
		PrintWriter out=response.getWriter();
		String departmentid=(String)request.getSession().getAttribute("departmentid");
		String superAdmin=(String)request.getSession().getAttribute("superAdmin");
		Role role=new Role();
		role.setDeletemark(0);
		if(superAdmin!=null&&superAdmin.equals("spadmin")){
			role.setOrganizeid(OrganizeId);
		}else{
			role.setOrganizeid(departmentid);
		}
		List<Role> baseRole_list=roleService.selectByColum(role,"REALNAME,ORGANIZEID,fuid");
		out.print(JSONArray.toJSONString(baseRole_list));
		return null;
	}
	/**
	 * @see 根据组织编辑角色
	 * @param baseRole
	 * @param OrganizeId
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	
	@RequestMapping("edit")
	@ResponseBody
	public String edit(Role baseRole,String OrganizeId) throws IOException{
		PrintWriter out=response.getWriter();
		String username=(String)request.getSession().getAttribute("username");
		String userid=(String)request.getSession().getAttribute("userid");
		String id=baseRole.getFuid();
		if(id!=null&&id.length()>0){
			baseRole.setModifydate(new Date());
			baseRole.setModifyuserid(userid);
			baseRole.setModifyuserrealname(username);
			baseRole.setEnabled(1);
			roleService.updateSelective(baseRole);
			/*
			 * 记录操作日志
			 */
			operationLogService.saveLog("修改角色"+baseRole.getRealname());
		}else{
			baseRole.setFuid(UUIDCreater.getUUID());
			baseRole.setDeletemark(0);
			baseRole.setOrganizeid(OrganizeId);
			baseRole.setCreatedate(new Date());
			baseRole.setCreateuserid(userid);
			baseRole.setEnabled(1);
			baseRole.setCreateuserrealname(username);
			baseRole.setModifydate(new Date());
			baseRole.setModifyuserid(userid);
			baseRole.setModifyuserrealname(username);
			roleService.insert(baseRole);
			/*
			 * 记录操作日志
			 */
			operationLogService.saveLog("新增角色"+baseRole.getRealname());
		}
		out.print("1");
		return null; 
	}
	@RequestMapping("Enable")
	public String Enable(String id,Role baseRole,String OrganizeId,Map<String,Object>model){
		if(id!=null&&id.length()>0){
			baseRole.setEnabled(1);
			roleService.updateSelective(baseRole);
		} 
		model.put("OrganizeId", OrganizeId);
		return "redirect:/system/role/showRole.html"; 
	}
	/**
	 * @see 显示修改
	 * @param id
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("update_show")
	@ResponseBody
	public String update_show(String id) throws IOException{
		PrintWriter out=response.getWriter(); 
		Role baseRole=roleService.findById(id);
		out.print(JSONArray.toJSONString(baseRole));
		return null;
	}
	@RequestMapping("delete")
	@ResponseBody
	public String delete(String id) throws IOException{
		PrintWriter out=response.getWriter();
		if(id!=null&&id.length()>0){
			MenuRole menuRole=new MenuRole();
			menuRole.setRoleId(id);
			menuRoleService.deleteByColum(menuRole);
			UserRole userRole=new UserRole();
			userRole.setRoleid(id);
			userRoleService.deleteByColum(userRole); 
			roleService.deleteById(id);
		}
		out.print("1");
		return null; 
	 
	}
	/**
	 * @see 启动禁用角色
	 * @param skey
	 * @param id
	 * @param OrganizeId
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("valid")
	@ResponseBody
	public String valid(String skey,String id) throws IOException{
		PrintWriter out=response.getWriter();
		Role  baseRole =roleService.findById(id);
		if(skey!=null&&skey.equals("1")){ 
			baseRole.setEnabled(1);
			roleService.update(baseRole);
		}else{
			baseRole.setEnabled(0);
			roleService.update(baseRole);
		} 
		out.print("1");
		return null; 
	}
	/**
	 * @see ajax 分配权限
	 * @param id
	 * @param RoleId
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("Assign")
	@ResponseBody
	public String Assign(String id,String RoleId) throws IOException{
		PrintWriter out=response.getWriter();
		String username=(String)request.getSession().getAttribute("username");
		String userid=(String)request.getSession().getAttribute("userid");
		if(id!=null&&RoleId!=null&&RoleId.length()>0){
			MenuRole menuRole=new MenuRole(); 
			menuRole.setRoleId(RoleId);
			menuRoleService.deleteByColum(menuRole);
			String fuid[]=id.split(",");
			if(fuid!=null){
				for(int a=0;a<fuid.length;a++){
					String tt[]=fuid[a].trim().split(";");
					MenuRole baseMenuRole=new MenuRole();
					baseMenuRole.setFuid(UUIDCreater.getUUID());
					baseMenuRole.setRoleId(RoleId);
					baseMenuRole.setOperatingId(tt[1].trim());
					baseMenuRole.setMenuId(tt[0].trim());
					baseMenuRole.setCreatedate(new Date());
					baseMenuRole.setCreateuserid(userid);
					baseMenuRole.setCreateuserrealname(username);
					baseMenuRole.setModifydate(new Date());
					baseMenuRole.setModifyuserid(userid);
					baseMenuRole.setModifyuserrealname(username);
					menuRoleService.insert(baseMenuRole);
				}
				/*
				 * 记录操作日志
				 */
				Role baseRole =roleService.findById(RoleId);
				operationLogService.saveLog("为角色"+baseRole.getRealname()+"分配权限");
			}
		}
		/*
		 * 刷新缓存
		 */
		CompetenceManager a=new CompetenceManager();
		WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();  
        ServletContext servletContext = webApplicationContext.getServletContext(); 
		a.refreshRoleMenu(servletContext);
		out.print(1);
		return null;
	}
 
}
