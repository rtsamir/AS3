package oc.com.display.text
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class TextCounterEffectList
	{
		protected const FPS:int = 12;
		protected var mList:Vector.<TextCounterEffectVO>
		protected static var mInstance:TextCounterEffectList;
			 
		
		public function TextCounterEffectList()
		{
			mList = new Vector.<TextCounterEffectVO>();
			var aTimer:Timer = new Timer(1000/FPS);
			aTimer.addEventListener(TimerEvent.TIMER,Uepdate);
			aTimer.start();
		}
		
		public static function get instance():TextCounterEffectList
		{
			if(mInstance == null)
				mInstance = new TextCounterEffectList();
			return mInstance;
		}
		
		protected function Uepdate(event:TimerEvent):void
		{
			for(var i:int  = 0; i < mList.length;i++)
			{
				setScore(mList[i]);
			}
		}
		
		
		protected function setScore(pTextCounterEffectVO:TextCounterEffectVO):void
		{
			if(pTextCounterEffectVO.from == pTextCounterEffectVO.to){
				if(pTextCounterEffectVO.endCallBack != null){
					pTextCounterEffectVO.endCallBack(pTextCounterEffectVO);
					pTextCounterEffectVO.endCallBack = null;
				}
				return;
			}

			var aDScore:Number = (pTextCounterEffectVO.to - pTextCounterEffectVO.from);
			if(Math.abs(aDScore) < 3)
				pTextCounterEffectVO.from = pTextCounterEffectVO.to;
			else{
				var aDNumber:Number = aDScore/pTextCounterEffectVO.factor;
				if(Math.abs(aDNumber) <3){
					if(aDNumber < 0){
						pTextCounterEffectVO.from -=3;
					}
					else
					{
						pTextCounterEffectVO.from +=3;
					}
					
				}
				else{
					pTextCounterEffectVO.from += aDNumber;
				}
			}
			pTextCounterEffectVO.text.text = getCommasNumber(pTextCounterEffectVO.from);
		}
		
		public static function getCommasNumber(pNumber:int):String
		{
			var aScore:String = pNumber.toString();
			if(aScore.length > 3){
				var aNumber:String = aScore.substr(0,aScore.length-3);
				if(aNumber != "")
					aNumber += ","
				aNumber += aScore.substr(aScore.length-3);
				return(aNumber);
			}
			else{
				return(aScore);
			}
		}
		
		public function addTextField(pTextField:TextField,pTo:int, pCurrent:int = int.MIN_VALUE,pFactor:Number = 3,pCallback:Function = null):void
		{
			var aIndex:int = getIndexByTextField(pTextField);
			if(aIndex == -1){
				var aTextCounterEffectVO:TextCounterEffectVO = new TextCounterEffectVO(); 
				mList.push(aTextCounterEffectVO);
			}
			else{
				aTextCounterEffectVO = mList[aIndex];
			}
			updateTextCounterEffectVO(aTextCounterEffectVO,pTextField,pTo, pCurrent,pFactor,pCallback)
		}
		
		protected function updateTextCounterEffectVO(pTextCounterEffectVO:TextCounterEffectVO,pTextField:TextField,pTo:int, pCurrent:int = int.MIN_VALUE,pFactor:Number = 3,pCallback:Function = null):void{
			pTextCounterEffectVO.text = pTextField;
			pTextCounterEffectVO.to = pTo;
			pTextCounterEffectVO.endCallBack = pCallback;
			pTextCounterEffectVO.factor = pFactor;
			if(pCurrent != int.MIN_VALUE){
				pTextCounterEffectVO.from = pCurrent;
			}
		}
		
		public function removeTextField(pTextField:TextField, pCurrent,pTo):void
		{
			var aIndex:int = getIndexByTextField(pTextField);
			if(aIndex > -1){
				mList.splice(aIndex,1);
			}
		}
		
		protected function getIndexByTextField( pTextField:TextField):int
		{
			for(var i:int  = 0; i < mList.length;i++)
			{
				if(mList[i].text == pTextField){
					return (i);
				}
			}
			return (-1);
		}



	}
}