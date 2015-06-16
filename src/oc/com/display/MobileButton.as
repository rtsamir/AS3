package oc.com.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	
	import oc.com.utils.Destructable;
	import oc.com.utils.GlobalContext;

	public class MobileButton extends Destructable
	{
		protected var mOnClickCallback:Function
		public var mButton:MovieClip;
		protected var mAttachedData:Object
		protected var mEnable:Boolean = true;
		
		protected var mClickSound:Sound
		protected var mDounPoint:Point = new Point();
		protected var mIsinDragList:Boolean = false;
		protected var mFakeEnable:Boolean = true;
		private var mIsPropagation:Boolean;
		
		
		public function MobileButton(pButton:MovieClip,pOnClickCallback:Function,pAttachedData:Object = null,isPropagation:Boolean = false)
		{
			
			super();			
			mIsPropagation = isPropagation;
			mOnClickCallback = pOnClickCallback;
			mButton = pButton;
			mAttachedData = pAttachedData;
			pButton.stop();
			mButton.mouseChildren = false;
			mButton.mouseEnabled = true;
			mButton.useHandCursor = true;
			mButton.buttonMode = true;
			mButton.addEventListener(MouseEvent.CLICK,onClick);
		//	mButton.addEventListener(MouseEvent.CLICK,onClick);
		
		}
		private function onEnter(e:Event):void
		{
			if (mButton.currentFrame == mButton.totalFrames)
			{
				mButton.stop();
				mButton.removeEventListener(Event.ENTER_FRAME, onEnter);

			}
		
		}
		public function onClick(e:MouseEvent):void
		{
			if(mOnClickCallback == null){
				return;
			}
			trace(mButton);
			mButton.gotoAndPlay(1);
			mButton.addEventListener(Event.ENTER_FRAME, onEnter);
			sendClick(mOnClickCallback);
		}
		
		public function sendClick(pOnClickCallback:Function):void
		{
			if(chackMouseMovement()){
				return;
			}
			switch(pOnClickCallback.length)
			{
				case 0:
					pOnClickCallback();
					break;
				case 1:
					pOnClickCallback(mAttachedData);
					break;
				case 2:
					pOnClickCallback(mAttachedData,this);
					break;
			}	
		}
		
		protected function chackMouseMovement():Boolean
		{
			return false;
			if(!mIsinDragList) {
				return false;
			}
			var aCurrentPoint:Point = new Point(GlobalContext.stage.mouseX, GlobalContext.stage.mouseY);
			var aD:Number = Point.distance(aCurrentPoint,mDounPoint)
			if(aD > 50) {
				return true;
			}
			return false;
		}

		public function get enable():Boolean
		{
			return mEnable;
		}

		public function set enable(value:Boolean):void
		{
			mEnable = value;
			mButton.mouseEnabled = mEnable;
			mButton.enabled = mEnable;
			mButton.ChildrenEnabled = mEnable;
			
		}
		override public function destruct():void{
			mButton.removeEventListener(MouseEvent.CLICK,onClick);
			mButton.removeEventListener(Event.ENTER_FRAME, onEnter);

			super.destruct();
		}
		
	}
}