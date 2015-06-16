package oc.com.display
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import oc.com.utils.GlobalContext;
	
	public class OcTogglelButton extends ButtonSimple
	{
		private var mLastState:int = 1;


		
		
		public function OcTogglelButton(pButton:MovieClip, pOnClickCallback:Function, pText:String=null, pAttachedData:Object=null)
		{
			super(pButton, pOnClickCallback, pText, pAttachedData);
			if(GlobalContext.appType == GlobalContext.MOBILE_TYPE){
				mButton.removeEventListener(MouseEvent.CLICK,cleckEvent);
				mButton.addEventListener(MouseEvent.CLICK,cleckEvent);
			}
		}
		
		override public function onClick():void
		{
			if(chackMouseMovement()){
				return;
			}
            if(mFakeEnable) {

                if (mLastState == DOWN_STATE) {
                    mButton.gotoAndStop(UP_STATE);
                    mLastState = UP_STATE;
                }
                else {
                    mButton.gotoAndStop(DOWN_STATE);
                    mLastState = DOWN_STATE;
                }
            }
			super.onClick();
		}
		
		override protected function onDown(event:MouseEvent):void
		{

			setDounPoint();
		}
		
		
		override protected function onOver(event:MouseEvent):void
		{	
			//mButton.gotoAndStop(2);
		}
		
		override protected function onOut(event:MouseEvent = null):void
		{
			//mButton.gotoAndStop(2);
		}
		
		 public  function setState(pState:int):void
		 {
             if(!mFakeEnable){
                 return;
             }
			 mButton.gotoAndStop(pState);
		 }
		 
		 public function get state():int{
			 
			 return (mLastState);
		 }
		 public function set state(value:int):void{
             if(!mFakeEnable){
                 return;
             }
			 mButton.gotoAndStop(value)
			 mLastState = value;
		 }


    }
}