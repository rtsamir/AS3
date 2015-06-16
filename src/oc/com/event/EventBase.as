package oc.com.event
{
	import flash.events.Event;
	
	public class EventBase extends Event
	{

		public static const APP_ACTION:String = "appAction";
		public static const APP_ERROR:String = "appError";
		public static const EXIT_APP:String = "ExitApp";
		
		protected var mAttachedData:Object;
		protected var mSender:Object;
		
		public function EventBase(type:String, pSender:Object = null, pAttachedData:Object = null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			mAttachedData = pAttachedData;
			mSender = pSender;
		}
		//____________________________________________________________
		
		public function get sender():Object
		{
			return mSender;
		}
		
		public function set sender(value:Object):void
		{
			mSender = value;
		}
		//____________________________________________________________
		
		public function get attachedData():Object
		{
			return mAttachedData;
		}

		public function set attachedData(value:Object):void
		{
			mAttachedData = value;
		}
		//____________________________________________________________
		
	}
}