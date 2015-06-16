package oc.com.display.text
{
	import com.greensock.layout.AlignMode;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import oc.com.interfaces.IDestructable;
	import oc.com.utils.GlobalContext;
	
	public class RightToLeftHandler //implements IDestructable
	{
		// for use without create new object
		//public static var instance:RightToLeftHandler;
		
		// 
		//	private var myRealString:String;
		//		private var mySString:String;
		
		private var mHidenTextField:TextField;
		private var mMaxCharsInLine:Number;
		//	private var myStringHideUntilNow:String;
		public var myLines:Array;
		private var mNumOfLinesLimit:Number;
		private var mShowenTextField:TextField;
		private var bIsSaman:Boolean;
		private var strBefore:String;
		private var strNow:String;
		private static var timer:Timer;
		//private static var mCurrentTextField:TextField;
		//private static var mLastChangeTextField:TextField;
		private static var current:RightToLeftHandler;
		private var bISDelete:Boolean;
		
		public function RightToLeftHandler(tFiledNew:TextField, tFiled:TextField, max:Number, lines:Number)
		{
			if(GlobalContext.language != GlobalContext.HEBREW) 
			{
				var myFormat:TextFormat = new TextFormat();
				myFormat.align = AlignMode.LEFT;
				tFiled.defaultTextFormat = myFormat;
				tFiled.visible = true;
				tFiledNew.visible = false;
				return;
			}
			
			strBefore = "";
			strNow = "";
			bISDelete = false;
			mMaxCharsInLine = max;
			myLines = new Array();
			myLines.push ("");
			mHidenTextField = tFiledNew;
			mNumOfLinesLimit = lines;
			//myLines =
			//myStringHideUntilNow = mHidenTextField.text;
			mHidenTextField.text = "";
			mShowenTextField = tFiled;
			mShowenTextField.text = "";
			if (timer == null)
			{
				timer = new Timer(180);
				timer.addEventListener(TimerEvent.TIMER,onTimer);
				
				timer.start();
			}
			mHidenTextField.addEventListener(FocusEvent.FOCUS_IN, onFocus);
			
			mHidenTextField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			mHidenTextField.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			mHidenTextField.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			GlobalContext.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			bIsSaman = false;
			
		}
		
		public function get showenTextField():TextField
		{
			return mShowenTextField;
		}
		
		public function get hidenTextField():TextField
		{
			return mHidenTextField;
		}
		
		protected function onKey(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.BACKSPACE)
			{
				if (myLines.length > 0)
				{
					var str:String = 	myLines[0];
					if (str.length >0)
					{
						str = str.substring(0,str.length -1);
						myLines[0] = str;
					}
					else if (myLines.length>1)
					{
						myLines.shift();	
					}
				}
				bISDelete = true;
				
				//myStringHideUntilNow = myStringHideUntilNow.substr(0, myStringHideUntilNow.length-1);
			}
			else if (event.keyCode == Keyboard.ENTER)
			{
				if (myLines.length < mNumOfLinesLimit)
					myLines.unshift("");
				bISDelete = true;

			}
		}
		
		protected function onAdd(event:Event):void
		{
			mHidenTextField.removeEventListener(FocusEvent.FOCUS_IN, onFocus);
			mHidenTextField.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			mHidenTextField.addEventListener(FocusEvent.FOCUS_IN, onFocus);
			mHidenTextField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);			
		}
		
		protected function onRemove(event:Event):void
		{
			mHidenTextField.removeEventListener(FocusEvent.FOCUS_IN, onFocus);
			mHidenTextField.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);	
			//	removeSaman();
			
		}
		protected function onFocus(event:FocusEvent):void
		{			
			if((current != null)&&(current != this)){
				current.mShowenTextField.text = current.removeSaman(current.mShowenTextField.text);
			}
			current = this;
			//trace("curent"+ this);
			
		}
		public function isChanged():Boolean
		{
		//	trace(current);
			if (current == null)
				return false;
			if (bISDelete)
			{
				bISDelete = false;
				return true;
			}
	//		trace("current.strNow"+current.strNow);
		//	trace("current.strBefore"+current.strBefore);

			return 	(current.strNow == current.strBefore);

			
			//return (!(current.mHidenTextField.text == ""))	
		}
		protected function onFocusOut(event:FocusEvent):void
		{				
			mShowenTextField.text = removeSaman(mShowenTextField.text);
			if(current == this){
				current = null;
			}
		}
		//_________________________________
		protected static function onTimer(event:TimerEvent):void
		{
			if (current == null){
				return;
			}
			current.bIsSaman = !current.bIsSaman;
			var myArr:Array;
			
			current.strBefore = current.myLines[0];
			
			if ((current.mHidenTextField.text != '\r')&&(current.mHidenTextField.text != '\n')&&(current.mHidenTextField.text != ''))
			{
				if (current.myLines[0].length < current.mMaxCharsInLine)
				{
					current.myLines[0] += current.mHidenTextField.text;
				}
				else if (current.myLines.length < current.mNumOfLinesLimit)
				{
					var arr:Array = current.myLines[0].split(' ');
					if (arr.length == 1)
					{
						current.myLines.unshift(current.mHidenTextField.text);
					}
					else
					{
						current.myLines.unshift(arr.pop() + current.mHidenTextField.text);
						current.myLines[1] = arr.join(' ');
					}
				}
				

			}
			current.strNow = current.myLines[0];
			trace (current.strNow);
			if (current.isChanged())
			{
				current.mShowenTextField.text = ChangeFullTextWithLines(current.myLines.join('\n'));			
			}
			current.mHidenTextField.text = "";

			if (current.bIsSaman)
			{
				var mArr:Array = current.mShowenTextField.text.split('\r');
				if (mArr.length > 0)
					mArr[mArr.length -1] = "|" + mArr[mArr.length -1];
				current.mShowenTextField.text = mArr.join('\n');
			}
			else
			{
				current.mShowenTextField.text = current.removeSaman(current.mShowenTextField.text);
			}
		}
	
		public function removeSaman(myStr:String):String
		{
			var myArr:Array = myStr.split('\r');
			var str:String = myArr[0];
			
				if (str.charAt(str.length-1) == '|')
				{
					str = str.substring(0,str.length-1);
				}
				else if (str.charAt(0) == '|')
				{
					str = str.substring(1);

				}
				myArr[0] = str;
				myStr =  myArr.join('\n');
				return myStr;
		}
		
		
		public static function ChangeFullTextWithLines(str:String):String
		{
			var myFullString:String = "";
			var myArr:Array = str.split('\r');
			for (var i:Number = 0; i< myArr.length; i ++)
			{
				myArr[i] = ChangeString(myArr[i]);
			}
			myFullString = myArr.join('\n');
			
			return myFullString;
		}
		public static function changeDynamicTextField(tField:TextField,textToWrite:String = ""):void{
			
			if(GlobalContext.language != GlobalContext.HEBREW) {
				var myFormat:TextFormat = new TextFormat();
				myFormat.align = AlignMode.LEFT;
				tField.defaultTextFormat = myFormat;
				tField.text = textToWrite;

				
			}else{
				tField.text = ChangeString(textToWrite);
			}
		}
		public static function ChangeString(str:String):String
		{
			if(GlobalContext.language != GlobalContext.HEBREW) 
			{
				return str;
			}
			var checkIfHebrew:Boolean = false;
			var myString:String = "";
			var myHebrewUntilNow:String = "";
			var myEnglishUntilNow:String = "";
			for (var i:Number = 0; i < str.length; i++)
			{
				if (((str.charAt(i) <= 'ת') && (str.charAt(i) >= 'א')))
				{
					myHebrewUntilNow =str.charAt(i)+""+ myHebrewUntilNow;
					checkIfHebrew = true;
					if (myEnglishUntilNow.length > 0)
					{
						if (myEnglishUntilNow.charAt(myEnglishUntilNow.length-1) == ' ')
						{
							myString = ' '+ myEnglishUntilNow.substring(0,myEnglishUntilNow.length-1)+ myString;
						}
						else
						{
							myString = myEnglishUntilNow+ myString;
						}
						
						myEnglishUntilNow = "";
					}
				}
				else if (((str.charAt(i) <='z') &&(str.charAt(i) >='a'))||((str.charAt(i) <='Z') &&(str.charAt(i) >='A'))||(str.charAt(i) is Number ))
				{
					
					myEnglishUntilNow = myEnglishUntilNow+ str.charAt(i);
					checkIfHebrew = false;
					if (myHebrewUntilNow.length > 0)
					{
						myString = myHebrewUntilNow+ myString;
						myHebrewUntilNow = "";
					}
				}
					
				else 
				{
					if ((checkIfHebrew))
					{
						myHebrewUntilNow =str.charAt(i)+""+ myHebrewUntilNow;
					}
					else
					{
						myEnglishUntilNow = myEnglishUntilNow+ str.charAt(i);
					}		
				}
			}
			
			if (myEnglishUntilNow.length > 0)
			{
				if (myEnglishUntilNow.charAt(myEnglishUntilNow.length-1) == ' ')
				{
					myString = ' '+ myEnglishUntilNow.substring(0,myEnglishUntilNow.length-1)+ myString;
				}
				else
				{
					myString = myEnglishUntilNow+ myString;
				}
			}
			else
			{
				myString = myHebrewUntilNow+ myString;
				
			}
			return myString;
		}
	}
}
