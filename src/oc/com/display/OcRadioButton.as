package oc.com.display
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class OcRadioButton extends OcTogglelButton
	{
		protected var mButtonsGroup:Vector.<OcTogglelButton>; 
		protected var mIsSelected:Boolean = false;
		
		public function OcRadioButton(pButton:MovieClip, pOnClickCallback:Function,pGroup:Vector.<OcTogglelButton>, pText:String=null, pAttachedData:Object=null)	{
			super(pButton, pOnClickCallback, pText, pAttachedData);
			addToTabsGroup(pGroup);
		}
		//________________________________________________________
		
		protected function addToTabsGroup(pButtonsGrop:Vector.<OcTogglelButton>):void {
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
		//________________________________________________________
		
		override protected function onDown(event:MouseEvent):void {

			//event.stopPropagation();
		}
		//________________________________________________________
		
		override protected function onOver(event:MouseEvent):void	{	

		}
		//________________________________________________________
		
		public function setToUnSelected():void	{
			setState(UP_STATE);
			mIsSelected = false;
		}
		//________________________________________________________
		
		override protected function onOut(event:MouseEvent = null):void	{

		}
	}
}