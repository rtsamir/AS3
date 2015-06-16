package oc.com.loader
{
	
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import oc.com.display.DestructSprite;

	
	public class BytesArrayLoader extends DestructSprite
	{
		
		private var mIndex:int = -1;
		private var mCallback:Function;
		private var mAttachedData:Object;
		
		public function BytesArrayLoader(url:String, callback:Function = null, index:int = 0, attachedData:Object = null)
		{
			super();
			mIndex = index;
			mCallback = callback;
			mAttachedData = attachedData;
			init(url);
		}
		
		protected function init(pUrl:String):void
		{
			var uldr : URLLoader = new URLLoader();
			uldr.dataFormat = URLLoaderDataFormat.BINARY;
			uldr.addEventListener(Event.COMPLETE, onBytesComplete);
			
			uldr.load(new URLRequest(pUrl + ".swf"));
		}
		
		private function onBytesComplete(e : Event) : void
		{
			var bytes : ByteArray = (e.target as URLLoader).data;
			
			var ldr : Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onChildComplete);
			
			//var ldrC : LoaderContext = new LoaderContext();
			var ldrC : LoaderContext = new LoaderContext();
			
			ldrC.allowCodeImport = true;
			
			ldr.loadBytes(bytes, ldrC);
		}
		
		private function onChildComplete(e : Event) : void
		{
			if(mCallback == null)
				return;
			switch(mCallback.length)
			{
				case 0:
					mCallback();
					break;
				case 1:
					mCallback((e.target).content);
					break;
				case 2:
					mCallback((e.target).content,mIndex);
					break;
				case 3:
					mCallback((e.target).content,mIndex,mAttachedData);
					break;
				default:
				{
					break;
				}
			}	
		}
	}
}