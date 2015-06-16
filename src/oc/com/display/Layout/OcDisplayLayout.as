package oc.com.display.Layout
{
	import flash.display.DisplayObject;
	
	public class OcDisplayLayout
	{
		public static const TOP:String = "TOP";
		public static const CENTER:String = "CENTER";
		public static const BOTTOM:String = "BOTTOM";
		public static const LEFT:String = "LEFT";
		public static const RIGHT:String = "RIGHT";


		public var typeX:String;
		public var typeY:String;
		public var locX:Number;
		public var locY:Number;
		public var maxX:Number = 0.5;
		public var display:DisplayObject;
		
		
		public function setDisplay(pDPIRatiO:Number,pWidth:Number,pHeight:Number):void
		{
			display.scaleX = pDPIRatiO;
			display.scaleY = pDPIRatiO;
			switch(typeX)
			{
				case OcDisplayLayout.RIGHT:
				{
					display.x = pWidth - locX * pDPIRatiO;
					break;
				}
					
				case OcDisplayLayout.LEFT:
				{
					display.x = locX * pDPIRatiO;
					break;
				}
				case OcDisplayLayout.CENTER:
				{
					display.x = pWidth/2 + locX * pDPIRatiO;
					break;
				}
			}
			switch(typeY)
			{
				case OcDisplayLayout.BOTTOM:
				{
					display.y = pHeight - locY * pDPIRatiO;
					break;
				}
					
				case OcDisplayLayout.TOP:
				{
					display.y = locY * pDPIRatiO;
					break;
				}
				case OcDisplayLayout.CENTER:
				{
					display.y = pHeight/2 + locY * pDPIRatiO;
					break;
				}
			}			
		}
	}
}