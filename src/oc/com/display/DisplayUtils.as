package oc.com.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	
	import oc.com.utils.GlobalContext;

	public class DisplayUtils
	{
		public function DisplayUtils()
		{
		}
		
		static public function enabledButton(mc:Object):void
		{
			mc.enabled = true;
			mc.alpha = 1;
		}
		
		static public function disabledButton(mc:Object):void
		{
			mc.enabled = false;
			mc.alpha = 0;
		}
		
		static public function createMask(mc:DisplayObjectContainer,w:Number,h:Number):Shape
		{
			var aShape:Shape = createRect(w,h);
			mc.addChild(aShape);
			mc.mask = aShape;
			return (aShape);
		}
		
		
		static public function createRect(w:Number,h:Number,c:uint = 0):Shape
		{
			var aShape:Shape = new Shape();
			aShape.graphics.beginFill(c);
			aShape.graphics.drawRect(0,0,w,h);
			return (aShape);
		}
		
		static public function createCenteredRect(w:Number,h:Number,c:uint = 0):Shape
		{
			var afw:Number = -w/2;
			var afh:Number = -h/2;
			var aShape:Shape = new Shape();
			aShape.graphics.beginFill(c);
			aShape.graphics.drawRect(afw,afh,w,h);
			return (aShape);
		}
		
		
		static public function createCenteredCircle(r:int):Shape
		{
			var aShape:Shape = new Shape();
			aShape.graphics.beginFill(0);
			aShape.graphics.drawCircle(0,0,r);
			return (aShape);
		}
		
		public static function getClass(className:String):Class {
			
			try {
				return ApplicationDomain.currentDomain.getDefinition(className)  as  Class;
			} catch (e:Error) {
				return null;
			}
			return null;
		}
		
		public static function getMovieClip(className:String):MovieClip {
			return(getInstance(className) as MovieClip);
		}
		
		public static function getInstance(className:String):Object {
			var instanceClass:Class;
			if(ApplicationDomain.currentDomain.hasDefinition(className))
				instanceClass = ApplicationDomain.currentDomain.getDefinition(className)  as  Class;
			else if(GlobalContext.loadedDomain.hasDefinition(className))
				instanceClass = GlobalContext.loadedDomain.getDefinition(className)  as  Class;
			else
				return null;
			if(instanceClass != null)
				return new instanceClass();
			return null;
		}
		
		public static function getPointOnDisplayObj(pCurrent:DisplayObject, pTarget:DisplayObject,pPoint:Point):Point
		{
			var aP:Point = pCurrent.localToGlobal(pPoint);
			aP = pTarget.globalToLocal(aP);
			return aP;
			
		}
	}
}