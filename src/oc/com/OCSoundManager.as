package oc.com
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class OCSoundManager
	{
		static public var soundOn:Boolean = true;
		static private var mMusicOn:Boolean = true;
		static private var mIsOnPageMusic:Boolean = false;
		static public var music:Sound;
		static private var  mMusicChannel:SoundChannel;
		static private var  mSoundTransform:SoundTransform;
		
		public function OCSoundManager()
		{
			
		}
		
		public static function get musicTransform():SoundTransform
		{
			if(mSoundTransform == null){
				mSoundTransform = new SoundTransform(0.3);
			}
			return mSoundTransform;
		}

		public static function get isOnPageMusic():Boolean
		{
			return mIsOnPageMusic;
		}

		public static function set isOnPageMusic(value:Boolean):void
		{
			mIsOnPageMusic = value;
			updateMusic();
		}

		public static function get musicOn():Boolean
		{
			return mMusicOn;
		}

		public static function set musicOn(value:Boolean):void
		{
			mMusicOn = value;
			updateMusic();
		}

		static public function play(pSound:Sound,pStart:int = 0):SoundChannel{
			if(!soundOn){
				return null;
			}
			return (pSound.play(pStart,0));
		}
		
		
		static public function updateMusic(pFromReactive:Boolean = false):void{
			if(music == null){
				return;
			}
			if((mMusicOn)&&(mIsOnPageMusic)){
                if(pFromReactive){
                    mMusicChannel.stop();
                    mMusicChannel = null;
                }
				if(mMusicChannel == null){
					mMusicChannel = music.play(0,10800);
					mMusicChannel.soundTransform = musicTransform;
				}
			}
			else if (mMusicChannel != null) {
				mMusicChannel.stop();
				mMusicChannel = null;
			}	
		}
	}
}