package oc.com.utils
{
	public class ErrorData
	{

		public var mMessage:String;
		public var mSender:Object;
		public var mFunction:String;
		
		public function ErrorData(pError:String,pSender:Object,PFunction:String)
		{
			mFunction = PFunction;
			mSender = pSender;
			mMessage = pError;
		}
	}
}