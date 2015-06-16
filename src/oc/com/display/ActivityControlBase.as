package oc.com.display
{
	import flash.events.MouseEvent;
	
	import oc.com.loader.RTLoader;
	import oc.com.utils.GlobalContext;

	public class ActivityControlBase extends GameAssetsBase
	{
		
		
		public static const INFO:String = "info";
		public static const PRINT:String = "print";
		
		protected var mParentGame:GameWrapperBase;
		protected var mItems:Vector.<ButtonSpriteSheet>;
		protected var mTopLeft:int = 280;
		protected var mTopRight:int = 320;
		protected var mDistanceRight:int = 70;
		protected var mDistanceLeft:int = 50;
		protected var mLeftColumn:int = 25;
		protected var mRightColumn:int = 1180;
		
		public function ActivityControlBase(pParentGame:GameWrapperBase)
		{
			super();
			mItems = new Vector.<ButtonSpriteSheet>();
			mParentGame = pParentGame;
			initButtons();
			reArrengeButtons();

		}
		
		protected function initButtons():void
		{
			loadButton("bt_explaination.png",mLeftColumn,INFO, 3);
			loadButton("bt_print.png",mLeftColumn, PRINT,1);
		}
		//----------------------------------------------------------------------
		
		protected function onClick(event:MouseEvent):void
		{
			mParentGame.callControlCommand((event.currentTarget as GameAssetsBase).id)
		}
		
		//--------------------------------------------------------------------------
		
		public function setButtonDisable(pId:String):void
		{
			var aItems : ButtonSpriteSheet = getItemById(pId);
			if(aItems == null)
				return;
			aItems.disable = true;
		}
		//--------------------------------------------------------------------------
		
		public function isButtonEnabled(pId:String):Boolean
		{
			var aItems : ButtonSpriteSheet = getItemById(pId);
			if(aItems == null)
				return false;
			return(!aItems.disable);
		}
		//--------------------------------------------------------------------------
		
		public function setButtonEnabled(pId:String):void
		{
			var aItems : ButtonSpriteSheet = getItemById(pId);
			if(aItems == null)
				return;
			aItems.disable = false;
		}
		//--------------------------------------------------------------------------
				
		protected function getItemById(pId:String):ButtonSpriteSheet
		{
			for( var i:int = 0; i < mItems.length; i++)
			{
				if(mItems[i].id == pId)
					return(mItems[i])
			}
			return null;
		}
		//--------------------------------------------------------------------------
		
		protected function loadButton(buttonName:String,pX:int,pId:String,states:int = 4, pScale:Number = 1):GameAssetsBase
		{
			var aButton:GameAssetsBase = new GameAssetsBase();
			aButton.id = pId;
			var aButtonFrame:RTLoader = new RTLoader( GlobalContext.baseURL + "common/bt.png" );
			var aButtonImage:ButtonSpriteSheet = new ButtonSpriteSheet(GlobalContext.baseURL + "common/" + buttonName,0,0,states);
			aButton.addChild(aButtonFrame);
			aButton.addChild(aButtonImage);
			aButtonImage.setScale(pScale);
			aButtonImage.id = pId;
			aButtonImage.x -= 0;
			aButtonImage.y -= 5;
			aButton.x = pX;
			aButton.addEventListener(MouseEvent.CLICK, onClick);
			mItems.push(aButtonImage);
			addChild(aButton);
			
			return(aButton);
		}
		
		protected  function reArrengeButtons():void
		{
			var aTopLeft:int = mTopLeft;
			var aTopRight:int = mTopRight;
			for(var i:int = 0; i < mItems.length; i++)
			{
				if(mItems[i].parent.x < 300) 
				{
					mItems[i].parent.y = aTopLeft;
					aTopLeft += mDistanceLeft
				}
				else
				{
					mItems[i].parent.y = aTopRight;
					aTopRight += mDistanceRight;
				}
			}
		}
	}
}