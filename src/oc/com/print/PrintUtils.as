package oc.com.print
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	
	import oc.com.display.DisplayUtils;

	public class PrintUtils
	{
		public function PrintUtils()
		{
		}
		
		public static function printSprite(pClip:Sprite, pRectangle:Rectangle = null ):void
		{
			var aClip:Sprite = pClip;
			var aBitmap:BitmapData = new BitmapData(aClip.width,aClip.height,true,0xffffffff);
			aBitmap.draw(aClip);
			var opt:PrintJobOptions = new PrintJobOptions();
			opt.printAsBitmap = true;
			//	myPrintJob.addPage(mySprite, null, opt);
			var aBit:Bitmap = new Bitmap(aBitmap);
			var aSprite:Sprite = new Sprite();
			aSprite.addChild(aBit);
			var printJob:PrintJob = new PrintJob();
			
			if (printJob.start())
			{
				
				printJob.addPage(aSprite, pRectangle, null);
				
				printJob.send();
				
				printJob = null;
			}
			
		}
		
		
	}
}