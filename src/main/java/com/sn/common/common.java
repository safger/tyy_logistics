package com.sn.common;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.NetworkInterface;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;

public class common {
	/**
	 * 该方法是用于获取物理MAC地址
	 * 
	 * @param InetAddress
	 *            :IP地址
	 * @return MAC地址
	 * 
	 */
	private static String getMACAddress(InetAddress ia) throws Exception {
		// 获得网络接口对象（即网卡），并得到mac地址，mac地址存在于一个byte数组中。
		byte[] mac = NetworkInterface.getByInetAddress(ia).getHardwareAddress();

		// 下面代码是把mac地址拼装成String
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < mac.length; i++) {
			if (i != 0) {
				sb.append("-");
			}
			// mac[i] & 0xFF 是为了把byte转化为正整数
			String s = Integer.toHexString(mac[i] & 0xFF);
			sb.append(s.length() == 1 ? 0 + s : s);
		}

		// 把字符串所有小写字母改为大写成为正规的mac地址并返回
		return sb.toString().toUpperCase();
	}

	/**
	 * 获取访问者IP
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Real-IP");
		if (!StringUtils.isEmpty(ip) && !"unknown".equalsIgnoreCase(ip)) {
			return ip;
		}
		ip = request.getHeader("X-Forwarded-For");
		if (!StringUtils.isEmpty(ip) && !"unknown".equalsIgnoreCase(ip)) {
			// 多次反向代理后会有多个IP值，第一个为真实IP。
			int index = ip.indexOf(',');
			if (index != -1) {
				return ip.substring(0, index);
			} else {
				return ip;
			}
		} else {
			return request.getRemoteAddr();
		}
	}

	/**
	 * 该方法是用于截短中英混合字符串
	 * 
	 * @param text
	 *            :需要截短的字符串
	 * @param length
	 *            :要保留的字符串长度
	 * @return 完成截短的字符串.如被截短则以...结尾
	 * 
	 */
	public static String splitStr(String text, int length) {
		int textLength = text.length();
		int byteLength = 0;
		StringBuffer returnStr = new StringBuffer();
		for (int i = 0; i < textLength && byteLength < length * 2; i++) {
			String str_i = text.substring(i, i + 1);
			if (str_i.getBytes().length == 1) {// 英文
				byteLength++;
			} else {// 中文
				byteLength += 2;
			}
			returnStr.append(str_i);
		}
		try {
			if (byteLength < text.getBytes("gbk").length) {
				returnStr.append("...");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return returnStr.toString();
	}

	/**
	 * 该方法是用于截短中英混合字符串
	 * 
	 * @param text
	 *            :需要截短的字符串
	 * @param length
	 *            :要保留的字符串长度
	 * @param endWith
	 *            :截短后要追加的字符串
	 * @return 完成截短的字符串.
	 * 
	 */
	public static String splitStr(String text, int length, String endWith) {
		int textLength = text.length();
		int byteLength = 0;
		StringBuffer returnStr = new StringBuffer();
		for (int i = 0; i < textLength && byteLength < length * 2; i++) {
			String str_i = text.substring(i, i + 1);
			if (str_i.getBytes().length == 1) {// 英文
				byteLength++;
			} else {// 中文
				byteLength += 2;
			}
			returnStr.append(str_i);
		}
		try {
			if (byteLength < text.getBytes("gbk").length) {
				returnStr.append(endWith);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return returnStr.toString();
	}


	/**
	 * 将数组中的数字大小从大到小重新排序
	 */
	public static String[] orderList(String[] code) {
		int max = 0;
		int tmp = 0;
		for (int i = 0; i < code.length; i++) {
			max = i;//
			/** 查找第 i大的数，直到记下第 i大数的位置 ***/
			for (int j = i + 1; j < code.length; j++) {
				if (Integer.parseInt(code[max]) < Integer.parseInt(code[j]))
					max = j;// 记下较大数位置，再次比较，直到最大
			}
			/*** 如果第 i大数的位置不在 i,则交换 ****/
			if (i != max) {
				tmp = Integer.parseInt(code[i]);
				code[i] = code[max];
				code[max] = tmp + "";
			}
		}
		return code;
	}

	/**
	 * @see 根据IP获取地区信息
	 * @author xiao
	 * @param ip
	 * @return
	 */
	public static Map<String, String> GetAddressByIp(String ip) {
		Map<String, String> map = new HashMap<String, String>();
		String resout = "";
		try {
			String str = getJsonContent("http://ip.taobao.com/service/getIpInfo.php?ip=" + ip);
			System.out.println(str);

			JSONObject obj = JSONObject.parseObject(str);
			JSONObject obj2 = (JSONObject) obj.get("data");
			String code = String.valueOf(obj.get("code"));
			if (code.equals("0")) {
				resout = obj2.get("country") + "--" + obj2.get("area") + "--" + obj2.get("region") + "--" + obj2.get("city") + "--" + obj2.get("county") + "--" + obj2.get("isp");
				map.put("country", String.valueOf(obj2.get("country")));
				map.put("area", String.valueOf(obj2.get("area")));
				map.put("region", String.valueOf(obj2.get("region")));
				map.put("city", String.valueOf(obj2.get("city")));
				map.put("county", String.valueOf(obj2.get("county")));
				map.put("isp", String.valueOf(obj2.get("isp")));
			} else {
				resout = "IP地址有误";
			}
		} catch (Exception e) {
			e.printStackTrace();
			resout = "获取IP地址异常：" + e.getMessage();
		}
		System.out.println(resout);
		return map;
	}

	public static String getJsonContent(String urlStr) {
		try {// 获取HttpURLConnection连接对象
			URL url = new URL(urlStr);
			HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
			// 设置连接属性
			httpConn.setConnectTimeout(3000);
			httpConn.setDoInput(true);
			httpConn.setRequestMethod("GET");
			// 获取相应码
			int respCode = httpConn.getResponseCode();
			if (respCode == 200) {
				return ConvertStream2Json(httpConn.getInputStream());
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "";
	}

	private static String ConvertStream2Json(InputStream inputStream) {
		String jsonStr = "";
		// ByteArrayOutputStream相当于内存输出流
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		int len = 0;
		// 将输入流转移到内存输出流中
		try {
			while ((len = inputStream.read(buffer, 0, buffer.length)) != -1) {
				out.write(buffer, 0, len);
			}
			// 将内存流转换为字符串
			jsonStr = new String(out.toByteArray());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonStr;
	}

	/**
	 * 是否异地登录
	 */
	public static boolean isRemote(String previousIp, String localIp) {
		boolean isRemote = true;
		Map<String, String> previous = GetAddressByIp(previousIp);
		String previousCity = previous.get("city");
		System.out.println("上一次登录所在地为：" + previousCity);

		Map<String, String> local = GetAddressByIp(localIp);
		String localCity = local.get("city");
		System.out.println("本次登录所在地为：" + localCity);

		if (!previousCity.equals(localIp)) {
			isRemote = false;
		}
		return isRemote;
	}
 
	/**
	 * @see 判断实体类属性是否有值
	 * @author xiao
	 * @param obj
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public static Boolean PropertyEmpty(Object obj) throws IllegalArgumentException, IllegalAccessException{
		Boolean re=false;
		for (Field f : obj.getClass().getDeclaredFields()) {
			f.setAccessible(true);
			 if (f.get(obj) != null) { //判断字段是否为空，并且对象属性中的基本都会转为对象类型来判断
				 re=true;
				 break;
			}
		} 
		return re;
	}
	public static void main(String[] args) throws IllegalArgumentException, IllegalAccessException {
		//GetAddressByIp("115.203.187.164");
	}
}
