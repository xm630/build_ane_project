package com.xuemin.mynativelib;

import android.app.Activity;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

public class GetNativeDataFunction implements FREFunction{
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		Activity activity = arg0.getActivity(); 
		Log.i("ANE", activity.getPackageName()); // 使用安卓的日志方法打印出应用的包名
		int params1 = 0;
		String params2 = null;
		try {
			params1 = arg1[0].getAsInt();    // 获取第一个参数
			params2 = arg1[1].getAsString(); // 获取第二个参数
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		}
		
		FREObject freObject = null;
		try {
			String nativeData = params1 + params2; //将参数1与参数2拼接
			freObject = FREObject.newObject(nativeData);
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		}
		return freObject; //返回结果
	}
}
