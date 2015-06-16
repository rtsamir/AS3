package oc.com.cu
{
	import flash.display.MovieClip;
	
	import caurina.transitions.Tweener;
	
	import oc.com.utils.Destructable;

	public class CUProgressBar extends Destructable
	{

		private var mColor:int;
		private var mMax:int;

		private var mProgressBar:MovieClip;
		
		public function CUProgressBar(pProgressBar:MovieClip, pColor:int,pMax:int,pvalue:int = 0)
		{
			mProgressBar = pProgressBar;
			mMax = pMax;
			mColor = pColor;
			pProgressBar.mProgressMask.width = 0;
			if(value != 0){
				value = pvalue;
			}
		}
		
		public function set value(pVal:int):void{
			var aLength:Number = mProgressBar.width;
			var aRatio:int = pVal / mMax;
			var aToLength:Number = mProgressBar.width * aRatio;
			Tweener.addTween(mProgressBar.mProgressMask, {width:aToLength, time:1, transition:"easeInOutBack"});
		}
		
		public override function destruct():void
		{
			Tweener.removeTweens(mProgressBar.mProgressMask);
		}
	}
}