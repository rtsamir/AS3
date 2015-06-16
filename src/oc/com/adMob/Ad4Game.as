package oc.com.adMob
{
	import flash.display.Loader;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import oc.com.utils.GlobalContext;
	
	public class Ad4Game  extends Loader implements IadMob
	{
		public function Ad4Game()
		{
			var url:URLRequest = new URLRequest("http://cdn.ad4game.com/468x60.swf?zoneid=44759&subid=VivaDiamond"); 
			load(url); 
		}
		
		public function showAdTopLeft():void
		{
			this.visible = true;
			GlobalContext.stage.addChild(this);
		}
		
		public function refreshAd():void
		{
		}
		
		public function toggleAdVisibility():void
		{
			this.visible = !this.visible;
			if(this.visible){
				GlobalContext.stage.addChild(this);
			}
		}
		
		public function showAdds():void
		{
			this.visible = true;
			GlobalContext.stage.addChild(this);
		}
		
		public function hideAdds():void
		{
			this.visible = false;
		}
		
		public function get adsDimations():Rectangle
		{
			return new Rectangle(0,0,468,60);
		}
		
		
		public function preloadInterstitialAd():Boolean {
			return false;
		}
		
		public function showPendingInterstitial():Boolean{
			trace("showPendingInterstitial");
			return false;
		}
	}
}