package 
{
	import flash.desktop.NativeApplication;
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.display.Loader;
	import flash.display.PNGEncoderOptions;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.ByteArray;
	
	import oc.com.loader.LoaderSimple;
	
	
	public class DiskUtils
	{
		
		private var mFile:File;
		private var mURL:String;

		private var myFileStream:FileStream;

		private var mBytes:ByteArray;
		private var camara:Camera;
		private var video:Video;
		
		public function DiskUtils()
		{
			super();
			
		}
		

		
		public static function loadJPG(pfileName:String,pAttachedData:Object,onLoad:Function):Loader
		{
			var aFile:File = new File();
			aFile = File.applicationStorageDirectory;
			aFile = aFile.resolvePath(pfileName);
			if(!aFile.exists){
				return null;
			}
			var fileStream:FileStream = new FileStream();
			fileStream.open(aFile, FileMode.READ);
			var aBytes:ByteArray = new ByteArray();
			fileStream.readBytes(aBytes,0,aFile.size);
			var aLoader:LoaderSimple = new LoaderSimple("",onLoad,0,pAttachedData);
			aLoader.loadBytes(aBytes);    
			return(aLoader);
		}		
		
		public static function pngSave (bd:BitmapData, fileName:String):void
		{
			
			
			var ba:ByteArray = new ByteArray();
			
			bd.encode(new Rectangle(0, 0, bd.width, bd.height), new PNGEncoderOptions(false), ba);
			
			var localFile:File = File.applicationStorageDirectory.resolvePath(fileName);
			var fileAccess:FileStream = new FileStream();
			fileAccess.open(localFile, FileMode.WRITE);
			fileAccess.writeBytes(ba, 0, ba.length);
			fileAccess.close();
		}
		
		public static function bitmapSave (bd:BitmapData, fileName:String):void
		{
			var ba:ByteArray = new ByteArray();
			bd.encode(new Rectangle(0, 0, bd.width, bd.height), new JPEGEncoderOptions(80), ba);
			var localFile:File = File.applicationStorageDirectory.resolvePath(fileName);
			var fileAccess:FileStream = new FileStream();
			fileAccess.open(localFile, FileMode.WRITE);
			fileAccess.writeBytes(ba, 0, ba.length);
			fileAccess.close();
		}
		
		private function onLoad(pData:Object):void
		{
			trace(pData);
			
		}
		
		public static function loadJson (fileName:String):String
		{
			var mFile:File = File.applicationStorageDirectory;
			mFile = mFile.resolvePath(fileName);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(mFile, FileMode.READ);
			var aBytes:ByteArray = new ByteArray();
			fileStream.readBytes(aBytes,0,mFile.size);
			
			trace("xml file load");
			
			
			//(mFile.size);
			fileStream.close();
			trace(aBytes);
			trace(aBytes[0]);
			trace(aBytes[1]);
			trace(aBytes[2]);
			trace(aBytes[3]);
			trace(aBytes[4]);
			trace(aBytes[5]);
			trace(aBytes[6]);
			var myString:String = aBytes.readUTF();
			trace(myString);
			trace(">>>" + myString);
			return myString;
			
		}
		
		
		public static function isEXIST(pfileName:String):Boolean
		{
			var aFile:File = new File();
			aFile = File.applicationStorageDirectory;
			aFile = aFile.resolvePath(pfileName);
			var aIsExidt:Boolean = aFile.exists;
			if(aFile.exists){
				return true
			}
			return false
		}
		
		public static function getDirectoryList (pPath:String):Array
		{
			var mFile:File = File.applicationStorageDirectory;
			mFile = mFile.resolvePath(pPath);
			if(!mFile.isDirectory){
				return[];
			}
			return(mFile.getDirectoryListing());	
		}
		
		public static function saveJson (pFileName:String, pData:String):void
		{
			var mFile:File = File.applicationStorageDirectory;
			mFile = mFile.resolvePath(pFileName);
			var mURL:String = mFile.nativePath;
			var writeStream:FileStream = new FileStream();
			writeStream.open(mFile, FileMode.WRITE);
			writeStream.writeUTF(pData);
			writeStream.close();
			
			trace('xml file saved');
		}
		
		public static function deleteDirectory(aDirectory:String):void
		{
			if(aDirectory == "./"){
				return
			}
			var mFile:File = File.applicationStorageDirectory;
			mFile = mFile.resolvePath(aDirectory);
			if(mFile.exists){
				mFile.deleteDirectory(true);
			}
		}
		
		public static function ExitApp():void {
			NativeApplication.nativeApplication.exit();
		}
	}
}