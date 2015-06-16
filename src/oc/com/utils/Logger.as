package oc.com.utils
{
	import flash.text.TextField;
	
	import oc.com.event.EventBase;
	import oc.com.event.EventManager;

	public class Logger
	{
        private static var mConsole:TextField;
        private static var mConsole2:TextField;
        private static var mConsole3:TextField;

		public function Logger()
		{
		}
		public static function setConsole(pText:TextField,pText2:TextField = null ,pText3:TextField = null):void
		{
			mConsole = pText;
            mConsole2 = pText2;
            mConsole3 = pText3;
		}
		//______________________________________________________________________
		
		public static function log(pText:String):void
		{
			//trace("log : " + pText);
			if(mConsole == null)
				return;
			mConsole.appendText(pText + "\n");
		}
        public static function log2(pText:String):void
        {
            //trace(pText);
            if(mConsole == null)
                return;
            mConsole2.appendText(pText + "\n");
			//trace("log2: " + pText);
        }
        public static function log3(pText:String):void
        {
            //trace(pText);
            if(mConsole == null)
                return;
            mConsole3.appendText(pText + "\n");
			//trace("log3: " + pText);
        }
		//__________________________________________________________________
		
		public static function errorLog(pText:String,pSender:Object,pFunctionName:String):void
		{
			log(pText);
			var aData:ErrorData = new ErrorData(pText,pSender,pFunctionName);
			EventManager.manager.dispatchEvent(EventBase.APP_ERROR,pSender,aData);
		}
		
		//______________________________________________________________________
		
		public static function Action(pText:String,pSender:Object,pExtraData:Object):void
		{
			log(pText);
			EventManager.manager.dispatchEvent(EventBase.APP_ACTION,pSender,pExtraData);
		}
		//______________________________________________________________________
        public static function get console():TextField {
            return mConsole;
        }
        public static function get console2():TextField {
            return mConsole2;
        }
        public static function get console3():TextField {
            return mConsole3;
        }

    }
}