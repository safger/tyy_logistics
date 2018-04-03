package com.sn.dao;

import java.util.*;

import com.sn.entity.*;
import com.sn.service.*;  

import java.util.List; 

import org.apache.ibatis.annotations.Param;



public interface OperatingMapper {
	
	 int deleteByPrimaryKey(String fuid);

	    int insert(Operating record);

	    int insertSelective(Operating record);

	    Operating selectByPrimaryKey(String fuid);

	    int updateByPrimaryKeySelective(Operating record);

	    int updateByPrimaryKey(Operating record);
	    
	    List<Operating> selectByColum(Operating record);
	    
	    int deleteByColum(Operating record);
	 
	    int deleteByByPrimaryKeys(List<String> ids);
	    
	    List<Operating>  selectLikeColum(String columName, String value);
	    
	    List<Operating>  selectByCustom(Operating record);
	    
	    int countByColum(Operating record);
	    
	    List<Operating> selectOp(@Param("OrganizeId") String OrganizeId, @Param("menu_id") String menu_id);
	    
	    List<Operating>  selectOperationMenu(Operating record);
}
