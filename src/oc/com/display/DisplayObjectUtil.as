package oc.com.display {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	
	/**
	 * A util class that has some function that helps with display objects. Function list: getAllInstancesFromType,
	 * getAllSubInstancesFromType, searchChild, fromLabelToIndexOfFrame, convertMovieToByteArrayPicture.
	 */
	public class DisplayObjectUtil {
		
		private static const SEPERATOR:String = '.';
		
		/**
		 * Gets a resource(mc) and a type of class and makes a new dictionary and runs over all the mc children and their children as well and
		 * if it finds a child with the given parameter type of class, it add to dictionary. It returns the dictionary.
		 */
		public static function getAllInstancesFromType(resource:MovieClip, typeClass:Class):Dictionary {
			
			var result:Dictionary = new Dictionary;
			getAllSubInstancesFromType(result, '', resource, typeClass);
			return result
		}
		
		/**
		 * Gets a dictionary, key, resource(movie clip) and type of class. It runs over all the resource children and adds them to the
		 * dictionary if the child type of class is as the given parameter. If the child is a resource too, it executes this function on it
		 * recursively.
		 */
		private static function getAllSubInstancesFromType(dictionary:Dictionary, key:String, resource:MovieClip, typeClass:Class):void {
			
			for(var i:int = 0; i < resource.numChildren; i++) {
				var child:DisplayObject = resource.getChildAt(i);
				
				if(child is typeClass) {
					dictionary[key + SEPERATOR + child.name] = child;
				}
				
				if(child is MovieClip) {
					getAllSubInstancesFromType(dictionary, key + SEPERATOR + child.name, child as MovieClip, typeClass);
				}
			}
		}
		
		public static function getAllInstanceNamed(resource:Sprite, name:String):Array {
			
			var result:Array = [];
			getAllSubInstancesNamed(result, '', resource, name);
			return result
		}
		
		private static function getAllSubInstancesNamed(dictionary:Array, key:String, resource:Sprite, name:String):void {
			
			for(var i:int = 0; i < resource.numChildren; i++) {
				var child:DisplayObject = resource.getChildAt(i);
				
				if(child.name == name) {
					dictionary.push(child);
				}
				
				if(child is MovieClip) {
					getAllSubInstancesNamed(dictionary, key + SEPERATOR + child.name, child as MovieClip, name);
				}
			}
		}
		
		/**
		 * Gets a resource(movie clip) and a child name. It runs over all the resource children and checks if their name is the same as the
		 * given parameter. If it is, it returns the child. If one of the children is a movie clip it self, it executes this function on it
		 * recursively. It returns 'null' if there is no children with this name.
		 * @param resource
		 * @param childName
		 * @return
		 *
		 */
		public static function searchChild(resource:MovieClip, childName:String):DisplayObject {
			
			for(var i:int = 0; i < resource.numChildren; i++) {
				var child:DisplayObject = resource.getChildAt(i);
				
				if(child.name == childName) {
					return child;
				}
				
				if(child is MovieClip) {
					var result:DisplayObject = searchChild(child as MovieClip, childName);
					
					if(result != null) {
						return result;
					}
				}
			}
			return null;
		}
		
		/**
		 * Gets a moive clip and a frame label. It runs over all the labels in the mc and checks if one of their name is equal to the given
		 * parameter. If it is, it returns the frame number of this label and if it doesn't find an adjustment, it returns 0.
		 * @param mc
		 * @param frameLabel
		 * @return
		 *
		 */
		public static function fromLabelToIndexOfFrame(mc:MovieClip, frameLabel:String):int {
			
			var frame:int;
			var labels:Array = mc.currentLabels;
			
			for(var i:int = 0; i < labels.length; i++) {
				if(labels[i].name == frameLabel) {
					frame = labels[i].frame;
				}
			}
			return frame;
		}
		
		public static function convertMovieToByteArrayPicture(movie:DisplayObject, boundaryStr:String,
															  imageProportions:Point = null):ByteArray {
			
			if(imageProportions == null) {
				imageProportions = new Point(movie.width, movie.height)
			}
			var snapshotData:BitmapData = new BitmapData(imageProportions.x, imageProportions.y);
			snapshotData.draw(movie);
			
			return convertBitmapDataToByteArray(snapshotData, boundaryStr);
		}
		
		public static function convertBitmapDataToByteArray(snapshotData:BitmapData, boundaryStr:String):ByteArray {
			var oPngSnapshotBA:ByteArray = null//PNGEncoder.encode(snapshotData);
			var strForStart:String = "\r\n--" + boundaryStr + "\r\n" + "Content-Disposition: form-data; name=\"photo\"; filename=\"file1.png\"\r\n" + "Content-Type: image/png\r\n\r\n" + "";
			var strForEnd:String = "--" + boundaryStr + "\r\n" + "Content-Disposition: form-data; name=\"Upload\"\r\n\r\n" + "Submit Query\r\n" + "--" + boundaryStr + "--";
			
			var oBeginBA:ByteArray = new ByteArray();
			oBeginBA.writeMultiByte(strForStart, "ascii");
			var oFinishBA:ByteArray = new ByteArray();
			oFinishBA.writeMultiByte(strForEnd, "ascii");
			
			var oResultBytes:ByteArray = new ByteArray();
			oResultBytes.writeBytes(oBeginBA, 0, oBeginBA.length);
			oResultBytes.writeBytes(oPngSnapshotBA, 0, oPngSnapshotBA.length);
			oResultBytes.writeBytes(oFinishBA, 0, oFinishBA.length);
			
			return oResultBytes;
		}
		
		public static function createBitmap(source:DisplayObject, indentForFilter:int = 10, indentForGetColorBoundsRect:int = 1):Bitmap {
			
			var rect:Rectangle = source.getBounds(source);
			
			if(rect.isEmpty()) {
				return null;
			}
			
			var indentForFilterDouble:int = 2 * indentForFilter;
			
			rect.width = Math.ceil(rect.width) + indentForFilterDouble;
			rect.height = Math.ceil(rect.height) + indentForFilterDouble;
			
			rect.x = Math.floor(rect.x) - indentForFilter;
			rect.y = Math.floor(rect.y) - indentForFilter;
			
			var mtx:Matrix = new Matrix();
			mtx.tx = -rect.x;
			mtx.ty = -rect.y;
			
			var scratchBitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0x00000000);
			scratchBitmapData.draw(source, mtx);
			
			var trimBounds:Rectangle = scratchBitmapData.getColorBoundsRect(0xFF000000, 0x00000000, false);
			
			var indentForGetColorBoundsRectDouble:int = 2 * indentForGetColorBoundsRect;
			trimBounds.x -= indentForGetColorBoundsRect;
			trimBounds.y -= indentForGetColorBoundsRect;
			trimBounds.width += indentForGetColorBoundsRectDouble;
			trimBounds.height += indentForGetColorBoundsRectDouble;
			
			var bitmapData:BitmapData = new BitmapData(trimBounds.width, trimBounds.height, true, 0);
			bitmapData.copyPixels(scratchBitmapData, trimBounds, new Point());
			
			scratchBitmapData.dispose();
			
			var bitmap:Bitmap = new Bitmap(bitmapData);
			bitmap.x = trimBounds.x + rect.x;
			bitmap.y = trimBounds.y + rect.y;
			
			return bitmap;
		}
		
		public static function convertDisplayObjectToBitmapData(displayObject:DisplayObject):BitmapData {
			var bitmapData:BitmapData = new BitmapData(displayObject.width, displayObject.height, true, 0x00000000);
			bitmapData.draw(displayObject);
			return bitmapData;
		}
		
		[Deprecated(replacement = "createBitmap")]
		public static function convertDisplayObjectToBitmap(displayObject:DisplayObject):Bitmap {
			return new Bitmap(convertDisplayObjectToBitmapData(displayObject), "auto", true);
		}
		
		public static function hasLabel(mc:MovieClip, frameLabel:String):Boolean {
			
			var labels:Array = mc.currentLabels;
			
			for(var i:int = 0; i < labels.length; i++) {
				if(labels[i].name == frameLabel) {
					return true;
				}
			}
			return false;
		}
		
		public static function getChildrenByPrefix(resource:MovieClip, prefix:String, index:int = 0):Array {
			
			var result:Array = [];
			
			for(var i:int = index; i < resource.numChildren; i++) {
				var child:DisplayObject = resource.getChildByName(prefix + i);
				
				if(child == null) {
					break;
				}
				result.push(child);
			}
			return result;
		}
		
		
		public static function movieClipHasLabel(movieClip:MovieClip, labelName:String):Boolean {
			var i:int;
			var k:int = movieClip.currentLabels.length;
			for (i; i < k; ++i) {
				var label:FrameLabel = movieClip.currentLabels[i];
				if (label.name == labelName)
					return true; 
			}
			return false;
		}
	}
}
