package oc.com.display
{

	import flash.events.Event;
	import flash.geom.Point;
	

	import oc.com.loader.RTLoader;

	
	public class GameAssetsBase extends DestructSprite 
	{
		protected var path:String;
		protected var mId:String
		protected var mActers:Vector.<LoopInteractionSprite>;
		
		public function GameAssetsBase()
		{
			super();
		}
		//------------------------------------------------------
		
		public function get id():String
		{
			return mId;
		}
		//------------------------------------------------------
		
		public function set id(value:String):void
		{
			mId = value;
		}
		//------------------------------------------------------
		
		override public function destruct():void
		{
			mActers = null;
			super.destruct();
		}
		//------------------------------------------------------
		
		public function addImage(filePath:String,x:int = 0,y:int = 0,pivot:Point = null):RTLoader
		{
			return addImageFile(path + filePath,x,y,pivot)
		}
		//------------------------------------------------------
		

		
		public function addImageFile(filePath:String,x:int = 0,y:int = 0,pPivot:Point = null):RTLoader
		{
			var aImage:RTLoader = new RTLoader(filePath);
			if(pPivot != null)
				aImage.pivot= pPivot;
			aImage.x = x;
			aImage.y = y;
			addChild(aImage);
			return(aImage);
		}
		//------------------------------------------------------
		
		public function attachedToMouse():void
		{
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
		}
		//------------------------------------------------------
		
		protected function onEnterFrame(event:Event):void
		{

			
		}	
	}
}