package oc.com.interfaces
{
	import flash.display.Sprite;
	

	public interface IRTGameWrapper extends IDestructableSprite
	{
		function init(pGameName:String = ""):void;
		function get display():Sprite
		function get wrapper():IRTGameWrapper;
	}
}