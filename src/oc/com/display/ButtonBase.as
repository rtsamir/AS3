package oc.com.display
{
	import flash.events.MouseEvent;
	
	import oc.com.loader.RTLoader;
	import oc.com.utils.GlobalContext;
	
	public class ButtonBase extends GameAssetsBase
	{
		protected var mUp:RTLoader;
		protected var mDown:RTLoader;
		protected var mOver:RTLoader;


		
		
		public function ButtonBase(pUrl:String,x:int = 0,y:int = 0)
		{
			super();
			this.useHandCursor = true;
			this.buttonMode = true;
			mDown = addImageFile(pUrl + "_down.png");
			mDown.visible = false;
			mOver = addImageFile(pUrl + "_over.png");
			mOver.visible = false;
			mUp = addImageFile(pUrl + "_up.png");
			addEventListener(MouseEvent.ROLL_OVER,onOver);
			addEventListener(MouseEvent.ROLL_OUT,onOut);
			//addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			//GlobalContextt.stage.addEventListener(MouseEvent.MOUSE_UP,onUp);
			this.x = x;
			this.y = y;
		}
		
		protected function onDown(event:MouseEvent):void
		{
			
			mOver.visible = false;
			mDown.visible = true;
			mUp.visible = false;
			
		}
		
		protected function onOver(event:MouseEvent):void
		{
			
			mOver.visible = true;
			mDown.visible = false;
			mUp.visible = false;
		}
		
		protected function onOut(event:MouseEvent):void
		{
			
			mOver.visible = false;
			mDown.visible = false;
			mUp.visible =  true;
		}
		
		protected function onUp(event:MouseEvent):void
		{
			
			mOver.visible = false;
			mDown.visible = false;
			mUp.visible = false;
			if(this.hitTestPoint(GlobalContext.stage.mouseX,GlobalContext.stage.mouseY))
				mOver.visible = true;
			else
				mUp.visible =  true;
			
			
		}
		
		override public function destruct():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER,onOver);
			removeEventListener(MouseEvent.MOUSE_OUT,onUp);
			removeEventListener(MouseEvent.MOUSE_DOWN,onDown);
			GlobalContext.stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);
			super.destruct();
		}
		
		
		
	}
}