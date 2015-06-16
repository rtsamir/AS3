package oc.com.sounds
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	
	import oc.com.event.EventManager;

	public class soundConnector
	{
		private var mSounds:Vector.<Sound>;
		public static const EVENT_FINISH_SOUND:String = "EVENT_FINISH_SOUND";
		private var mIndex:Number;
		public function soundConnector(pSounds:Vector.<Sound>)
		{
			mIndex = 0; 
			mSounds = pSounds;
			SoundMixer.stopAll();

			playSound();
			
				
		}
		private function playSound():void
		{
			if (mSounds.length == 0)
				return;
			if (mSounds.length == mIndex)
			{
				EventManager.manager.dispatchEvent(EVENT_FINISH_SOUND,this,mSounds[mIndex-1]);					
				return;
			}
				
			var soundChannel:SoundChannel = mSounds[mIndex].play();
			mIndex++;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);

		}
		
		protected function soundComplete(event:Event):void
		{
			playSound();
			
		}
		
	}
}