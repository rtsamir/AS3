/**
 * Created by Alon on 9/7/2014.
 */
package oc.com.adMob {

	import flash.geom.Rectangle;

public interface IadMob
{
    function showAdTopLeft():void;
    function refreshAd():void;
    function toggleAdVisibility():void;
    function showAdds():void;
    function hideAdds():void;
	function get adsDimations():Rectangle;
	function preloadInterstitialAd():Boolean;
	function showPendingInterstitial():Boolean;

}
}
