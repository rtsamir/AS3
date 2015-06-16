package oc.com.cu
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	import oc.com.display.DisplayUtils;
	import oc.com.display.basicUI.ComponentBase;
	import oc.com.utils.GlobalContext;

	public class HorizontalList extends ComponentBase
	{
		protected var mGap:int = 70;
		protected var mVMaxiewRows:int = 3;
		protected var mMaskHieght:int = gap * mVMaxiewRows;
		protected var mMaskWidth:int = 900;
		
		protected var mGUIHigh:int = 0;
		protected var mIsOnTween:Boolean = false;
		protected var mIsSelectable:Boolean;
		protected var mMask:Shape;
		protected var mSliderLine:CUSlider;
		protected var mMoveToLocation:int  = 0;
		protected var mIsMouseDown:Boolean = false;
		protected var mLastMouseY:Number = 0;
		protected var mMouseYSpeed:Number = 0;
		protected var mHight:int = 0;
		protected var mListPanel:Sprite;
		
		public function HorizontalList(pIsSelectable:Boolean = true) {
			super(new MovieClip());
			mIsSelectable = pIsSelectable;
			mGUI.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			GlobalContext.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			addEventListener(Event.ENTER_FRAME,onSlidePanel);
		}
		
		public function isSlideNeeded():Boolean {
			return(mGUIHigh > mMaskHieght)
		}
		
		protected function setSliderByDrag():void
		{

			if(mSliderLine == null){
				return;
			}
			if(mGUIHigh < mMaskHieght){
				mSliderLine.visible = false;
				return;
			}
			mSliderLine.setSliderByRatio(mListPanel.y/(mGUIHigh - mMaskHieght));
			mMoveToLocation = mListPanel.y;
	//		trace("mMoveToLocation = " + mMoveToLocation);
		}
		//____________________________________________________
		
		protected function onSlidePanel(event:Event):void
		{
			if(mGUIHigh < mMaskHieght){
				if(mSliderLine != null){
					mSliderLine.visible = false;
				}
				return;
			}
			mSliderLine.visible = true;
			if(mIsMouseDown){
				onDrag();
			}
			if(mMouseYSpeed != 0){
				if(Math.abs(mMouseYSpeed) < 1){
					mMouseYSpeed = 0;
					setSliderByDrag();
					return;
				}
				mMouseYSpeed /= 1.5;
				mListPanel.y -= mMouseYSpeed;
				setSliderByDrag();
				return;
			}
			if(mIsMouseDown){
				setSliderByDrag();
				return;
			}
			var aDy:Number
			if(mListPanel.y > 0){
				aDy = mListPanel.y/3;
				if(aDy > 0.1){
					mListPanel.y-=aDy;
				}
				else{
					mListPanel.y = 0;
				}
				setSliderByDrag();
				return;
			}
			if(mListPanel.y < -(mGUIHigh - mMaskHieght ) ){
				aDy =  (-(mGUIHigh - mMaskHieght) - mListPanel.y)/3;
				if(aDy > 0.1){
					mListPanel.y+=aDy;
				}
				else{
					mListPanel.y = -(mGUIHigh - mMaskHieght);
				}
				setSliderByDrag();
				return;
			}
			var aDMovement:Number = (mMoveToLocation - mListPanel.y)/5;
			if(aDMovement == 0){
				return;
			}
			if(Math.abs(aDMovement) < 0.1){
				mListPanel.y = mMoveToLocation;
			}
			else{
				mListPanel.y += aDMovement;
			}
		}
		//_______________________________________________________________________
		
		private function onDrag():void
		{
			mMouseYSpeed = mLastMouseY- mouseY; 
			mLastMouseY = mouseY; 
	//		trace("onDrag");	
		}
		//_______________________________________________________________________
		
		protected function onMouseUp(event:MouseEvent):void
		{
			mIsMouseDown = false;
		}
		//_______________________________________________________________________
		
		protected function onMouseDown(event:MouseEvent):void
		{
			mIsMouseDown = true;
			mLastMouseY = mouseY;
			event.stopPropagation();
		}
		//_______________________________________________________________________
		
		public function get gap():int
		{
			return mGap;
		}

		public function set gap(value:int):void
		{
			mGap = value;
		}

		protected function init (pPanel:Sprite,pMaskWidth:Number, pMaskHieght:Number):void {
			
			mMaskWidth = pMaskWidth;
			mMaskHieght = pMaskHieght;
			mListPanel = pPanel;
			if(mMask != null){
				if(mMask.parent != null){
					mMask.parent.removeChild(mMask);
				}
			}
			//mMask = DisplayUtils.createRect(mMaskWidth, mMaskHieght); // DisplayUtils.createMask(mListPanel, mMaskWidth, mMaskHieght);
			mMask = DisplayUtils.createMask(mListPanel, mMaskWidth, mMaskHieght);
			//mListPanel.mask = null;
			this.addChild(mMask);
			
			mSliderLine = new CUSlider(onChange,mMaskHieght);
			addChild(mSliderLine);
			mSliderLine.x = mListPanel.x + mListPanel.width-CUSlider.TICKNESS / 2;
		}
		//_______________________________________________________________________
				
		private function onChange(pRatio:Number):void
		{
			if(mIsMouseDown)
				return;
			mMoveToLocation = -(mGUIHigh - mMaskHieght) * pRatio;
		}
		//________________________________________________________

		public function get currentHeight():Number
		{
			if(mGUIHigh > mMaskHieght){
				return mMaskHieght;
			}
			return mGUIHigh;
		}
		
		//________________________________________________________
				
		public override function destruct():void
		{
			Tweener.removeTweens(mGUI);
			removeEventListener(Event.ENTER_FRAME,onSlidePanel);
			super.destruct();
		}
		
	}
}