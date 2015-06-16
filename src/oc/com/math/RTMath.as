package oc.com.math
{
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Vector3D;

	public class RTMath
	{
		public static const RAD_TO_DEG:Number = 180 / Math.PI;
		public static const DEG_TO_RAD:Number = Math.PI / 180;
		
		public function RTMath()
		{
			//trace ("DF_Error: DFMath is Static Class");
		}
		//__________________________________________________________
		
		static public function fitRectInBounds(pSourceWidth:Number,pSourceHight:Number,pFitToWidth:Number,pFitToHight:Number):Rectangle
		{
			var lWRatio:Number = pFitToWidth /  pSourceWidth;
			var lHRatio:Number = pFitToHight / pSourceHight;
			var lScale:Number = lHRatio;
			if(lWRatio > lHRatio)
				lScale = lWRatio;
			var lWidth:Number = pSourceWidth * lScale;
			var lHight:Number = pSourceHight * lScale;
			return(new Rectangle((pFitToWidth - lWidth)/2 ,(pFitToHight - lHight)/2,lWidth,lHight));
		}
		//______________________________________________________________
		
		static public function fitRectOutBounds(pSourceWidth:Number,pSourceHight:Number,pFitToWidth:Number,pFitToHight:Number):Rectangle
		{
			var lWRatio:Number = pFitToWidth /  pSourceWidth;
			var lHRatio:Number = pFitToHight / pSourceHight;
			var lScale:Number = lWRatio;
			if(lWRatio > lHRatio)
				lScale = lHRatio;
			var lWidth:Number = pSourceWidth * lScale;
			var lHight:Number = pSourceHight * lScale;
			return(new Rectangle((pFitToWidth - lWidth)/2 ,(pFitToHight - lHight)/2,lWidth,lHight));
		}

        public static function setBitmapDataSize(pBmp:BitmapData,pSizeLimit:int):BitmapData
        {
            var lRrect:Rectangle = fitRectOutBounds(pBmp.width,pBmp.height,pSizeLimit,pSizeLimit);
            if (lRrect.width < pBmp.width)
            {
                var lScale:Number = lRrect.width / pBmp.width;
                var lM:Matrix = new Matrix();
                lM.scale(lScale,lScale);
                var lBmp:BitmapData = new BitmapData(lRrect.width,lRrect.height);
                lBmp.draw(pBmp,lM,null,null,null,true);
                pBmp = lBmp;
            }
            return(pBmp);
        }
		
		public static function timeToString(aTimeLeft:int):String
		{
				var aM:int = Math.floor(aTimeLeft / 60);
				if(aM < 0){
					aM = 0
				}
				var aS:int = aTimeLeft % 60;
				if(aS < 0){
					aS = 0;
				}
				var aRetString:String = "";
				if(aM < 10)
					aRetString = "0";
				aRetString += (aM + ":");
				if(aS < 10)
					aRetString += "0" + aS ;
				else
					aRetString += aS ;
				return(aRetString);
		}
		
		public static function getMixedArray(pSource:Array,pLength:int = -1):Array
		{
			if(pLength == -1)
				pLength = pSource.length;
			var aTemp:Array = pSource.concat();
			var aRetArray:Array = new Array();
			for(var k:int = 0; k < pLength; k++)
			{
				if(aTemp.length == 0)
					return aRetArray;
				var aT:int = Math.floor(Math.random()*aTemp.length);
				aRetArray.push(aTemp[aT]);
				aTemp.splice(aT,1);
			}
			return aRetArray;
		}
		
		public static function vectorToArray(pSource:Object):Array
		{
	
			var aRetArray:Array = new Array();
			if(pSource == null){
				return aRetArray;
			}
			for(var k:int = 0; k < pSource.length; k++)
				aRetArray.push(pSource[k]);
			return aRetArray;
		}
		
		public static function arrayToVector3D(pSource:Array):Vector3D
		{//X Y Z
			if(pSource == null)
				return null;
			return new Vector3D(pSource[0], pSource[1] ,pSource[2]);
		}
		
		public static function vector3DToArray(pSource:Vector3D):Array
		{
			var vectorArray:Array = new Array();
			vectorArray[0] = pSource.x;
			vectorArray[1] = pSource.y;
			vectorArray[2] = pSource.z;
			return vectorArray;
		}
		public static function fixedDigitNumber(pNum:int,pDigitsNum:int):String
		{
			var aRetString:String = pNum.toString();
			while(aRetString.length < pDigitsNum)
				aRetString = "0" + aRetString;
			return(aRetString);
		}
		
		public static function getRandomInt(pTo:int, pfrom:int = 0):int
		{
			var aIndex:int = Math.floor(Math.random() * (pTo - pfrom) + pfrom);
			return aIndex;
		}
		
		public static function getRandomItem(pSource:Array):Object
		{
			var aIndex:int = Math.floor(Math.random() * pSource.length);
			return pSource[aIndex];
		}
		
		public static function uintToRGBColor(value:uint):OCColor {	
			var rgb:OCColor = new OCColor();
			rgb.red = (value >> 16) & 0xFF
			rgb.green = (value >> 8) & 0xFF
			rgb.blue = value & 0xFF			
			return rgb;
		}
		
		public static function RGBColorToUint(pColor:OCColor):uint
		{
			var hex:uint = pColor.red << 16 | pColor.green << 8 | pColor.blue;
			return hex;
		}
		
	}
}