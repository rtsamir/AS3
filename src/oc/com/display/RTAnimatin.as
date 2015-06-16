package oc.com.display
{
	import oc.com.loader.RTLoader;
	import oc.com.math.RTMath;

	public class RTAnimatin extends LoopInteractionSprite
	{
		protected var mFrames:Vector.<RTLoader>
		protected var mCurrentFrame:int = 0;
		public var direction:int = 0;
		public var isLoop:Boolean = true;
		
		public function RTAnimatin(pURL:String,frames:int)
		{
			super();
			setAnimation(pURL, frames);
		}
		
		public function setAnimation(pURL:String,pFramesNum:int):void
		{
			mFrames = new Vector.<RTLoader>();
			for(var i:int  = 0; i < pFramesNum; i++)
			{
				mFrames.push(addImageFile(pURL + "_" + RTMath.fixedDigitNumber((i + 1),2) + ".png"));
				mFrames[mFrames.length - 1].visible = false;
			}
			mFrames[0].visible = true;
		}
		
		public function play():void
		{
			direction = 1;
		}
		
		public function playRevers():void
		{
			direction = -1;
		}		
		
		public function stopRevers():void
		{
			direction = 0;
		}
		
		public function gotoFrame(pIndex:int):void
		{
			mCurrentFrame = pIndex;
		}
		
		override public function act(pData:Object = null):Boolean
		{
			if(direction == 0)
				return false;
			var aNextFrame:int = mCurrentFrame + direction;
			if(aNextFrame >= mFrames.length)
			{
				if(isLoop)
					aNextFrame = 0;
				else
					aNextFrame = mCurrentFrame;
			}
			if(aNextFrame < 0)
			{
				if(isLoop)
					aNextFrame = mCurrentFrame;
				else
					aNextFrame = 0;
			}
			if(aNextFrame == mCurrentFrame)
				return false;
			mFrames[mCurrentFrame].visible = false;
			mCurrentFrame = aNextFrame;
			mFrames[mCurrentFrame].visible = true;
			return true;
		}
	}
}