package oc.com.cu
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	import oc.com.display.ButtonSimple;
	
	public class CUTabButton extends ButtonSimple
	{
		protected var mButtonsGroup:Vector.<CUTabButton>; 
		protected var mIsSelected:Boolean = false;
		
		public function CUTabButton(pButton:MovieClip, pOnClickCallback:Function,pGroup:Vector.<CUTabButton>, pText:Object = null, pAttachedData:Object=null)	{
			super(pButton, pOnClickCallback, pText, pAttachedData);
			addToTabsGroup(pGroup);
		}
		//________________________________________________________
		
		protected function addToTabsGroup(pButtonsGrop:Vector.<CUTabButton>):void {
			if(pButtonsGrop == null){
				return;
			}
			mButtonsGroup = pButtonsGrop;
			if(mButtonsGroup.indexOf(this) > -1){
				return;
			}
			mButtonsGroup.push(this);
		}
		//________________________________________________________
		
		protected function removeFromGroup():void	{
			if(mButtonsGroup == null){
				return;
			}
			var aIndex:int = mButtonsGroup.indexOf(this);
			if(aIndex > -1){
				mButtonsGroup.splice(aIndex,1);
			}
			mButtonsGroup = null;
		}
		//________________________________________________________
				
		override public function onClick():void	{
			super.onClick();
			if(mButtonsGroup == null){
				return;
			}
			for(var i:int; i < mButtonsGroup.length; i++){
				mButtonsGroup[i].setToUnSelected();
			}
			setState(DOWN_STATE);
			mIsSelected = true;
			
		}
		
		private function setState(pState:int):void
		{
			mButton.gotoAndStop(pState);
			
		}
		//________________________________________________________
		
		override protected function onDown(event:MouseEvent):void {
			if(mIsSelected){
				return;
			}
			setState(OVER_STATE);
			
		}
		//________________________________________________________
		
		override protected function onOver(event:MouseEvent):void	{	
			if(mIsSelected){
				return;
			}
			setState(OVER_STATE);
		}
		//________________________________________________________
		
		public function setToUnSelected():void	{
			setState(UP_STATE);
			mIsSelected = false;
		}
		//________________________________________________________
		
		override protected function onOut(event:MouseEvent = null):void	{
			if(mIsSelected){
				return;
			}
			setState(UP_STATE);
		}
	}
}