package oc.com.display.Layout
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	import oc.com.event.EventManager;
	
	public class OcLayoutManager 
	{
		public static const BASE_DPI:int = 72;
		public static const BASE_ON_HEIGHT:int = 0;
		public static const BASE_ON_WIDTH:int = 1;
		
	
		public static var mBaseHeight:int = 768;
		public static var mBaseWidth:int = 800;
		public static var mBaseOnSide:int = BASE_ON_HEIGHT;
		
		public static const AFTER_RESIZE_EVENT:String = "AFTER_RESIZE_EVENT";
		
		
		private var mDPIRatiO:Number = -1;
		
		private static var mManager:OcLayoutManager;
		
		private var mStage:Stage;
		private var mWidth:int;
		private var mHeight:int;
		private var mScreenRatioFactor:Number;
		private var mDisplays:Vector.<OcDisplayLayout>;
		private var mGlobalScale:Number = 1;
		
		
	
		public function OcLayoutManager()
		{

		}
		//________________________________________________
		
		public static function get manager():OcLayoutManager
		{
			if(mManager == null)
				mManager = new OcLayoutManager();
			return mManager;
		}
		//________________________________________________
		
		public function initByRect(pW:int,pH:int):void
		{
			var aDPI:Number = Capabilities.screenDPI
			mDPIRatiO =  1 + (((Capabilities.screenDPI / BASE_DPI) - 1) / 10) * (aDPI / 240) * mGlobalScale;
			mDisplays = new Vector.<OcDisplayLayout>();
			if(mBaseOnSide == BASE_ON_HEIGHT){
				mDPIRatiO = pH / mBaseHeight * mGlobalScale;
			}
			else {
				mDPIRatiO = pW / mBaseWidth * mGlobalScale;
			}
			for(var i:int = 0; i < mDisplays.length; i++)
				mDisplays[i].setDisplay(mDPIRatiO,mWidth,mHeight);
			mWidth = pW;
			mHeight = pH;
			mScreenRatioFactor = 0.75 / (mHeight / mWidth) - 1;;
		}
		//_________________________________________________________________
				
		public function init(pStage:Stage):void
		{
			if(mStage != null){
				return;
			}
			mStage = pStage;
			var aDPI:Number = Capabilities.screenDPI
			trace("aDPI = " + aDPI );
			mDPIRatiO =  1 + (((Capabilities.screenDPI / BASE_DPI) - 1) / 10) * (aDPI / 240);
			mDisplays = new Vector.<OcDisplayLayout>();
			
			if(mBaseOnSide == BASE_ON_HEIGHT){
				mDPIRatiO = pStage.stageHeight / mBaseHeight * mGlobalScale;
			}
			else {
				mDPIRatiO = pStage.stageWidth / mBaseWidth * mGlobalScale;
			}
			
			
			
			mStage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		//_________________________________________________________________
		
		public function remove(pDisplay:DisplayObject):void
		{
			for(var i:int = 0; i < mDisplays.length; i++){
				if(mDisplays[i].display == pDisplay){
					mDisplays[i].display = null;
					mDisplays.splice(i,1);
				}
			}
		}
		//___________________________________________________________________
		
		public function add(pDisplay:DisplayObject,pHorizontal:String,pVertical:String,pLocX:Number = -10000,pLocY:Number = -10000):OcDisplayLayout
		{
			if(mDPIRatiO == -1){
				return null;
			}
			var aLayout:OcDisplayLayout = new OcDisplayLayout();
			aLayout.display = pDisplay;
			aLayout.typeX = pHorizontal;
			aLayout.typeY = pVertical;
			aLayout.locX = (pLocX != -10000)?pLocX:pDisplay.x;
			aLayout.locY = (pLocY != -10000)?pLocY:pDisplay.y;
			mDisplays.push(aLayout);
			aLayout.setDisplay(mDPIRatiO,mWidth,mHeight);
			return(aLayout);
		}
		//________________________________________________
		
		public function get dpiRetue():Number
		{
			return mDPIRatiO;
		}
		//________________________________________________
		
		public function updateDisplay(pDisplay:OcDisplayLayout):void
		{
			pDisplay.setDisplay(mDPIRatiO,mWidth,mHeight);
		}
		//________________________________________________
		
		public function onResize(event:Event = null):void
		{
			mWidth = mStage.stageWidth;
			mHeight = mStage.stageHeight;
			trace("mWidth = " + mWidth + " mHeight = " + mHeight);
			mScreenRatioFactor = 0.75 / (mHeight / mWidth) - 1;
			
			if(mBaseOnSide == BASE_ON_HEIGHT){
				mDPIRatiO = mStage.stageHeight / mBaseHeight * mGlobalScale;
			}
			else {
				mDPIRatiO = mStage.stageWidth / mBaseWidth * mGlobalScale;
			}
			
			
			
			for(var i:int = 0; i < mDisplays.length; i++)
				mDisplays[i].setDisplay(mDPIRatiO,mWidth,mHeight);
			
			EventManager.manager.dispatchEvent(AFTER_RESIZE_EVENT,this);
			
		}
		//________________________________________________
		
		public function get screenRatioWidth():Number
		{
			return(mWidth * mDPIRatiO);
		}			
		//________________________________________________
		
		public function get screenRatioHeight():Number
		{
			return(mHeight * mDPIRatiO);
		}
		//________________________________________________
		
		public function get screenWidth():Number
		{
			return(mWidth);
		}			
		//________________________________________________
		
		public function get screenHeight():Number
		{
			return(mHeight);
		}
		//________________________________________________
		
		public function get screenRatioFactor():Number
		{
			return mScreenRatioFactor;
		}

		public function get globalScale():Number
		{
			return mGlobalScale;
		}

		public function set globalScale(value:Number):void
		{
			mGlobalScale = value;
		}

	}
}

