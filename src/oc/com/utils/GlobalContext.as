package oc.com.utils
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	
	import oc.com.adMob.IadMob;
	import oc.com.analytics.IAnalytics;
	import oc.com.facebook.IFacebook;
	import oc.com.interfaces.IBilling;

	public class GlobalContext
	{
		static public const HEBREW:String = "he";
		static public const HEBREW_FRAME:Number =1;
		static public const ENGLISH_FRAME:Number =2;
		static public var FRAME_LANG:Number;
		static public const ENGLISH:String = "en";
		static public const WEB_TYPE:String = "web";
		static public const WEB_TYPE_FACEBOOK:String = "facebook";
		static public const MOBILE_TYPE:String = "mobile";
		static public const MOBILE_TYPE_IOS:String = "mobile_IOS";
		static public const MOBILE_TYPE_ANDROID:String = "mobile_ANDROID";
        static public const BASE_URL_SERVER:String = "http://vivadiamond-api1.oc-diamond-2014.appspot.com/";
        static public const BASE_URL_LOCALHOST:String = "http://localhost:8080/";
		
		
        static public  var baseUserInUse:String = "";
        static public var INVAITE_FRIEND_STATUS:String = "Invite";
		static public var ASK_FAN_STATUS:String = "askForFans"; 
		static public var appType:String = WEB_TYPE;
		static public var language:String = ENGLISH;
		static public var appSubType:String = WEB_TYPE_FACEBOOK;
		static public var scaleFactor:Number = 1;
		static public var stage:Stage;
		static public var isDebug:Boolean = false;
		static public var baseURL:String = "";
		static public var setTextField : Function;
		static private var mBaseFilesURL:String = "";
		static public var root:DisplayObject;
		static public var config:Object;
		static public var loadedDomain:ApplicationDomain;
		static public var version:String = "1.00";
		static public var facebook:IFacebook;
        static public var googleAnalytics:IAnalytics;
        static private var mAdds:IadMob;
		static public var billing:IBilling;
		public static var userController:Class;
		public static var cacheId:uint =  Math.random() * 10000000;
        public static var IsConnected:Boolean =  true;
		static public var facebookStatus:int = 0;
		
		static public var levelsList:Vector.<Object>;
		public static const EntranceCounter:int = 0 ;
		
		//Shop
		public static const BASIC_USER:Number = 1;
		public static const MANAGER_USER:Number = 2;
		public static var UserPosition:Number;

		public function GlobalContext()
		{
			
		}

		public static function get baseFilesURL():String
		{
			return mBaseFilesURL;
		}

		public static function set baseFilesURL(value:String):void
		{
			mBaseFilesURL = value;
		}

		public static function get adds():IadMob
		{
			return mAdds;
		}

		public static function set adds(value:IadMob):void
		{
			mAdds = value;
		}


	}
}