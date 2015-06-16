package oc.com.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import oc.com.interfaces.IRTGameWrapper;
	import oc.com.utils.GlobalContext;
	
	public class GameWrapperBase extends GameAssetsBase implements IRTGameWrapper
	{
		protected var mPause:Boolean = false;
		protected var mControl:ActivityControlBase;
		
		public function GameWrapperBase()
		{
			super();
		}
		
		public function get pause():Boolean
		{
			return mPause;
		}

		public function set pause(value:Boolean):void
		{
			mPause = value;
		}

		public function init(pGameName:String = ""):void
		{
			path = GlobalContext.baseURL + pGameName;
			mActers = new Vector.<LoopInteractionSprite>();
			addEventListener(Event.ENTER_FRAME,act);
		}
		
		public function get display():Sprite
		{
			return this;
		}
		//--------------------------------------------------------------------
	
		public function get wrapper():IRTGameWrapper
		{
			return this;
		}
		//--------------------------------------------------------------------
		
		protected function act(event:Event):void
		{
			if(mPause)
				return;
			for( var i:int  = 0; i < mActers.length; i++)
				mActers[i].act();
		}	
		//--------------------------------------------------------------------
				
		override public function destruct():void
		{
			removeEventListener(Event.ENTER_FRAME,act);
			super.destruct();
		}
		
		public function callControlCommand(pCommandId:String):void{
			
		}
	}
}