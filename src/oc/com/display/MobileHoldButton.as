package oc.com.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import oc.com.utils.GlobalContext;
	
	public class MobileHoldButton extends MobileButton
	{

		private var mOnUpCallback:Function;
	//	private var mButton:MovieClip;
		private var mOnDownCallback:Function;
		public static var mCurrentButton:MobileHoldButton;
		
		
		public function MobileHoldButton(pButton:MovieClip, pOnDownCallback:Function, pOnUpCallback:Function, pAttachedData:Object=null, isPropagation:Boolean=false)
		{
			
			super(pButton, null, pAttachedData, isPropagation);
			mOnUpCallback = pOnUpCallback;
			mOnDownCallback = pOnDownCallback;
			GlobalContext.stage.addEventListener(MouseEvent.MOUSE_UP,onUp);
			mButton.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			
		}
		private function onEnter(e:Event):void
		{
			if (mCurrentButton == null)
				return
			if (mCurrentButton.mButton.currentFrame == mCurrentButton.mButton.totalFrames)
			{
				mCurrentButton.mButton.gotoAndStop(1);
				mCurrentButton.mButton.removeEventListener(Event.ENTER_FRAME, onEnter);
				mCurrentButton = null;
				
			}
			
		}
		private function onUp(e:MouseEvent):void
		{
			if (mCurrentButton != this){	
				return
			}
			
			mCurrentButton.mButton.play();
			mCurrentButton.mButton.addEventListener(Event.ENTER_FRAME, onEnter);
//		/	mMyButton = null

			sendClick(mOnUpCallback);
		}
		
		private function onDown(e:MouseEvent):void
		{
			mCurrentButton = this;
			sendClick(mOnDownCallback);
		}
		override public function destruct():void{

			GlobalContext.stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);
			if (mCurrentButton != null){
				mCurrentButton.mButton.removeEventListener(Event.ENTER_FRAME, onEnter);

			}
			mButton.removeEventListener(MouseEvent.MOUSE_DOWN,onDown);
			super.destruct();
		}
	}
}