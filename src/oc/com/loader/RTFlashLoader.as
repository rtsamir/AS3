package oc.com.loader
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class RTFlashLoader extends RTLoader
	{

		public function RTFlashLoader(url:String,callback:Function = null,index:int = 0,attachedData:Object = null)
		{
			super(url);
			mCallback = callback;
		}
		
		override protected function init():void
		{
			mLoader = new Loader();
			var aURLRequest:URLRequest = new URLRequest(mURL + ".swf");
			mLoader.load(aURLRequest,mLoaderContext);
			configureListeners(mLoader.contentLoaderInfo);
		}
		
		override protected function completeHandler(event:Event = null):void
		{
			if(mCallback == null)
				return;
			switch(mCallback.length)
			{
				case 0:
					mCallback();
					break;
				case 1:
					mCallback(this);
					break;
			}
		}
		
		public function getItem(pName:String):DisplayObject
		{
			if(!mLoader.contentLoaderInfo.applicationDomain.hasDefinition(pName))
				return null;
			var aClass:Class = mLoader.contentLoaderInfo.applicationDomain.getDefinition(pName) as Class;
			return (new aClass());
		}
		
		
		public function getMovieClip(pName:String):MovieClip
		{
			return (getItem(pName) as MovieClip);
		}
		public function getSound(pName:String):Sound
		{
			return (getInstance(pName) as Sound);
		}
		
		public function getInstance(pName:String):Object
		{
			if(!mLoader.contentLoaderInfo.applicationDomain.hasDefinition(pName))
				return null;
			var aClass:Class = mLoader.contentLoaderInfo.applicationDomain.getDefinition(pName) as Class;
			return (new aClass());
		}
	}
}