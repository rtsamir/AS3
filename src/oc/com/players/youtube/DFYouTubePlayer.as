package oc.com.players.youtube
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	import oc.com.interfaces.IDestructableSprite;

	/**
	 * ...
	 * @author oron mozes
	 */
	public class DFYouTubePlayer extends EventDispatcher implements IDestructableSprite
	{
		private var mLoaderYoutube:Loader;
		private var mLoaderContextYouTube:LoaderContext;
		private var mVideoPlayer:Object;
		public var urlPlayer:String = "http://www.youtube.com/apiplayer?version=3";
		public static const YOUTUBE_READY:String = "onReady";
		public static const ON_STATE_CHANGE:String = "onStateChange";
		static public const YOU_TUBE_PLAYER_ERROR:String = "youTubePlayerError";
		public function DFYouTubePlayer()
		{
			initSecurity();
		}
		public function insertIn(pContainer:DisplayObjectContainer):void {
			pContainer.addChild(mVideoPlayer as DisplayObject);
		}
		public function init():void
		{
			mLoaderYoutube = new Loader();
			mLoaderYoutube.contentLoaderInfo.addEventListener(Event.INIT, onYoutubePlayerLoaderInit);
			mLoaderYoutube.load(new URLRequest(urlPlayer), mLoaderContextYouTube);
		}
		private function onYoutubePlayerLoaderInit(e:Event):void
		{
			mVideoPlayer = mLoaderYoutube.content;
			mLoaderYoutube.contentLoaderInfo.removeEventListener(Event.INIT, onYoutubePlayerLoaderInit);
			mLoaderYoutube.content.addEventListener(YOUTUBE_READY, onPlayerReady);
			InteractiveObject(mVideoPlayer).addEventListener(YOU_TUBE_PLAYER_ERROR, onPlayerError);
			InteractiveObject(mVideoPlayer).addEventListener(ON_STATE_CHANGE, onStateChangeHandler);
		}
		private function onPlayerError(e:Event):void
		{
			  dispatchEvent(new Event(YOU_TUBE_PLAYER_ERROR));
		}

		private function onPlayerReady(e:Event):void
		{
			dispatchEvent(new Event(YOUTUBE_READY));
		}
		public function setSize(pWidth:Number, pHight:Number):void
		{
			mVideoPlayer.setSize(pWidth, pHight);
		}
		public function playByID(pVideoID:String, pStart:int = 1, pQuality:int = 320):void
		{
			stop();
			mVideoPlayer.loadVideoById(pVideoID, pStart, pQuality);
		}
		public function playByUrl(pUrl:String):void
		{
			//playByID(YouTubeService.instance.getIDFromUrl(pUrl));
		}
		/* INTERFACE com.dotfriends.interfaces.DFIDestructor */
		public function destruct():void
		{
			
			
			if (mLoaderYoutube) {
					mLoaderYoutube.contentLoaderInfo.removeEventListener(Event.INIT, onYoutubePlayerLoaderInit);
					if(mLoaderYoutube.content)
								mLoaderYoutube.content.removeEventListener(YOUTUBE_READY, onPlayerReady);
				mLoaderYoutube.unloadAndStop();
			}
			if (mVideoPlayer) {
				if (mVideoPlayer.parent) 
				{
					DisplayObjectContainer(mVideoPlayer.parent).removeChild(mVideoPlayer as DisplayObject);
				}
                InteractiveObject(mVideoPlayer).removeEventListener(YOU_TUBE_PLAYER_ERROR, onPlayerError);
                InteractiveObject(mVideoPlayer).removeEventListener(ON_STATE_CHANGE, onStateChangeHandler);
				  InteractiveObject(mVideoPlayer).removeEventListener(YOU_TUBE_PLAYER_ERROR, onPlayerError);
				if(mVideoPlayer.hasOwnProperty('destroy'))
					mVideoPlayer.destroy();
				
			}
			mVideoPlayer = null;
			mLoaderYoutube = null;
			
		}
        public function getCurrentTime():int{
           return  mVideoPlayer.getCurrentTime()

        }
		public function mute():void
		{
			mVideoPlayer.mute();
		}
		public function unMute():void
		{
			mVideoPlayer.unMute();
		}
		public function setVolume(pVolume:Number):void
		{
			mVideoPlayer.setVolume(pVolume);
		}
		public function stop():void
		{
			mVideoPlayer.stopVideo();
		}
		public function get isDestructOnRemoveFromStage():Boolean
		{
			return true;
		}
		public function set isDestructOnRemoveFromStage(value:Boolean):void
		{
			
		}
        private  function onStateChangeHandler(e:Event):void{
            //dispatchEvent(new DFEventBase(ON_STATE_CHANGE, this, Object(e).data));
        }
		private function initSecurity():void
		{
			Security.loadPolicyFile('http://www.youtube.com/crossdomain.xml');
			Security.allowDomain("http://s.ytimg.com");
			Security.allowDomain("http://www.youtube.com");
			Security.allowInsecureDomain("http://www.youtube.com");
			Security.allowInsecureDomain("*");
			Security.allowDomain("*");
		}
	}
}