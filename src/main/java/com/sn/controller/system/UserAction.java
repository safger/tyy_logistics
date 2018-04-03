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

import com.alibaba.fastjson.JSONArray;
import com.sn.common.UUIDCreater;
import com.sn.entity.Menu;
import com.sn.entity.Organize;
import com.sn.entity.User;
import com.sn.entity.UserRole;
import com.sn.service.MenuService;
import com.sn.service.OperationLogService;
import com.sn.service.OrganizeService;
import com.sn.service.UserRoleService;
import com.sn.service.UserService;
import com.sn.util.PagedResult;

/**
 * @author xiaofeng
 * @version 1.0
 * @since 1.0
 */

@Controller
@RequestMapping("/system")
public class UserAction  {
	
	@Autowired
	private  HttpServletRequest request;
	@Autowired
	private  HttpServletResponse response;
	@Autowired 
	private OperationLogService operationLogService;
	@Autowired
	private UserService userService;
	@Autowired
	private OrganizeService organizeService;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private MenuService menuService;
	
	private String url="";
	
	@RequestMapping("show")
	public String show(){
		return "system/user";
	}
 
	/**
	 * @see 根据组织显示用户信息
	 * @param pageSize
	 * @param indexPage
	 * @param OrganizeId
	 * @param skey 
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("usershow")
	@ResponseBody
	public Map<String, Object> Usershow(String OrganizeId,Integer draw,Map<String,Object> model) throws IOException{
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
			case "3" : orderByStr = " realname";break;
			case "4" : orderByStr = " mobile";break;
			case "5" : orderByStr = " lastvisit";break;
			case "6" : orderByStr = " description";break;
		}
		orderByStr = orderByStr + " " + desc[0];
		User user=new User();
		if(value != null && value.length > 0){
			user.setUsername(value[0]);
		}
		user.setDepartmentid(OrganizeId);
		user.setDeletemark(0);
		PagedResult<User>   page_list=userService.findByPageCustom(user, indexPage, pageSize);
		List<User> baseUser_list=page_list.getDataList();
	    if(baseUser_list!=null&&baseUser_list.size()>0){
	    	for(int a=0;a<baseUser_list.size();a++){
	    		List<UserRole> baseUserRole_list= userRoleService.selectView(baseUser_list.get(a).getFuid());
	    		if(baseUserRole_list!=null&&baseUserRole_list.size()>0){
	    			String rolename="";
	    			for(int b=0;b<baseUserRole_list.size();b++){
	    				rolename+=baseUserRole_list.get(b).getRealname()+";";
	    			}
	    			baseUser_list.get(a).setRoleid(rolename);
	    		}
	    	}
	    } 
	    model.put("recordsTotal", page_list.getTotal()); 
		 model.put("recordsFiltered", page_list.getTotal()); 
		 model.put("draw", draw);  
		 model.put("data", baseUser_list); 
		return model;
	}
	 
	@RequestMapping("index")
	public String index(Map<String,Object> model){
		String userid=(String)request.getSession().getAttribute("userid");
		List<Menu> list=menuService.selectView(userid);
		List<Menu> baseMenu_all=menuService.selectAll("menu_order");
		for(int i=0;i<list.size();i++){
			Menu n=hasParent(baseMenu_all,list.get(i).getMenuParentid());
			if(n!=null){
				if(!isexit(n.getFuid(),list)){
					list.add(n); 
				}
			}
		}
		
		List<Menu> parentList=new ArrayList<Menu>();
		for(int i=0;i<baseMenu_all.size();i++){
			Menu m = (Menu) baseMenu_all.get(i);
			m.setText(m.getMenuName());
			m.setId(m.getFuid());
    		if(m.getMenuParentid().equals("1")){
    			m = getChildOrg(baseMenu_all, m.getFuid(), m,list);
    			parentList.add(m);
    		}
    	}
		String in="";
		if(parentList!=null){
			for(int a=0;a<parentList.size();a++){
				if(parentList.get(a).getChildren()==null||parentList.get(a).getChildren().size()==0){
					in+=""+a+",";
				}
			}
		}
		in=in.length()>0?in.substring(0,in.length()-1):in;
		String temp[]=in.split(",");
		int b=0;
		if(temp!=null&&temp.length>0&&in.length()>0){
			for(int a=0;a<temp.length;a++){
				parentList.remove(Integer.parseInt(temp[a])-b);
				b++;
			}
		} 
		model.put("parentList", parentList); 
	/*	if(url.length()>0&&!url.equals("/system/index.html")){
			return "redirect:"+url; 
		} 
		else{
			
		}*/
		return "system/index";
	}
	
	@RequestMapping("menuData")
	public String menuData(Map<String,Object> model){
		String userid=(String)request.getSession().getAttribute("userid");
		List<Menu> list=menuService.selectView(userid);
		List<Menu> baseMenu_all=menuService.selectAll("menu_order");
		for(int i=0;i<list.size();i++){
			Menu n=hasParent(baseMenu_all,list.get(i).getMenuParentid());
			if(n!=null){
				if(!isexit(n.getFuid(),list)){
					list.add(n);
				}
			}
		}
		List<Menu> parentList=new ArrayList<Menu>();
		for(int i=0;i<baseMenu_all.size();i++){
			Menu m = (Menu) baseMenu_all.get(i);
			m.setText(m.getMenuName());
			m.setId(m.getFuid());
    		if(m.getMenuParentid().equals("1")){
    			m = getChildOrg(baseMenu_all, m.getFuid(), m,list);
    			parentList.add(m);
    		}
    	}
		String in="";
		if(parentList!=null){
			for(int a=0;a<parentList.size();a++){
				if(parentList.get(a).getChildren()==null||parentList.get(a).getChildren().size()==0){
					in+=""+a+",";
				}
			}
		}
		in=in.length()>0?in.substring(0,in.length()-1):in;
		String temp[]=in.split(",");
		int b=0;
		if(temp!=null&&temp.length>0&&in.length()>0){
			for(int a=0;a<temp.length;a++){
				parentList.remove(Integer.parseInt(temp[a])-b);
				b++;
			}
		} 
		model.put("parentList", parentList);
		return "system/left";
	}
	/***********************修改密码*********************************/
	/**
	 * 修改密码 UI
	 */
	@RequestMapping("showPass")
	public String UpdateShowPass(){
		return "system/passwordUpdate";
	}
	
	/**
	 * @see 原始密码验证
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("PasswordRepeat")
	public String  PasswordRepeat(String password) throws IOException{
		PrintWriter out = response.getWriter();
		String userid=(String)request.getSession().getAttribute("userid");
		if (userid != null) {
			User baseUser =userService.findById(userid);
			if (baseUser.getUserpassword().trim().equals(password.trim())) {
				out.print("false");
			} else {
				out.print("true");
			}
		}
		return null;
	}
	
	
	/**
	 * @see 修改密码
	 * @return
	 */
	@RequestMapping("UpdatePass")
	public String  UpdatePass(String password) throws IOException{
		String userid=(String)request.getSession().getAttribute("userid");
		if (userid != null) {
			User baseUser =userService.findById(userid);
			baseUser.setUserpassword(password);
			userService.update(baseUser);
		}
		return "passLogout";
	}
	
	
	/********************************************************/
	
	
	/**
	 * @see 获取二级菜单
	 * @author xiao
	 * @return
	 */
	@RequestMapping("child")
	public String getChild(String id,String skey,Map<String,Object> model){
		String userid=(String)request.getSession().getAttribute("userid");
		List<Menu> list=menuService.selectView(userid);
		List<Menu> baseMenu_all=menuService.selectAll("menu_order");
		List<Menu> parentList=new ArrayList<Menu>();
		for(int i=0;i<list.size();i++){
			Menu m = (Menu) list.get(i);
			m.setText(m.getMenuName());
			m.setId(m.getFuid()); 
    		if(m.getMenuParentid().equals(id)){
    			m = getChildOrg(baseMenu_all, m.getFuid(), m,list);
    			parentList.add(m);
    		}
    	}
		model.put("parentList", parentList);
		model.put("skey",skey);
		model.put("id",id);
		return "system/left";
	}  
	
	public Menu hasParent(List<Menu> list,String parentid){
		Menu m=null;
		if(list!=null){
			for(int i=0;i<list.size();i++){
				if(list.get(i).getFuid().equals(parentid)){
					m=list.get(i); 
				}
			}
		} 
		return m;
	}
	public Boolean isexit(String id,List<Menu> list){
		Boolean s=false;
		if(list!=null){
			for(int i=0;i<list.size();i++){
				if(list.get(i).getFuid().equals(id)){
					s=true;
					break;
				} 
			}
		} 
		return s;
	}
	public Menu getChildOrg(List<?> list,String id,Menu menu,List<Menu> mlist){
    	for(int i=0;i<list.size();i++){
    		Menu m = (Menu) list.get(i);
    		if(!m.getMenuParentid().equals("1")&&m.getMenuParentid().equals(id)){
    			if(mlist!=null){
    				for(int a=0;a<mlist.size();a++){
    					if(m.getFuid().equals(mlist.get(a).getFuid())){
    						menu.getChildren().add(m);
    						if(a==0){
    							url=m.getMenuUrl();
    						}
    					}
    				}
    			}
    			m = getChildOrg(list, m.getFuid(), m,mlist);
    		}
    	}
    	return menu;
    }
	/**
	 * @see ajax 编辑用户
	 * @param OrganizeId
	 * @param baseUser
	 * @param skey
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("edit")
	@ResponseBody
	public String edit(String OrganizeId,User baseUser) throws IOException{
		String username=(String)request.getSession().getAttribute("username");
		String userid=(String)request.getSession().getAttribute("userid");
		PrintWriter out=response.getWriter();
		String DepartmentName=""; 
		if(OrganizeId!=null){
			Organize  baseOrganize =organizeService.findById(OrganizeId);
			if(baseOrganize!=null){
				DepartmentName=baseOrganize.getFullname();
			}
		}
		String id=baseUser.getFuid();
		if(id!=null&&id.length()>0){
			baseUser.setModifydate(new Date());
			baseUser.setModifyuserid(userid);
			baseUser.setModifyuserrealname(username);
			userService.updateSelective(baseUser);
			/*
			 * 记录操作日志
			 */
			operationLogService.saveLog("修改用户"+baseUser.getUsername());
		}else{
			baseUser.setFuid(UUIDCreater.getUUID());
			baseUser.setDeletemark(0);
			baseUser.setCreatedate(new Date());
			baseUser.setCreateuserid(userid);
			baseUser.setDepartmentid(OrganizeId);
			baseUser.setDepartmentname(DepartmentName); 
			baseUser.setLogincount(1);
			baseUser.setUseronline(1);
			baseUser.setCreateuserrealname(username);
			baseUser.setModifydate(new Date());
			baseUser.setModifyuserid(userid);
			baseUser.setModifyuserrealname(username);
			userService.insert(baseUser);
			/*
			 * 记录操作日志
			 */
			operationLogService.saveLog("新增用户"+baseUser.getUsername());
		}
		out.print("1");
		return null; 
	}
	/**
	 * @see ajax 查询用户信息
	 * @param id
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("update_show")
	@ResponseBody
	public String update_show(String OrganizeId,String id) throws IOException{
		PrintWriter out=response.getWriter();
		User baseUser=userService.findById(id); 
		baseUser.setOrganizeId(OrganizeId);
		out.print(JSONArray.toJSONString(baseUser));
		return null;
	}
	/**
	 * @see ajax 删除
	 * @param id
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("delete")
	@ResponseBody 
	public String delete(String id) throws IOException{
		PrintWriter out=response.getWriter();
		if(id!=null&&id.length()>0){
			UserRole userRole=new UserRole();
			userRole.setUserid(id);
			userRoleService.deleteByColum(userRole);
			
			
			User baseUser=userService.findById(id);
			userService.deleteById(id);
			/*baseUser.setDeletemark(1);
			userService.update(baseUser);*/
			/*
			 * 记录操作日志 
			 */
			operationLogService.saveLog("删除用户"+baseUser.getUsername());
			out.print("1");
		}
		
		return null; 
	}
	@RequestMapping("IsExist")
	@ResponseBody
	public String IsExist(String username) throws IOException{
		PrintWriter out = response.getWriter();
		User user=new User();
		user.setUsername(username);
		user.setDeletemark(0);
		int a =userService.countByColum(user);
		if (a>0) {
			out.print("false");
		} else { 
			out.print("true");
		}
		return null;
	}
	/**
	 * @see 用户分配角色
	 * @param userid
	 * @param roleid
	 * @param OrganizeId
	 * @param model
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("AssignRoles")
	@ResponseBody
	public String AssignRoles(String userid,String roleid,String OrganizeId) throws IOException{
		PrintWriter out=response.getWriter();
		String username1=(String)request.getSession().getAttribute("username");
		String userid1=(String)request.getSession().getAttribute("userid");
		if(userid!=null&&userid.length()>0){ 
			String fuid[]=userid.split(",");
			if(fuid!=null&&fuid.length>0){
				for(int a=0;a<fuid.length;a++){
					//清空原先角色
					UserRole u=new UserRole();
					u.setUserid(fuid[a]);
					List<UserRole> BaseUserRole_list=userRoleService.selectByColum(u);
					if(BaseUserRole_list!=null&&BaseUserRole_list.size()>0){
						List<String> ids=new ArrayList<String>();
						for(int i=0;i<BaseUserRole_list.size();i++){
							ids.add(BaseUserRole_list.get(i).getFuid());
						}
						userRoleService.deleteByByPrimaryKeys(ids);
					}
					//赋予新角色
					if(roleid!=null&&roleid.length()>0){
						String uid[]=roleid.split(",");
						if(uid!=null&&uid.length>0){ 
							for(int b=0;b<uid.length;b++){
								UserRole baseUserRole =new UserRole();
								baseUserRole.setFuid(UUIDCreater.getUUID());
								baseUserRole.setCreatedate(new Date());
								baseUserRole.setCreateuserid(userid1);
								baseUserRole.setCreateuserrealname(username1);
								baseUserRole.setModifydate(new Date());
								baseUserRole.setModifyuserid(userid1);
								baseUserRole.setModifyuserrealname(username1);
								baseUserRole.setUserid(fuid[a]);
								baseUserRole.setRoleid(uid[b]);
								userRoleService.insert(baseUserRole);
								/*
								 * 记录操作日志
								 */
								User baseUser=userService.findById(fuid[a]);
								operationLogService.saveLog("为用户"+baseUser.getUsername()+"分配角色");
							}
						}
					}
				}
			}
		}
		out.print("1");
		return null; 
	}
 
	@RequestMapping("home")
	public String home(){
		return "system/home";
	}
	 
}
