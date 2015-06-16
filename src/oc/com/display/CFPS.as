package oc.com.display
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class CFPS extends TextField
	{
		private var mTimer:Timer
		private var mLastTime:Number;
		private var mFrameCounte:uint = 0;
		
		public var additionalData: String = "";
		
		public function CFPS()
		{
			super();
			mTimer = new Timer(1000);
			mTimer.addEventListener(TimerEvent.TIMER,ShowFPS);
			mTimer.start();
			addEventListener(Event.ENTER_FRAME,FPSCounter);
			this.background = true;
			this.backgroundColor = 0xdddddd;
			this.height = 20;
			this.width = 150;
		}
		//____________________________________________
		
		public function FPSCounter(e:Event):void
		{
			mFrameCounte++;
		}	
		//____________________________________________
		
		public function ShowFPS(e:Event):void
		{
			var aFPS:Number = mFrameCounte / ((getTimer() - mLastTime) / 1000);
			text =  "FPS: " + aFPS.toFixed(2) + " On " + additionalData;
			mFrameCounte = 0;
			mLastTime = getTimer();
			if(this.parent != null){
				this.parent.addChild(this);
			}
		}
	}
}