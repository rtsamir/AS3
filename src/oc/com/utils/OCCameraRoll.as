package
{
	import flash.display.BitmapData;
	import flash.media.CameraRoll;
	
	public class OCCameraRoll
	{
		
		private var mCameraRoll:CameraRoll = new CameraRoll();
		
		public function OCCameraRoll()
		{
			super();
		}
		
		public static function get supportsAddBitmapData():Boolean {
			return (CameraRoll.supportsAddBitmapData);
		}
		
		public function addEventListener(pType:String,pFunction:Function):void{
			mCameraRoll.addEventListener(pType,pFunction);
		}
		
		public function addBitmapData(pBitmapData:BitmapData):void{
			mCameraRoll.addBitmapData(pBitmapData);
		}			
	}
}