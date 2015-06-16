package oc.com.loader
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.setTimeout;
	
	import oc.com.display.GameAssetsBase;

	
	public class RTLoader extends GameAssetsBase
	{
		protected static var mLoaderCache:Object = new Object();
		protected static var mBitmapCache:Object = new Object();
		protected var mLoaderContext:LoaderContext;
		protected var mIndex:int = -1;
		protected var mCallback:Function;
		protected var mErrorCallback:Function;
		protected var mAttachedData:Object;
		protected var mLoader:Loader;
		protected var mBitmap:DisplayObject;
		protected var mBitmapData:BitmapData;
		protected var mURL:String;
		public var pivot:Point;
		
		public function RTLoader(pUrl:String = "", callback:Function = null,index:int = 0,attachedData:Object = null,onError:Function = null)
		{
			super();
			mURL = pUrl;
			mIndex = index;
			mCallback = callback;
			mErrorCallback = onError;
			mAttachedData = attachedData;
			if(mURL == "")
				return;
			mLoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			init();
		}
		
		protected function init():void
		{
			if(mLoaderCache[mURL] != null)
			{
				getFromCache(mLoaderCache[mURL]);
				return;
			}
			mLoader = new Loader();
			mLoaderCache[mURL] = mLoader;
			addChild(mLoader);
			var aURLRequest:URLRequest = new URLRequest(mURL);
			mLoader.load(aURLRequest,mLoaderContext);
			configureListeners(mLoader.contentLoaderInfo);
		}
		
		
		private function getFromCache(pLoader:Loader):void
		{
			if(pLoader.content == null)
			{
				setTimeout(getFromCache,100,pLoader);
				return;
			}
			
			if(pLoader.content is Bitmap)
			{
				mBitmapData = (pLoader.content as Bitmap).bitmapData;
				mBitmapCache[mURL] = mBitmapData;
				mBitmap = new Bitmap (mBitmapData);
				(mBitmap as Bitmap).smoothing = true;
				addChild(mBitmap);
				setTimeout(completeHandler,10);
			}
		}
		
		protected function configureListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
		}
		
		protected function completeHandler(event:Event = null):void
		{ 
			if(mLoader != null)
			{
				mBitmap = (mLoader.content)
				if(mBitmap is Bitmap)
				{
					mBitmapData = (mBitmap as Bitmap).bitmapData;
					mBitmapCache[mURL] = mBitmapData;
					(mBitmap as Bitmap).smoothing = true;
				}
			}
			if (pivot != null)
			{
				mBitmap.x = -pivot.x;
				mBitmap.y = -pivot.y;
				//DisplayUtils.createCircel(7,0xff0000,this);
			}
			sendCallBack(mCallback);
		}
		
		private function sendCallBack(pCallback:Function):void
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
		
		public function get proggress():int {
			if(mLoader == null){
				return (0);
			}
			if(mLoader.contentLoaderInfo == null){
				return (0);
			}
			trace("progressHandler: bytesLoaded=" + mLoader.contentLoaderInfo.bytesLoaded + " bytesTotal=" + mLoader.contentLoaderInfo.bytesTotal);
			var aP:int = Math.floor(mLoader.contentLoaderInfo.bytesLoaded / mLoader.contentLoaderInfo.bytesTotal * 100);
			return ( aP);
		}
		
		protected function progressHandler(event:ProgressEvent):void {
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		
		protected function unLoadHandler(event:Event):void {
			//trace("unLoadHandler: " + event);
		}
		
		public override function destruct():void
		{
			
			//if(mBitmapData != null)
			//	mBitmapData.dispose();
			mBitmapData = null;
			if(mLoader != null)
			{
				removeListeners(mLoader.contentLoaderInfo);
				mLoader.unload();
				mLoader = null;
			}
			super.destruct();
			mLoaderCache[mURL] = null;
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
		
		public function get bitmapData():BitmapData
		{
			return mBitmapData;
		}
		
		public static function get loaderCache():Object
		{
			return mLoaderCache;
		}

		public function get URL():String
		{
			return mURL;
		}

		public static function get bitmapCache():Object
		{
			return protected::mBitmapCache;
		}

		public  function get content():DisplayObject
		{
			return mLoader.content;
		}

	}
}