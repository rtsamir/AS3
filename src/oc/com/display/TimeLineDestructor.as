package oc.com.display
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import oc.com.display.Layout.OcDisplayLayout;
	import oc.com.display.Layout.OcLayoutManager;
	import oc.com.utils.GlobalContext;

	public class TimeLineDestructor extends DestructSprite
	{
	//	private static var lastSpriteShow:DestructSprite;
		private static var mCurrentTimeLine:TimeLineDestructor;
		private var mAllMcConcluded:Vector.<DisplayStateVO>;
		public function TimeLineDestructor()
		{
			mAllMcConcluded = new Vector.<DisplayStateVO>();
			super();
		}

		public function get allMcConcluded():Vector.<DisplayStateVO>
		{
			return mAllMcConcluded;
		}

		public function set allMcConcluded(value:Vector.<DisplayStateVO>):void
		{
			mAllMcConcluded = value;
		}

		public function show():DisplayObject
		{
			GlobalContext.stage.addChild(this);
			OcLayoutManager.manager.add(this,OcDisplayLayout.CENTER,OcDisplayLayout.CENTER,0,0);
			if (mCurrentTimeLine != null){
					mCurrentTimeLine.visible = false;
					visibleChildren(mCurrentTimeLine.mAllMcConcluded,false);
				
			}
			mCurrentTimeLine = this;
			this.visible = true;
			visibleChildren(this.mAllMcConcluded,true);
			
			return this;
		}
		
		private function visibleChildren(mArr:Vector.<DisplayStateVO>, param1:Boolean):void
		{
			for (var i:Number = 0; i < mArr.length; i++)
			{
				mArr[i].mcVisible.visible = param1;
				if (param1)
				{						
					mArr[i].mRoot.addChild(mArr[i].mcVisible);
					//if (mArr[i].mRoot == GlobalContext.stage){
					//	OcLayoutManager.manager.add(mArr[i].mcVisible,mArr[i].mHoriz,mArr[i].mVert,mArr[i].mLocX,mArr[i].mLocY);
					//}

				}
				
			}
		}		
	}
}