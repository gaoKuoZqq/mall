package com.mall.util;

import java.util.List;
import java.util.Map;

public class ListMapToJson {
	public static String stringToJson(List<Map<String,Object>> list) {
		if (list == null) {
			return null;
		}
		String result = "[";
		int n = list.size();
		int m = 1;
		for (Map<String, Object> map : list) {
			if (map == null) {
				break;
			}
			result = result + "{";
			int i = map.size();
			int j = 1;
			for (java.util.Map.Entry<String, Object> entry : map.entrySet()) {
				if (j != i) {
					result = result + "\""+entry.getKey()+"\":\""+entry.getValue()+"\","; 
				}else{
					result = result + "\""+entry.getKey()+"\":\""+entry.getValue()+"\""; 
				}
			    j = j + 1;
			}
			if (n != m) {
				result = result + "},";
			}else{
				result = result + "}";
			}
			m = m + 1;
		}
		result = result + "]";
		return result;
	}
	
}
