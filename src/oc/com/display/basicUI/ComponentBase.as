package oc.com.display.basicUI
{
	import flash.display.MovieClip;
	
	import oc.com.display.ButtonSimple;
	import oc.com.display.DestructSprite;
	
	public class ComponentBase extends DestructSprite
	{
		protected var mGUI:MovieClip;
		protected var mButtons:Vector.<ButtonSimple>;
		protected var mAttachedData:Object;
		protected var mReturnCallback:Function;

		
		public function ComponentBase(pGUI:MovieClip, pAttachedData:Object = null,pIsToAddChild:Boolean = true)
		{
			super();
			mButtons = new Vector.<ButtonSimple>();
			mAttachedData = pAttachedData;
			mGUI = pGUI;
			if(pIsToAddChild){
				addChild(mGUI);
			}
		}
		
		override public function destruct():void
		{
			if(mButtons != null){
				for(var i:int  = 0 ; i < mButtons.length; i++)
				{
					if(mButtons[i] != null){
						mButtons[i].destruct();
					}
				}
				mButtons = null;
			}
			mGUI = null;
			super.destruct();
		}
	}
}