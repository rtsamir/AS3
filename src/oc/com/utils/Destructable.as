package oc.com.utils
{
	import flash.utils.clearTimeout;
	
	import oc.com.event.EventManager;
	import oc.com.interfaces.IDestructable;


	public class Destructable implements IDestructable
	{
		protected var  mTimeOuts:Vector.<uint>;
		
		public function Destructable()
		{
			super();
		}
		
		public function destruct():void
		{
			EventManager.manager.removeAllOwnerEvents(this);
			clearTimeOuts();		
		}
		
		protected function clearTimeOuts():void
		{
			if(mTimeOuts == null)
				return;
			for(var i:int = 0; i < mTimeOuts.length; i++){
				clearTimeout(mTimeOuts[i]);
			}
		}
	}
}