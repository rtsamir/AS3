package oc.com.display
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import oc.com.display.Layout.OcLayoutManager;

	public class DisplayStateVO
	{
		public var mcVisible:MovieClip;
	//	public var mObjectContainIn:Object;
		public var mRoot:DisplayObject;
		public var mHoriz:String;
		public var mVert:String;
		public var mLocX:Number;
		public var mLocY:Number;
		public function DisplayStateVO(pMc:MovieClip,pRoot:DisplayObject,pHoriz:String,pVert:String,pLocX:Number,pLocY:Number)
		{
			mcVisible = pMc;
		//	mObjectContainIn = pCotainer;
			mHoriz = pHoriz;
			mVert = pVert;
			mLocX = pLocX;
			mLocY = pLocY;
			mRoot = pRoot;

		}
	}
}