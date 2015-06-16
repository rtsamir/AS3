package oc.com.utils
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import oc.com.display.Layout.OcLayoutManager;
	import oc.com.event.EventManager;

	public class ClickManager
	{
		
		public static const SAFE_CLICK_EVENT:String = "OC_SAFE_CLICK_EVENT";
		public static const SWIFT:String = "OC_SWIFT";
		public static const END_SWIFT:String = "OC_SWIFT";


		public static var aDragSenc:int = 30;
		private static var mDownLocation:Point;
		private static var mMoveLocation:Point;
		private static var mIsDown:Boolean = false;
		private static var instance:ClickManager;
		
		public function ClickManager()
		{
			if (instance != null){
				return
			}
			instance = this;
			GlobalContext.stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			GlobalContext.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			GlobalContext.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
		}
		
		protected function onMove(event:MouseEvent):void
		{
	
			if (!mIsDown){
				return;
			}
			var aCurrentPoint:Point = new Point(GlobalContext.stage.mouseX,GlobalContext.stage.mouseY);
	
			var aDelta:Point = aCurrentPoint.subtract(mMoveLocation);
			aDelta.x/=OcLayoutManager.manager.dpiRetue*200;
			aDelta.y/=OcLayoutManager.manager.dpiRetue*200;
			//aDelta/=100;
			EventManager.manager.dispatchEvent(SWIFT,this,aDelta);
			mMoveLocation = aCurrentPoint;
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			
			mMoveLocation = mDownLocation = new Point(GlobalContext.stage.mouseX,GlobalContext.stage.mouseY);
			mIsDown = true;
			
		}
		//__________________________________________________________
		public static function get isMouseDown():Boolean
		{
			return mIsDown;
		}
		
		//__________________________________________________________
		protected function onMouseUp(event:MouseEvent):void
		{
			mIsDown = false;
			if(mDownLocation == null){
				return;
			}
			var aUpPoint:Point = new Point(GlobalContext.stage.mouseX,GlobalContext.stage.mouseY);
			if(aUpPoint.subtract(mDownLocation).length < aDragSenc){
				EventManager.manager.dispatchEvent(SAFE_CLICK_EVENT,this);
			}	
		}
		
		public static function get isInDrag():Boolean {
			var aUpPoint:Point = new Point(GlobalContext.stage.mouseX,GlobalContext.stage.mouseY);
			return(aUpPoint.subtract(mDownLocation).length > aDragSenc);
		}
	}
}