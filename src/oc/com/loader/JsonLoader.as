package oc.com.loader
{	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import oc.com.utils.GlobalContext;
	import oc.com.utils.Logger;


public class JsonLoader extends URLLoader
	{
		private var mIndex:int = -1;
		private var mCallback:Function;
		private var mErrorCallback:Function;
		private var mAttachedData:Object;
		private var mURL:String;
		
		public function JsonLoader(pUrl:String,pCallback:Function = null,pErrorCallback:Function = null,pIndex:int = 0,attachedData:Object = null, pSendData:Object=null)
		{
			super();
			mURL = pUrl;
			mIndex = pIndex;
			mCallback = pCallback;
			mErrorCallback = pErrorCallback;
			mAttachedData = attachedData;
			var vars: URLVariables;
			//var sendHeader:URLRequestHeader = new URLRequestHeader("charset=utf-8");
			var myRequest:URLRequest = new URLRequest(pUrl);
			if(pSendData != null) {
				if(!(pSendData is URLVariables)) {
				vars = new URLVariables();
				//myRequest.requestHeaders.push(sendHeader);
				vars.data  = getData(pSendData);
				myRequest.method = URLRequestMethod.POST;
				myRequest.data = vars;  // JSON.stringify(vars); // change for exabit to vars;
				}
				else {
				vars = pSendData as URLVariables;
				myRequest.method = URLRequestMethod.POST;
				myRequest.data = vars;
				}
			}
			addEventListener(Event.COMPLETE, onload);
			addEventListener(IOErrorEvent.IO_ERROR,onError);
			load(myRequest);
		}
		//_____________________________________________________________
		
		protected function getData(pSendData:Object):String
		{
			return JSON.stringify(pSendData);
		}
		//_____________________________________________________________
		
		protected function onError(event:IOErrorEvent = null):void
		{
			if(event != null){
				trace("----------- JsonLoader::onError -----------------------"); 
				trace("Error ID :" + event.errorID + " MSG" + event.text); 
				trace("URL: " + mURL); 
				trace("--------------------------------------------------------------------"); 
			}
			GlobalContext.IsConnected = false;
			if(mErrorCallback == null)
				return
         //  Logger.log(event.toString());
			switch(mErrorCallback.length)
			{
				case 0:
					mErrorCallback();
					break;
				case 1:
					mErrorCallback(event);
					break;
				case 2:
					mErrorCallback(event,mIndex);
					break;
				case 3:
					mErrorCallback(event,mIndex,mAttachedData);
					break;
			}
		}
		//_____________________________________________________________
		
		protected function onload(event:Event):void
		{
            GlobalContext.IsConnected = true;
			if (mCallback == null){
				return
			}
			var aRetObj:Object = new Object();
			if((data != "")&&(data != null)){
				try{
					aRetObj = JSON.parse(data);
				}
				catch (error:Error)
				{
					onDataError(data);
					return;
				}
			}
			switch(mCallback.length)
			{
				case 0:
					mCallback();
					break;
				case 1:
					mCallback(aRetObj);
					break;
				case 2:
					mCallback(aRetObj,mIndex);
					break;
				case 3:
					mCallback(aRetObj,mIndex,mAttachedData);
					break;
			}
		}

        private function onDataError(pData:Object):void {
            Logger.log("On Data Error: "+pData.toString());
            onError();
        }
		
		public function destruct():void{
			mErrorCallback = null;
			mCallback = null;
			removeEventListener(Event.COMPLETE, onload);
			removeEventListener(IOErrorEvent.IO_ERROR,onError);
			try 
			{
				close();
			}
			catch(e:Error) 
			{
				//trace("An error occurred " + e.toString());
			}
			
			
		}
	}		
}