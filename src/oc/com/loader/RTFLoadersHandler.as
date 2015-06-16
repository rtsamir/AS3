package oc.com.loader
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	import oc.com.event.EventManager;

	public class RTFLoadersHandler
	{
		public static const EVENT_FINISH_LOAD:String = "EVENT_FINISH_LOAD";
		private var mLoaders:Vector.<RTFlashLoader>;
		private var mIndexInLoad:Number;
		private var mStringsToLoad:Vector.<String>;
		
		public function RTFLoadersHandler()
		{
			mLoaders = new Vector.<RTFlashLoader>();
		}
		public function setLoaders(value:Vector.<String>):void
		{
			mStringsToLoad = value;
			mIndexInLoad = 0;
			setLoader();
		}
		private function setLoader():void
		{
			if (mIndexInLoad<mStringsToLoad.length)
			{
				mLoaders.push(new RTFlashLoader(mStringsToLoad[mIndexInLoad],setLoader));
				mIndexInLoad++;
			}
			else
			{
				EventManager.manager.dispatchEvent(EVENT_FINISH_LOAD);
			}
			
			
		}
		
		public function getInstance(pName:String):Object
		{
			for (var i:Number = 0; i< mLoaders.length;i++){
				var obj:Object = mLoaders[i].getInstance(pName);
				if(obj != null){
					return obj;
				}
			}
			return null;
		}
		
		public function getItem(pName:String):DisplayObject
		{
			for (var i:Number = 0; i< mLoaders.length;i++){
				var obj:DisplayObject = mLoaders[i].getItem(pName);
				if(obj != null){
					return obj;
				}
			}
			return null;	
		}
		
		
		public function getMovieClip(pName:String):MovieClip
		{
			return (getItem(pName) as MovieClip);
		}
		public function getSound(pName:String):Sound
		{
			return (getInstance(pName) as Sound);
		}
		
		
	}
}