package oc.com.display
{
	import flash.events.MouseEvent;
	
	import oc.com.display.Layout.OcDisplayLayout;
	import oc.com.display.Layout.OcLayoutManager;
	import oc.com.interfaces.IDestructable;
	import oc.com.utils.GlobalContext;

	public class Alert implements IDestructable
	{
		private var mWindow:gc_alert;

		private static var mAlert:Alert;

		private var mButton:ButtonSimple;
		
		public function Alert(pBody:String, pTitle:String = "")
		{
			super();
			mWindow = new gc_alert();
			mWindow.mTitale.text = pTitle;
			mWindow.mBody.text = pBody;
			mWindow.x = GlobalContext.stage.stageWidth / 2;
			mWindow.y = GlobalContext.stage.stageHeight / 2;
			OcLayoutManager.manager.add(mWindow,OcDisplayLayout.CENTER,OcDisplayLayout.CENTER,0,0);
			mWindow.scaleX = mWindow.scaleY = 2.2;
			mButton = new ButtonSimple(mWindow.mOKButton,onClose);
			GlobalContext.stage.addChild(mWindow);
		}
		
		protected function onClose():void
		{
			destruct();
			
		}
		
		public function destruct():void
		{
			if(mWindow == null)
				return;
			mButton.destruct();
			if(mWindow.parent != null)
				mWindow.parent.removeChild(mWindow);
			
		}
		
		public static function show(pBody:String, pTitle:String = ""):void{
			if(mAlert != null){
				close();
			}
			 mAlert = new Alert(pBody,pTitle);
		}
		
		public static function close():void{
			mAlert.destruct();
		}
	}
}