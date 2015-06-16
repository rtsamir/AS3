package oc.com.cu
{
	public class CaptainupContext
	{
		public static var isUseColorPalette:Boolean = true;
		public static var language:Object;
		
		//__________________________________________________________
		
		public static function setText(pText:Object):String
		{
			if(language == null){
				return (pText.toString());
			}
			if(pText == null){
				return "";
			}
			if(pText  is String)
			{
				if(language[pText] != null)
					return (language[pText]);
				else
					return pText as String;
			}
			if(pText is Array){
				if(language[pText[0]] == null){
					return "";
				}
				if(language[pText[0]][pText[1]] == null){
					return "";
				}				
				return language[pText[0]][pText[1]];
			}
			return ("");
		}
		
		
		public static function setTimeText(pText:Object,pTime:String):String
		{
			
			var aText:String = setText(pText);
			aText = aText.replace( '{time}',pTime);
			return (aText);
		}
	}
}