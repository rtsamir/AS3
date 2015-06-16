package oc.com.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class LocalLoader extends Loader
	{
		private var fileReference:FileReference;
		
		public function LocalLoader(mLoadCompleteCallback)
		{
			
		}

		
		public function brows(event:MouseEvent):void
		{
			trace("onBrowse");
			fileReference=new FileReference();
			fileReference.addEventListener(Event.SELECT, onFileSelected);
			var imagesFilter:FileFilter = new FileFilter("Images", "*.jpg;*.bmp;*.png");

			fileReference.browse([imagesFilter]);
		}
		
		public function onFileSelected(event:Event):void
		{
			trace("onFileSelected");
			fileReference.addEventListener(Event.COMPLETE, onFileLoaded);
			fileReference.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
			fileReference.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			fileReference.load();
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			var file:FileReference = FileReference(event.target);
			var percentLoaded:Number=event.bytesLoaded/event.bytesTotal*100;
			trace("loaded: "+percentLoaded+"%");
			//ProgresBar.mode=ProgressBarMode.MANUAL;
			//ProgresBar.minimum=0;
			//ProgresBar.maximum=100;
			//ProgresBar.setProgress(percentLoaded, 100);
		}
		
		public function onFileLoaded(event:Event):void
		{
			var fileReference:FileReference=event.target as FileReference;
			var data:ByteArray=fileReference["data"];
			trace("File loaded");
			loadBytes(data);
			contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			
		}
		
		public function onFileLoadError(event:Event):void
		{
			trace("File load error");
		}   
		
		public function onLoaderComplete(event:Event):void
		{
			
		}
	}
}