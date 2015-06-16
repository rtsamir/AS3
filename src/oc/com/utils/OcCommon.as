package oc.com.utils
{
	import flash.external.ExternalInterface;
	
	public class OcCommon
	{
		public function OcCommon()
		{
		}
		

		public static function get userAgent():String
		{
			if(!ExternalInterface.available)
				return "[No ExternalInterface]";
			
			var aUserAgent:String = ExternalInterface.call("window.navigator.userAgent.toString");
			//ExternalInterface.call("alert('"+aUserAgent+"')");
			var aBrowser:String = "[Unknown Browser]";
			if (aUserAgent.indexOf("Safari") != -1)	{
				aBrowser = "Safari";
			}
			if (aUserAgent.indexOf("Firefox") != -1){
				aBrowser = "Firefox";
			}
			if (aUserAgent.indexOf("MSIE") != -1){
				aBrowser = "Internet Explorer";
			}
			if (aUserAgent.indexOf("Opera") != -1){
				aBrowser = "Opera";
			}
			if (aUserAgent.indexOf("Chrome") != -1){
				aBrowser = "Chrome";
			}
			return aBrowser;
		}
		
		public static function getFaceBookPictureURL(pUserID:String):String
		{
			if(pUserID == null){
				pUserID = "2";
			}
			return("https://graph.facebook.com/"+pUserID+"/picture?width=80&height=80");
		}
		//_______________________________________________________________________________________
		
		public  static function resdGETParameters(pTestURL:String = ""):Object {
			var aURLStr:String;
			if(!ExternalInterface.available) {
				if(pTestURL == "") {
					return new Object();
				}else {
					aURLStr = pTestURL;
				}
			}else{
				aURLStr = ExternalInterface.call('window.location.href.toString');
			}
			var aVars:String = aURLStr.substr(aURLStr.lastIndexOf("?")+1);
			aVars = replaceAll(aVars,'=','":"');
			aVars = replaceAll(aVars,"&",'","');
			aVars = '{"' + aVars + '"}';
			trace(aVars);
			var obj:Object = JSON.parse(aVars);
			return obj;
		}
		//_____________________________________________________________________________________
		
		public static function replaceAll(pText:String,pToReplace:String,pWith:String):String {
			while(pText.indexOf(pToReplace) > -1){
				pText = pText.replace(pToReplace,pWith);
			}
			return pText;
		}
	}
}
