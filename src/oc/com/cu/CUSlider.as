package oc.com.cu
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import oc.com.display.DestructSprite;
	import oc.com.utils.GlobalContext;
	import oc.com.utils.GlobalContext;
	
	public class CUSlider extends DestructSprite
	{
		public static const TICKNESS:int = 12;
		protected var mLength:int = 70;
		protected var mLastLocation:Number = 0;
		protected var mLine:Sprite;
		protected var mHight:int;
		protected var mIsInDrag:Boolean;



		private var mUpdateCallback:Function;
		
		public function CUSlider(pUpdateCallback:Function,pHight:int,pBackColor:int = 0xaaaaaa,pLineColor:int=0xaaaaaa)	{
			super();
			mUpdateCallback = pUpdateCallback;
			mHight = pHight;
			createGui(pHight,pBackColor,pLineColor);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			GlobalContext.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		override public function destruct():void {
			removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			GlobalContext.stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			mUpdateCallback = null;
			super.destruct();
		}
		
		//______________________________________________________________________
				
		protected function onEnterFrame(event:Event):void {
			if(mLastLocation == mLine.y){
				return;
			}
			mLastLocation = mLine.y;
			var aRatio:Number = (mLastLocation - mLength/2) / (mHight - mLength);
			mUpdateCallback(aRatio);
		}
		//______________________________________________________________________
		
		protected function onMouseUp(event:MouseEvent):void	{
			mIsInDrag = false;
			mLine.stopDrag();
		}
		//______________________________________________________________________
		
		protected function onMouseDown(event:MouseEvent):void	{
			mIsInDrag = true;
			mLine.startDrag(true,new Rectangle(0,mLength/2,0, mHight - mLength));
			event.stopPropagation();
		}
		//______________________________________________________________________
		
		protected function createGui(pHight:int,pBackColor:int,pLineColor:int):void	{
			//graphics.clear();
			//graphics.lineStyle(TICKNESS,pBackColor);
			//graphics.lineTo(0,pHight);
			mLine = new Sprite();
			mLine.graphics.lineStyle(TICKNESS,pLineColor);
			var aHalfLine:Number = mLength/2 - 7
			mLine.graphics.moveTo( 0, -aHalfLine );
			mLine.graphics.lineTo( 0, aHalfLine );
			mLine.y = mLength / 2;
			//mLine.addChild(DisplayUtils.createCenteredCircle(1500));
			addChild(mLine);
		}
		//______________________________________________________________________
		
		public function setSliderByRatio(pRatio:Number):void {
			mLine.y = -pRatio * (mHight - mLength) + mLength/2;
			if(mLine.y > mHight - mLength/2){
				mLine.y = mHight - mLength/2
			}
			if(mLine.y < mLength/2) {
				mLine.y = mLength/2;
			}
		}
		//____________________________________________________________
				
		public function get length():int {
			return mLength;
		}
		//____________________________________________________________
		
		public function set length(value:int):void {
			mLength = value;
		}
	}
}