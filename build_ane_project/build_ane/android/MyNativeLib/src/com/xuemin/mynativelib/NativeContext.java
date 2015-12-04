package com.xuemin.mynativelib;

import java.util.HashMap;
import java.util.Map;

import android.content.Intent;
import android.content.res.Configuration;
import android.util.Log;

import com.adobe.air.AndroidActivityWrapper;
import com.adobe.air.AndroidActivityWrapper.ActivityState;
import com.adobe.air.LifeCycle;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class NativeContext extends FREContext implements LifeCycle{
	
	private AndroidActivityWrapper activityWrapper;

	public NativeContext() {
		activityWrapper = AndroidActivityWrapper.GetAndroidActivityWrapper(); //ActivityWrapper
		activityWrapper.addActivityResultListener(this); // 监听onActivityResult方法
		activityWrapper.addActivityStateChangeListner(this); // 监听生命周期方法
	}
	
	@Override
	public void dispose() { // Context结束后的操作
		if(activityWrapper != null)
			activityWrapper.removeActivityResultListener(this);
			activityWrapper.removeActivityStateChangeListner(this);
	}
	
	@Override
	public Map<String, FREFunction> getFunctions() { // 需要返回一个包含FREFunction的Map集合
		Map<String, FREFunction> map = new HashMap<String, FREFunction>();
		map.put("getNativeData", new GetNativeDataFunction());
		return map;
	}
	
	
	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) { // onActivityResult方法
		Log.i("ANE", "onActivityResult");
	}

	@Override
	public void onActivityStateChanged(ActivityState state) { // 生命周期变化
		switch (state) {
		case RESUMED: // 生命周期onResume
			Log.i("ANE", "onResume");
			break;
		case STARTED: // 生命周期onStart
			Log.i("ANE", "onStart");
			break;
		case RESTARTED: // 生命周期onRestart
			Log.i("ANE", "onRestart");
			break;
		case PAUSED: // 生命周期onPause
			Log.i("ANE", "onPause");
			break;
		case STOPPED: // 生命周期onStop
			Log.i("ANE", "onStop");
			break;
		case DESTROYED: // 生命周期onDestory
			Log.i("ANE", "onDestory");
			break;
		}
	}

	@Override
	public void onConfigurationChanged(Configuration config) {
		
	}

}
