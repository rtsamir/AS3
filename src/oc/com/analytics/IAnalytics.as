/**
 * Created by Alon on 10/14/2014.
 */
package oc.com.analytics {
public interface IAnalytics {
    function startLevel(pLevelNum:int):void;
    function ScreenView(pScreenName:String):void;
    function levelSuccess(pLevelNum:int, pWord:String):void;
    function levelFail(pLevelNum:int, pWord:String):void;
    function  connectToFacebook():void;
    function buyElement(pElementName:String , pLevelNum:int):void;
    function buyLetter(pWord:String , pLevelNum:int):void;
}
}
