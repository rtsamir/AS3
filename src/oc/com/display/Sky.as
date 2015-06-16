package oc.com.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import oc.com.loader.RTLoader;

	public class Sky extends LoopInteractionSprite
	{
		private var mIamge:RTLoader;
		
		public function Sky(pUrl:String)
		{
			super();
			mIamge = new RTLoader(pUrl,onLoad);
			addChild(mIamge);
		}
		
		private function onLoad(pImage:RTLoader):void
		{
			var aBitmap:Bitmap = new Bitmap(pImage.bitmapData)
			aBitmap.x = aBitmap.width;
			addChild(aBitmap);
			if(aBitmap.width >= 1280)
				return;
			aBitmap = new Bitmap(pImage.bitmapData)
			aBitmap.x = aBitmap.width * 2;
			addChild(aBitmap);
		}
		
		override public function act(pData:Object=null):Boolean
		{
			this.x-=0.5;
			if(this.x <= -mIamge.width)
				this.x = 0;
			return true;
		}
		
	}
}