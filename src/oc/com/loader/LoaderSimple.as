package oc.com.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class LoaderSimple extends Loader
	{
	
		protected var mIndex:int = -1;

		public function get url():String
		{
			return mURL;
		}

		protected var mCallback:Function;
		protected var mErrorCallback:Function;
		protected var mAttachedData:Object;
		protected var mURL:String;
		
		public function LoaderSimple(pUrl:String = "", callback:Function = null,index:int = 0,attachedData:Object = null,onError:Function = null)
		{
			super();
			mURL = pUrl;
			mIndex = index;
			mCallback = callback;
			mErrorCallback = onError;
			mAttachedData = attachedData;
			configureListeners(contentLoaderInfo);
			if(pUrl == "") {
				return;
			}
			var request:URLRequest = new URLRequest(pUrl);
			load(request);
		}
		
		
		protected function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
		//	dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
		//	dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//dispatcher.addEventListener(Event.OPEN, openHandler);
			//dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			//dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
		}
		
		protected function completeHandler(event:Event):void {
			//if(content is Bitmap)
			//{
			//	(content as Bitmap).smoothing = true;
			//}
			sendCallBack(mCallback);
		}
		
		protected function sendCallBack(pCallback:Function):void
		{
			if(pCallback == null)
				return;
			switch(pCallback.length)
			{
				case 0:
					pCallback();
					break;
				case 1:
					pCallback(this);
					break;
				case 2:
					pCallback(this,mIndex);
					break;
				case 3:
					pCallback(this,mIndex,mAttachedData);
					break;
				default:
				{
					break;
				}
			}
		}
		protected function httpStatusHandler(event:HTTPStatusEvent):void {
			//trace("httpStatusHandler: " + event);
		}
		
		protected function initHandler(event:Event):void {
			//trace("initHandler: " + event);
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			sendCallBack(mErrorCallback);
		}
		
		protected function openHandler(event:Event):void {
			//trace("openHandler: " + event);
		}
		
		protected function progressHandler(event:ProgressEvent):void {
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		protected function unLoadHandler(event:Event):void {
		//	trace("unLoadHandler: " + event);
		}
		
		public  function destruct():void
		{
			unload();
			removeListeners(contentLoaderInfo);
		}
		
		protected function removeListeners(dispatcher:IEventDispatcher):void {
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.removeEventListener(Event.INIT, initHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.removeEventListener(Event.OPEN, openHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(Event.UNLOAD, unLoadHandler);
		}
		
		public function get attachedData():Object
		{
			return mAttachedData;
		}
	}
}