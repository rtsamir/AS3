package oc.com.loader
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import oc.com.math.RTMath;
	
	
	public class ImageLoader extends LoaderSimple
	{

		private var mBoundRect:Rectangle;
		
		public function ImageLoader(pUrl:String,pBoundRect:Rectangle, callback:Function=null, index:int=0, attachedData:Object=null, onError:Function=null)
		{
			super(pUrl, callback, index, attachedData, onError);
			mBoundRect = pBoundRect;
		}
		
		override protected function completeHandler (event:Event):void {
			var aRect:Rectangle = RTMath.fitRectInBounds(this.width,this.height,mBoundRect.width,mBoundRect.height);
			this.width = aRect.width;
			this.height = aRect.height;
			this.x = mBoundRect.x + aRect.x; 
			this.y = mBoundRect.y + aRect.y; 
			super.completeHandler(event);
		}
	}
}