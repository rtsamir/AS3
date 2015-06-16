package oc.com.cu
{
	import flash.display.MovieClip;
	
	import caurina.transitions.Tweener;
	
	import oc.com.display.ButtonSimple;
	import oc.com.display.DisplayUtils;
	import oc.com.display.basicUI.ComponentBase;

	public class VerticalList extends ComponentBase
	{
		protected const PLAYERS_DISTANCE:int = 110;
		
		protected const MASK_HEIGHT:int = 700;
		
		protected var mGUIWidth:int = 0;
		protected var mArrowRight:MovieClip;
		protected var mArrowLeft:MovieClip;
		protected var mIsOnTween:Boolean = false;
		protected var mIsSelectable:Boolean;
		protected var mMaskWidth:int; 
		protected var mVisibleItems:int;
		
		public function VerticalList(pWidth:int, pIsSelectable:Boolean = true) {
			super(new MovieClip());
			mIsSelectable = pIsSelectable;
			mVisibleItems = Math.floor((pWidth - 50) / PLAYERS_DISTANCE);
			mMaskWidth = PLAYERS_DISTANCE * mVisibleItems;
			x = (pWidth - mMaskWidth)/2;
		}
		//_______________________________________________________________________
		
		protected function init():void{
			this.addChild(DisplayUtils.createMask(mGUI, mMaskWidth, MASK_HEIGHT));
			addChild(mGUI);
			//mArrowRight = new gc_arrowRight();
			mArrowRight.x = mMaskWidth  + 10;
			mArrowRight.y = 40;
			addChild(mArrowRight);
			//mArrowLeft = new gc_arrowLeft();
			mArrowLeft.x = -25
			mArrowLeft.y = 40;
			addChild(mArrowLeft);
			setArrow();
		}
		//_______________________________________________________________________
		
		private function setArrow():void
		{
			mIsOnTween = false;
			if(mArrowRight != null){
				mButtons.push(new ButtonSimple( mArrowRight, showNext));
				mArrowRight.visible = (mGUI.x > (-mGUIWidth + mMaskWidth))
			}
			if(mArrowLeft != null){
				mButtons.push(new ButtonSimple( mArrowLeft, showPrev));
				mArrowLeft.visible = (mGUI.x < 0);
			}
		}
		//________________________________________________________
		
		protected function onTweenerEnd():void {
			mIsOnTween = false;
		}

		//________________________________________________________
				
		private function showPrev():void {
			if(mIsOnTween){
				return;
			}
			if(mGUI.x < 0){
				mIsOnTween = true;
				Tweener.addTween(mGUI, {x:mGUI.x+mMaskWidth, time:1, transition:"easeInOutBack",onComplete:onTweenerEnd});
				mArrowLeft.visible = (mGUI.x +mMaskWidth  < 0);
				mArrowRight.visible = true;
			}
		}
		//________________________________________________________
				
		private function showNext():void {
			if(mIsOnTween){
				return;
			}
			if(mGUI.x > (-mGUIWidth + mMaskWidth)){
				mIsOnTween = true;
				Tweener.addTween(mGUI, {x:mGUI.x-mMaskWidth, time:1, transition:"easeInOutBack",onComplete:onTweenerEnd});
				mArrowLeft.visible = true;
				mArrowRight.visible = (mGUI.x > (-mGUIWidth + mMaskWidth * 2))
			}
			
			
		}
		//________________________________________________________
				
		public override function destruct():void
		{
			Tweener.removeTweens(mGUI);
		}
	}
}