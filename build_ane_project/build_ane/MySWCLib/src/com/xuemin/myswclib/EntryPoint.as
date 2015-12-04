package com.xuemin.myswclib
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	
	public class EntryPoint extends EventDispatcher
	{
		private static var instance:EntryPoint; 
		private static var extensionContext:ExtensionContext;
		public static const EXTENSION_ID:String = "com.xuemin.myane"; // 我们编写的ane的唯一标识
		
		public function EntryPoint()
		{
			extensionContext = ExtensionContext.createExtensionContext(EXTENSION_ID, ""); // 创建一个与本地代码调用的ExtensionContext
			extensionContext.addEventListener(StatusEvent.STATUS, onStatus); // 添加回调事件返回监听
		}
		
		public static function getInstance():EntryPoint { //类单例方式实现
			if(instance == null)
				instance = new EntryPoint();
			return instance;
		}
		
		protected function onStatus(event:StatusEvent):void { // 本地代码的回调会返回到该方法
			this.dispatchEvent(event)
			if(event.code == "nativeCallbackSuccess") { //本地回调成功的信息
				trace(event.level); // 将回调信息打印
			} else if(event.code == "nativeCallbackFailed") { //本地回调失败的信息
				trace(event.level); // 将回调信息打印
			}
		}
		
		public static function getNativeData():String {
			var params1:int = 3;
			var params2:String = "paramsString";
			if(extensionContext != null)
				return extensionContext.call("getNativeData",params1,params2) as String;
			else
				return null;
		}
	}
}