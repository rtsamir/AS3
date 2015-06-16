package oc.com.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	
	import oc.com.event.EventManager;
	import oc.com.interfaces.IDestructable;
	
	public class DestructSprite extends Sprite implements IDestructable
	{
		protected var  _timeOuts:Vector.<uint>;
		protected var  _Buttons:Vector.<ButtonSimple>;

		public function DestructSprite()
		{
			super();
		}
	
		
		private function onEnter(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		public function destruct():void
		{
			EventManager.manager.removeAllOwnerEvents(this);
			if((isDestructOnRemoveFromStage)&&(parent != null)){
				parent.removeChild(this);
			}
			clearTimeOuts();	
			if(_Buttons != null){
				for(var i:int =0; i < _Buttons.length;i++){
					_Buttons[i].destruct();
				}
			}
		}
		
		protected function clearTimeOuts():void
		{
			if(_timeOuts == null)
				return;
			for(var i:int = 0; i < _timeOuts.length; i++){
				clearTimeout(_timeOuts[i]);
			}
		}
		
		public function get isDestructOnRemoveFromStage():Boolean
		{
			return true;
		}
		
		public function set isDestructOnRemoveFromStage(val:Boolean):void
		{
		}
		
		public function get buttons():Vector.<ButtonSimple>{
			if(_Buttons == null){
				_Buttons = new Vector.<ButtonSimple>();
			}
			return (_Buttons);
		}
		
		public function get timeOutList():Vector.<uint>{
			if(_timeOuts == null){
				_timeOuts = new Vector.<uint>();
			}
			return (_timeOuts);
		}
	}
}