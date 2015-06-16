package oc.com.interfaces
{
	public interface IDestructableSprite extends IDestructable
	{
		function get isDestructOnRemoveFromStage():Boolean;
		function set isDestructOnRemoveFromStage(val:Boolean):void;
	}
}