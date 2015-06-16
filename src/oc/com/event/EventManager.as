package oc.com.event
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class EventManager
	{
		public var mEventDispatcher:EventDispatcher;
		public var mEventsDictionary:Dictionary;
		public static var mEventManager:EventManager;
		
		public function EventManager()
		{
			mEventDispatcher = new EventDispatcher();
			mEventsDictionary = new Dictionary();
		}
		//-----------------------------------------------------
		
		public static function get manager():EventManager
		{
			if(mEventManager == null)
				mEventManager = new EventManager();
			return(mEventManager);
		}
		//-----------------------------------------------------
				
		public function dispatchEvent(pType:String, pSender:Object = null, pData:Object = null,pBubbles:Boolean = false,pCancelable:Boolean = false):void
		{
			var event:EventBase = new EventBase(pType, pSender, pData, pBubbles, pCancelable);
			mEventDispatcher.dispatchEvent(event);
		}
		//-----------------------------------------------------

		public function addEventListener(pType:String,pCallback:Function,pOwner:Object,pUseCapture:Boolean = false,pPriority:int =0 ,pUseWeekReference:Boolean = false):void
		{
			mEventDispatcher.addEventListener(pType,pCallback,pUseCapture,pPriority,pUseWeekReference);
			if(mEventsDictionary[pOwner] == null)
				mEventsDictionary[pOwner] = new Vector.<EventHandlerData>();
			if(getEventIndex(mEventsDictionary[pOwner], pType, pCallback) >= 0)
				return;
					
			mEventsDictionary[pOwner].push(new EventHandlerData(pType,pCallback));			
		}
		//-----------------------------------------------------

		public function removeEventListener(pType:String,pCallback:Function,pOwner:Object,pUseCapture:Boolean = false):void
		{
			mEventDispatcher.removeEventListener(pType,pCallback,pUseCapture);
			removeEventFromOwner(pOwner,pType,pCallback);
		}
		//-----------------------------------------------------

		private function removeEventFromOwner(pOwner:Object,pType:String,pCallback:Function):void
		{
			if(mEventsDictionary[pOwner] == null)
				return;
			var i:int = getEventIndex(mEventsDictionary[pOwner], pType, pCallback);
			if(i < 0)
				return;
			(mEventsDictionary[pOwner] as Vector.<EventHandlerData>).splice(i,1);
		}
		//-----------------------------------------------------

		private function getEventIndex(pEventHandlerDatas:Vector.<EventHandlerData>,pType:String,pCallback:Function):int
		{
			if(pEventHandlerDatas == null)
				return -1
			for(var i:int = 0; i < pEventHandlerDatas.length; i++)
			{
				if((pEventHandlerDatas[i].mCallback == pCallback)&&(pEventHandlerDatas[i].mType == pType))
					return(i);
			}
			return -1;
		}
        //-----------------------------------------------------

        public function removeAllEvents():void
        {
            for ( var key:Object in mEventsDictionary){
                removeAllOwnerEvents(key);
            }
            mEventsDictionary = new Dictionary();

        }
		//-----------------------------------------------------

		public function removeAllOwnerEvents(pOwner:Object):void
		{
			if(mEventsDictionary[pOwner] == null)
				return;
			var lEventHandlerDatas:Vector.<EventHandlerData> = mEventsDictionary[pOwner] as Vector.<EventHandlerData>;
			if(lEventHandlerDatas == null)
				return;
			for(var i:int = 0; i < lEventHandlerDatas.length; i++)
			{
				mEventDispatcher.removeEventListener(lEventHandlerDatas[i].mType,lEventHandlerDatas[i].mCallback);
			}
			mEventsDictionary[pOwner] = null;
		}
	}
}



class EventHandlerData
{
	public var mType:String;
	public var mCallback:Function;
	public function EventHandlerData(pType:String,pCallback:Function)
	{
		mType = pType;
		mCallback = pCallback;
	}
}
