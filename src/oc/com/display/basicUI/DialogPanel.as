package oc.com.display.basicUI
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	import oc.com.display.ButtonSimple;
	
	
	public class DialogPanel extends ComponentBase
	{
		
		public function DialogPanel(pDaialogGUI:MovieClip,pAttachedData:Object = null,pReturnCallback:Function = null)
		{
			super(pDaialogGUI,null);
			show(pAttachedData,pReturnCallback);

		}
	
		public function show(pAttachedData:Object = null,pReturnCallback:Function = null):void {
			mAttachedData = pAttachedData;
			mReturnCallback = pReturnCallback;
			this.scaleX = this.scaleY = 0.6;
			Tweener.addTween(this,{scaleX:baseScale,scaleY:baseScale,time:1,transition:"easeOutBack"});
			
			if(mGUI.button_Cancel != null)
				mButtons.push(new ButtonSimple(mGUI.button_Cancel,closePanel,null));
			if(mGUI.button_OK != null)
				mGUI.button_OK.addEventListener(MouseEvent.CLICK , onOK);
			x = locaionX;
			y = locaionY;
		}
		
		public function setText(pTitle:String, pBody:String):void
		{
			
			mGUI.title.text = pTitle;
			mGUI.body.text = pBody;
		}
		
		
		public function hide():void {

		}
		
		
		protected function onOK(e:Event):void
		{
			if(mReturnCallback != null)
				mReturnCallback("ok",mAttachedData);
			//trace("OK");
		}
		
		protected function closePanel(pButton:ButtonSimple = null):void
		{
			if(mReturnCallback != null)
				mReturnCallback("Cancel",mAttachedData);
			Tweener.addTween(this,{scaleX:0,scaleY:0,time:0.3,transition:"easeInBack"});
			setTimeout(destruct,500);
		}
		
		
		override public function destruct():void
		{
			if(mGUI != null) {
				if(mGUI.button_OK != null)
					mGUI.button_OK.removeEventListener(MouseEvent.CLICK , onOK);
			}
			super.destruct();
		}

		protected function get baseScale():Number
		{
			return 1;
		}

		protected function get locaionX():Number
		{
			return 0;
		}
		protected function get locaionY():Number
		{
			return 0;
		}
	}
}