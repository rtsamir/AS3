package oc.com.loader
{
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MediaEvent;
	import flash.media.CameraRoll;
	import flash.media.MediaPromise;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import oc.com.utils.Destructable;
	
	public class LoadingGalleryImage extends Destructable {
		
		private var mediaSource:CameraRoll = new CameraRoll();
		private var imageLoader:Loader; 
		private var mCallback:Function;

		private var mFileRef:FileReference;

		private var mLoader:Loader;
		
		
		public function LoadingGalleryImage(pCallback:Function) {
			mCallback = pCallback;
			
			
			if( CameraRoll.supportsBrowseForImage )
			{
				log( "Browsing for image..." );
				mediaSource.addEventListener( MediaEvent.SELECT, imageSelected );
				mediaSource.addEventListener( Event.CANCEL, browseCanceled );
				
				mediaSource.browseForImage();
			}
			else
			{
				log( "Browsing in camera roll is not supported.");
				mFileRef= new FileReference();
				mFileRef.browse([new FileFilter("Images", "*.jpg;*.gif;*.png")]);
				mFileRef.addEventListener(Event.SELECT, onFileSelected);
			}
		}
		//________________________________________________________________________
		
		protected function onFileSelected(event:Event):void
		{
			mFileRef.addEventListener(Event.COMPLETE, onFileLoaded);
			mFileRef.load();
		}
		
		protected function onFileLoaded(event:Event):void
		{
			mLoader = new Loader();
			mLoader.loadBytes(event.target.data);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPicture);
			
			
		}
		
		protected function onLoadPicture(event:Event):void
		{
			mCallback(mLoader,false);
		}
		//________________________________________________________________________
		
		private function imageSelected( event:MediaEvent ):void
		{
			log( "Image selected..." );
			
			var imagePromise:MediaPromise = event.data;
			
			imageLoader = new Loader();
			if( imagePromise.isAsync )
			{
				log( "Asynchronous media promise." );
				imageLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, imageLoaded );
				imageLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, imageLoadFailed );
				imageLoader.loadFilePromise( imagePromise );
			}
			else
			{
				log( "Synchronous media promise." );
				imageLoader.loadFilePromise( imagePromise );
				mCallback(imageLoader);
			}
		}
		
		private function browseCanceled( event:Event ):void
		{
			log( "Image browse canceled." );
		}
		
		private function imageLoaded( event:Event ):void
		{
			log( "Image loaded asynchronously." );
			mCallback(imageLoader,false);
		}
		
		private function imageLoadFailed( event:Event ):void
		{
			log( "Image load failed." );
		}
		
		private function log( text:String ):void
		{
			trace( "log : " + text );
		}
		
	}
}
