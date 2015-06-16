package oc.com.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import oc.com.loader.RTLoader;

	
	public class ButtonSpriteSheet extends GameAssetsBase
	{
		protected var mImage:RTLoader;
		protected var mBitmap:Bitmap;
		protected var mWidth:Number;
		protected var mDisable:Boolean = false;
		protected var mStates:int = 4;
	
		
		public function ButtonSpriteSheet(pUrl:String,x:int = 0,y:int = 0,pStates:int = 4)
		{
			super();
			mStates = pStates;
			this.useHandCursor = true;
			this.buttonMode = true;
			mImage = new RTLoader(pUrl,onLoadImage);
			
			addEventListener(MouseEvent.ROLL_OVER,onOver);
			addEventListener(MouseEvent.ROLL_OUT,onOut);
			addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			addEventListener(MouseEvent.MOUSE_UP,onUp);

			this.x = x;
			this.y = y;
		}
		
		public function get disable():Boolean
		{
			return mDisable;
		}

		public function set disable(value:Boolean):void
		{
			mDisable = value;
			if(mImage.bitmapData == null)
				return;
			if(mBitmap == null)
				return;
			if(mDisable)
				mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(3 * mWidth,0, mWidth, mImage.bitmapData.height),new Point(0,0));
			else
				mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(0,0, mWidth, mImage.bitmapData.height),new Point(0,0));
		}

		private function onLoadImage():void
		{
			mWidth = mImage.bitmapData.width / mStates;
			mBitmap = new Bitmap(new BitmapData(mWidth, mImage.bitmapData.height,true,0xffffffff));
			mBitmap.smoothing = true;
			addChild(mBitmap);
			if(mDisable)
				mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(3 * mWidth,0, mWidth, mImage.bitmapData.height),new Point(0,0));
			else
				mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(0,0, mWidth, mImage.bitmapData.height),new Point(0,0));
			
		}
		
		protected function onDown(event:MouseEvent):void
		{
			if(mImage.bitmapData == null)
				return;
			if(mDisable)
				return;
			if(mBitmap == null)
				return;
			mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(2 * mWidth,0, mWidth, mImage.bitmapData.height),new Point(0,0));
		}
		
		protected function onOver(event:MouseEvent):void
		{
			if(mImage.bitmapData == null)
				return;
			if(mDisable)
				return;
			if(mBitmap == null)
				return;
			mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(mWidth,0, mWidth, mImage.bitmapData.height),new Point(0,0));

		}
		
		protected function onOut(event:MouseEvent):void
		{
			if(mDisable)
				return;
			if(mImage.bitmapData == null)
				return;
			if(mBitmap == null)
				return;
			mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(0,0, mWidth, mImage.bitmapData.height),new Point(0,0));

		}
		
		protected function onUp(event:MouseEvent):void
		{
			if(mImage.bitmapData == null)
				return;
			if(mDisable)
				return;
			if(mBitmap == null)
				return;
			mBitmap.bitmapData.copyPixels(mImage.bitmapData,new Rectangle(0,0, mWidth, mImage.bitmapData.height),new Point(0,0));
		}

		public function setScale(pScale:Number):void
		{
			scaleX = scaleY = pScale;
		}
		
		override public function destruct():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER,onOver);
			removeEventListener(MouseEvent.MOUSE_OUT,onUp);
			removeEventListener(MouseEvent.MOUSE_DOWN,onDown);
			mImage.destruct();
			super.destruct();
		}
		
	}
}