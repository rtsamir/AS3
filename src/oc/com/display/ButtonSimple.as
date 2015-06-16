package oc.com.display
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.setTimeout;
	
	import oc.com.OCSoundManager;
	import oc.com.interfaces.IDestructable;
	import oc.com.utils.GlobalContext;

	public class ButtonSimple implements IDestructable
	{

		protected var mOnClickCallback:Function
		protected var mButton:MovieClip;
		protected var mAttachedData:Object
		protected var mEnable:Boolean = true;
		public static var clickSound:Sound;
		
		public static const DOWN_STATE:int = 2;
		public static const UP_STATE:int = 1;
		public static const OVER_STATE:int = 3;
		
		protected var mClickSound:Sound
		protected var mDounPoint:Point = new Point();
		protected var mIsinDragList:Boolean = false;
        protected var mFakeEnable:Boolean = true;

        private var mIsPropagation:Boolean;

        private var mText:String;
		
		
		public function ButtonSimple(pButton:MovieClip,pOnClickCallback:Function,pText:String = null,pAttachedData:Object = null,isPropagation:Boolean = false)
		{
			super();
			mText = pText;
			mIsPropagation = isPropagation;
			mOnClickCallback = pOnClickCallback;
			mButton = pButton;
			mAttachedData = pAttachedData;
			mButton.mouseChildren = false;
			mButton.mouseEnabled = true;
			mButton.useHandCursor = true;
			mButton.buttonMode = true;
			initListener();
			mButton.gotoAndStop(UP_STATE);
			setText(mText);
		}
		
		public function setText(pText:String):void
		{
			if((pText != null)&&(mButton.mText != null))
				mButton.mText.text = pText;
		}
		//__________________________________________________
		
		public function setClickSound(pSound:Sound):ButtonSimple
		{
			mClickSound = pSound;
			return this;
		}
		//__________________________________________________
		
		public function get text():String
		{
			if(mButton.mText == null){
				return ("");
			}
			return(mButton.mText.text);
		}
		//___________________________________________________
		
		protected function initListener():void
		{
			removeListene();
			mButton.addEventListener(MouseEvent.ROLL_OUT,onOut);
			mButton.addEventListener(MouseEvent.ROLL_OVER,onOver);
			mButton.addEventListener(MouseEvent.MOUSE_UP,onOut);
			mButton.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			if(GlobalContext.appType != GlobalContext.MOBILE_TYPE) {
				mButton.addEventListener(MouseEvent.CLICK,cleckEvent);
			}
		}
		
		
		protected function cleckEvent(event:MouseEvent = null):void {
			if(mClickSound != null) {
				clickWithSound(mClickSound)
				return;
			} 
			if(clickSound != null) {
				clickWithSound(clickSound)
				return;
			}
			onClick();
			if((!mIsPropagation)&&(event != null)){
				event.stopPropagation();
			}
		}
		
		protected function clickWithSound(pSound:Sound):void {
			OCSoundManager.play(pSound,0);
			setTimeout(onClick,200);
		}
		
		public function onClick():void
		{
			if(chackMouseMovement()){
				return;
			}
			switch(mOnClickCallback.length)
			{
				case 0:
					mOnClickCallback();
					break;
				case 1:
					mOnClickCallback(this);
					break;
				case 2:
					mOnClickCallback(this,mAttachedData);
					break;
			}	
			setText(mText);
		}
		//_____________________________________________________________
		
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
		
		protected function onDown(event:MouseEvent):void
		{
			setDounPoint();
            if(!mFakeEnable){
                return;
            }
			mButton.gotoAndStop(DOWN_STATE);
			setText(mText);
			if(GlobalContext.appType == GlobalContext.MOBILE_TYPE) {
				cleckEvent();
				setTimeout(onOut,200);
			}
			if(!mIsPropagation){
				event.stopPropagation();
			}
			
		}
		
		protected function setDounPoint():void
		{
			mDounPoint.x = GlobalContext.stage.mouseX;
			mDounPoint.y = GlobalContext.stage.mouseY;
			
		}		
		
		protected function onOver(event:MouseEvent):void
		{
            if(!mFakeEnable){
                return;
            }
			mButton.gotoAndStop(OVER_STATE);
			setText(mText);
		}
		
		protected function onOut(event:MouseEvent = null):void
		{
            if(!mFakeEnable){
                return;
            }
			mButton.gotoAndStop(UP_STATE);
			setText(mText);
		}
		
		public function destruct():void
		{
			removeListene();

		}
		
		public function removeDisplay():void {
			if(mButton.parent != null){
				mButton.parent.removeChild(mButton);
			}
		}
		
		public function removeListene():void
		{
			mButton.removeEventListener(MouseEvent.CLICK,onClick);
			mButton.removeEventListener(MouseEvent.ROLL_OVER,onOver);
			mButton.removeEventListener(MouseEvent.ROLL_OUT,onOut);
			mButton.removeEventListener(MouseEvent.MOUSE_UP,onOut);
			mButton.removeEventListener(MouseEvent.MOUSE_DOWN,onOver);
		}

		public function get attachedData():Object
		{
			return mAttachedData;
		}

		public function set attachedData(value:Object):void
		{
			mAttachedData = value;
		}

		public function get display():MovieClip
		{
			return mButton;
		}

		public function get enable():Boolean
		{
			return mEnable;
		}

		public function set enable(value:Boolean):void
		{
			mEnable = value;
			mButton.mouseEnabled = mEnable;
			mButton.useHandCursor = mEnable;
			mButton.buttonMode = mEnable;
			if(mEnable){
				initListener();
				//mButton.alpha = 1;
			}else{
				removeListene();
				//mButton.alpha = 0.3;
			}
		}

		public function get isInDragList():Boolean
		{
			return mIsinDragList;
		}

		public function set isInDragList(value:Boolean):void
		{
			mIsinDragList = value;
		}

        public function get fakeEnable():Boolean {
            return mFakeEnable;
        }

        public function set fakeEnable(value:Boolean):void {
            mFakeEnable = value;
        }
	}
}