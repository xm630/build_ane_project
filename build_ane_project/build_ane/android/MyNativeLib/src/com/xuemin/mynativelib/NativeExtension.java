package com.xuemin.mynativelib;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class NativeExtension implements FREExtension{

	private static NativeContext context;
	@Override
	public FREContext createContext(String arg0) { //需要返回一个FREContext对象
		context = new NativeContext();
		return context;
	}

	@Override
	public void dispose() { // Extension结束后的操作
		
	}

	@Override
	public void initialize() { //Extension初始化的操作
		
	}
	
	public static void dispatchStatusEventAsync(String code, String level) {
		if(context != null) {
			context.dispatchStatusEventAsync(code, level);
		}
	}
}
