package com.sn.common;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * @ClassName StringUtil
 * @Description 字符串处理公用类
 * @author oriental_pearl
 * @date 2012-3-23
 */
public class StringUtil {
	public static final String EMPTY = "";

	public static boolean isNotBlank(String str)
	{
		return (str != null) && (!str.isEmpty());
	}

	public static boolean isBlank(String str)
	{
		return (str == null) || (str.length() == 0);
	}

	public static boolean isNotTrimBlank(String str)
	{
		return (str != null) && (!str.trim().isEmpty());
	}

	public static boolean isTrimBlank(String str)
	{
		return (str == null) || (str.trim().isEmpty());
	}
	
	public static int compareLength(String str1,String str2){
		if(isNotBlank(str1)&&isNotBlank(str2)){
			return str1.trim().length()-str2.trim().length();
		}
		return 0;
	}
	
	public static boolean isStartsWith(String str1,String str2){
		if(isNotBlank(str1)&&isNotBlank(str2)){
			return str1.startsWith(str2);
		}
		return false;
	}

	public static String capFirstUpperCase(String str)
	{
		if (isBlank(str)) {
			return str;
		}
		return str.substring(0, 1).toUpperCase() + str.substring(1);
	}

	public static String capFirstLowerCase(String str)
	{
		if (isBlank(str)) {
			return str;
		}
		return str.substring(0, 1).toLowerCase() + str.substring(1);
	}

	public static String fieldName2javaName(String fieldName)
	{
		if (isTrimBlank(fieldName)) {
			return "";
		}
		String[] strs = fieldName.split("_");
		StringBuilder sb = new StringBuilder();
		for (String str : strs) {
			sb.append(capFirstUpperCase(str.toLowerCase()));
		}
		return capFirstLowerCase(sb.toString());
	}

	public static String javaName2fieldName(String javaName)
	{
		if (isTrimBlank(javaName)) {
			return "";
		}
		javaName = javaName.replaceAll("([A-Z])", "_$1");
		return javaName.toUpperCase();
	}

	public static String tableName2className(String tableName)
	{
		String className = fieldName2javaName(tableName);
		return capFirstUpperCase(className);
	}

	public static String className2tableName(String className)
	{
		if (isTrimBlank(className)) {
			return "";
		}
		String tableName = capFirstLowerCase(className);
		tableName = javaName2fieldName(tableName);
		return tableName.toUpperCase();
	}

	public static boolean isIdNo(String idNo)
	{
		if (isTrimBlank(idNo)) {
			return false;
		}
		Pattern p = Pattern.compile("^([1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3})|([1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[X,x]))$");
		Matcher matcher = p.matcher(idNo);
		return matcher.find();
	}

	public static boolean isMobile(String mobile)
	{
		if (isTrimBlank(mobile)) {
			return false;
		}
		Pattern p = Pattern.compile("^(?:13\\d|15\\d|18\\d)-?\\d{8}$");
		Matcher matcher = p.matcher(mobile);
		return matcher.find();
	}

	/**
	 * 字符串转整数
	 * 
	 * @param str
	 * @param defValue
	 * @return
	 */
	public static int toInt(String str, int defValue) {
		try {
			return Integer.parseInt(str);
		} catch (Exception e) {
		}
		return defValue;
	}

	/**
	 * 对象转整数
	 * 
	 * @param obj
	 * @return 转换异常返回 0
	 */
	public static int toInt(Object obj) {
		if (obj == null)
			return 0;
		return toInt(obj.toString(), 0);
	}

	/**
	 * 对象转整数
	 * 
	 * @param obj
	 * @return 转换异常返回 0
	 */
	public static long toLong(String obj) {
		return toLong(obj, 0);
	}
	
	/**
	 * 对象转整数
	 * 
	 * @param obj
	 * @return 转换异常返回 0
	 */
	public static long toLong(String obj, long default_val) {
		try {
			return Long.parseLong(obj);
		} catch (Exception e) {
		}
		return default_val;
	}

	/**
	 * 字符串转布尔值
	 * 
	 * @param b
	 * @return 转换异常返回 false
	 */
	public static boolean toBool(String b) {
		try {
			return Boolean.parseBoolean(b);
		} catch (Exception e) {
		}
		return false;
	}

	/**
	 * 字符串快速转布尔类型
	 * 
	 * @param obj
	 *            String类型的0或1
	 * @return 转换异常或String为0返回false 1返回true
	 */
	public static boolean toIntToBool(String obj) {
		int val = toInt(obj);
		if (val == 0)
			return false;
		else
			return true;
	}
	
	
	/**
	 * 去除空格/换行/制表符/回车等符号
	 * \n 回车(\u000a) 
	 * \t 水平制表符(\u0009)
	 * \s 空格(\u0008)  
	 * \r 换行(\u000d)
	 * @param str
	 * @return
	 */
	public static String replaceBlank(String str) {
        String dest = "";
        if (str!=null) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }
}
