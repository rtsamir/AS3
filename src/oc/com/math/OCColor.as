package oc.com.math
{
	public class OCColor
	{
		public var red:int;
		public var green:int;
		public var blue:int;
		
		public function adjustBrightness(factor:Number):void
		{
			
			red = ((red * factor) > 255) ? 255 : (red * factor);
			green = ((green * factor) > 255) ? 255 : (green * factor);
			blue = ((blue * factor) > 255) ? 255 : (blue * factor);
		}
	}
}