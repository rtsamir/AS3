package oc.com.display.basicUI
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	import oc.com.display.ButtonSimple;
	import oc.com.display.Layout.OcDisplayLayout;
	import oc.com.display.Layout.OcLayoutManager;
	import oc.com.utils.GlobalContext;
	
	
	
	public class CommonDialog extends ComponentBase
	{
		public static const BUTTON_OK:String = "BUTTON_OK";
		public static const BUTTON_CANCEL:String = "BUTTON_Cancel";
		public static const SHOW_ICON:String = "SHOW_ICON";
		
		public var mOKButton:ButtonSimple; 
		public var mCancelButton:ButtonSimple; 
		public var mCancel_X:int; 
		public var mOK_X:int;
		protected var mIsOpen:Boolean = false;
		
		private static var mCurrentShowProductId:Number;
		private static var mCloseLastId:Number;
		
		public function CommonDialog(pGUI:MovieClip)
		{
			super(pGUI,null);
			OcLayoutManager.manager.add(this,OcDisplayLayout.CENTER,OcDisplayLayout.CENTER,0,0);
			pGUI.visible = false;
		//	var mySound:Sound = new sc_clali();
			if(mGUI.mCancelButton != null){
				mOKButton = new ButtonSimple(mGUI.mCancelButton,closePanel);
				//mOKButton.setClickSound(mySound);
			}
			if(mGUI.mOKButton != null){
				mCancelButton = new ButtonSimple(mGUI.mOKButton,onOK);
			}
			if(mOKButton != null){
				mButtons.push(mOKButton);
			}
			if(mCancelButton != null){
				mButtons.push(mCancelButton);
			}
			if(mGUI.mCancelButton != null){
			mCancel_X = mGUI.mCancelButton.x;
			}
			if(mGUI.mOKButton != null){
				mOK_X = mGUI.mOKButton.x;
			}
		}
		
		//public function show(pBody:String = "", pTitel:String = "", pButtonOK:String = "", pButtonCancel:String = "", pAttachedData:Object=null,pReturnCallback:Function = null):void
		//{
			
		//}
		
		public function get isOpen():Boolean
		{
			return mIsOpen;
		}

		public function show(pIdCurrent: Number=-1,pBody:String = "", pTitel:String = "", pButtonOK:String = "", pButtonCancel:String = "", pAttachedData:Object=null,pReturnCallback:Function = null):void
		{
			
			mCurrentShowProductId = pIdCurrent;
			mIsOpen = true;
			//if(mGUI.visible){
			//	return;
			//}			
			if(mGUI.mIcon != null){
				mGUI.mIcon.visible = (pAttachedData == SHOW_ICON);
			}
			mGUI.visible = true;
			GlobalContext.stage.addChild(this);
			mAttachedData = pAttachedData;
			mReturnCallback = pReturnCallback;
			this.scaleX = this.scaleY = OcLayoutManager.manager.dpiRetue;
			mGUI.scaleX = mGUI.scaleY = baseScale;
			setBasicPosition();
			
			enterTransition();
			
			if(mGUI.mBody != null){
				mGUI.mBody.text = pBody;
			}
			if(mGUI.mTitel != null){
				mGUI.mTitel.text = pTitel;
			}

			if(mOKButton != null) {
				mOKButton.setText(pButtonOK);
				mGUI.mCancelButton.visible = (pButtonOK != "");
			}
			if((mOKButton != null)&&(mCancelButton != null)) {
				mCancelButton.setText(pButtonCancel);
				mGUI.mOKButton.visible = (pButtonCancel != "");
			}
				
			if(pButtonCancel == "") {
					if(mOKButton != null){
					mOKButton.display.x = 0;
					}
			}
			else if(mGUI.mOKButton != null) {
				mGUI.mCancelButton.x = mCancel_X;
				mGUI.mOKButton.x = mOK_X;
			}
		}
		//_________________________________________________________________
		
		protected function setBasicPosition():void
		{
			mGUI.y = - 1000;
		}		
		//_________________________________________________________________
		
		protected function onOK(pButton:ButtonSimple = null):void
		{
			mIsOpen = false;
			if(mReturnCallback != null)
				mReturnCallback(BUTTON_OK,mAttachedData);
			exitTransition();
			setTimeout(remove,500);
		}
		
		public function closePanel(pCurrentId:Number=-1, pButton:ButtonSimple = null):void
		{
			mIsOpen = false;
			mCloseLastId = pCurrentId;
			if(mReturnCallback != null)
				mReturnCallback(BUTTON_CANCEL,mAttachedData);
			exitTransition();
			
			setTimeout(remove,1000);
		}
		
		protected function exitTransition():void
		{
			Tweener.removeAllTweens();

			Tweener.addTween(mGUI,{y:-1000,time:1.5,transition:"easeOutBack"});
			
		}
		
		protected function enterTransition():void
		{
			Tweener.removeAllTweens();
			Tweener.addTween(mGUI,{y:0,time:1.5,transition:"easeOutBack"});
			
		}
		
		public function remove():void
		{
			if (mGUI == null){
				return;
			}
			if (mCurrentShowProductId != mCloseLastId){
				return;
			}
			mGUI.visible = false;
			
			
		}		
		
		override public function destruct():void
		{
			mGUI = null;
			super.destruct();
		}
		
		protected function get baseScale():Number
		{
			return 0.5;
		}
	}
}