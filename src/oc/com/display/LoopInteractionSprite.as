package oc.com.display
{
	public class LoopInteractionSprite extends GameAssetsBase
	{
		public function LoopInteractionSprite()
		{
			super();
		}
		//--------------------------------------------------------------------
		
		public function act(pData:Object = null):Boolean
		{
			if(mActers == null)
				return true;
			for( var i:int  = 0; i < mActers.length; i++)
				mActers[i].act();
			return true;
		}
		//--------------------------------------------------------------------
		
		public function init(data:Object = null):Boolean
		{
			path = String(data);
			return true;
		}
	}
}