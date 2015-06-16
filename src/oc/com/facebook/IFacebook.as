package oc.com.facebook
{
	public interface IFacebook
	{
		function initSession():void;
        function initApp():void;
		function shareOnWall(pItemName:String = null):void
		function shareItemOnWall(pItemName:String):void;
		function shareLevel(pLevelNum:int,score:int):void
		function getFriends():void;
        function getInvitableFriends():void;
		function askForFans(pIdArray:Array):void;
		function sendInvation(pIdArray:Array):void;
	}
}