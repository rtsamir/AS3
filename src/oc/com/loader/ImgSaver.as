package oc.com.loader
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	public class ImgSaver
	{
		public function ImgSaver (pUrl:String,pCallback:Function,pIndex:int = 0, pSendData:BitmapData=null)
		{
			var imgBA:ByteArray = new ByteArray();
			var jpgEncoder:JPGEncoder;
			
			//jpgEncoder = new JPGEncoder(90);
			//imgBA = jpgEncoder.encode(pSendData);
			
			pSendData.encode(new Rectangle(0, 0, pSendData.width, pSendData.height), new JPEGEncoderOptions(80), imgBA);
			var aData:Number = new Date().getTime();
			var aURL:String = pUrl;
			//if(aURL.indexOf("?") > 0){
			///	aURL+= "&";
			//}else {
			//	aURL+= "?";
			//}
			//aURL +="time="+(new Date()).getTime();
			var sendReq:URLRequest = new URLRequest(aURL);
			sendReq.method = URLRequestMethod.POST;
			sendReq.requestHeaders = getHeaders();
			sendReq.data = imgBA;
			var sendLoader:URLLoader;
			sendLoader = new URLLoader(); 
			if(pCallback != null)
				sendLoader.addEventListener(Event.COMPLETE, pCallback);
			sendLoader.load(sendReq);

		}
		//___________________________________________________________________________
		
		protected function getHeaders():Array {
			var aHeaders:Array = new Array();
			aHeaders.push( new URLRequestHeader("Content-type","application/octet-stream"));
			return (aHeaders);
		}
		
		public static function resizeBitmap(pSize:int,pSendData:BitmapData):BitmapData {
			var aScale:Number = 0.32;
			if(pSendData.width > pSendData.height){
				aScale = pSize / pSendData.width;
			}else {
				aScale = pSize / pSendData.height;
			}
			var matrix:Matrix = new Matrix();
			matrix.scale(aScale, aScale);

			var smallBMD:BitmapData = new BitmapData(pSendData.width * aScale, pSendData.height * aScale);
			smallBMD.draw(pSendData, matrix, null, null, null, true);
			
			return(smallBMD);
		}
		//___________________________________________________________________________
		
		public static function bitmapSaveByteArray (ba:ByteArray):void
		{
			var fileReference:FileReference=new FileReference();
			fileReference.save(ba, ".jpg");
		}
		//___________________________________________________________________________
		
		public static function bitmapSave (bd:BitmapData):void
		{
			var ba:ByteArray = new ByteArray();
			bd.encode(new Rectangle(0, 0, bd.width, bd.height), new JPEGEncoderOptions(80), ba);
			bitmapSaveByteArray(ba);
		}
	}
}