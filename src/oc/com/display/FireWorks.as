
/*
Flash AS3 tutorial by Dan Gries.

www.flashandmath.com
dan@flashandmath.com

Please see terms of use at http://www.flashandmath.com/about/terms.html
*/

package oc.com.display
{
	import com.flashandmath.dg.objects.Particle3D;
	import com.flashandmath.dg.objects.Particle3DList;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public class FireWorks extends DestructSprite
	{
		protected var flareList:Particle3DList;
		protected var sparkList:Particle3DList;
		protected var sparkBitmapData:BitmapData;
		protected var sparkBitmap:Bitmap;
		protected var waitCount:int;
		protected var count:int;
		protected var darken:ColorTransform;
		protected var origin:Point;
		protected var blur:BlurFilter;
		protected var sky:Sprite;
		protected var minWait:Number;
		protected var maxWait:Number;
		protected var colorList:Vector.<uint>;
		protected var maxDragFactorFlare:Number;
		protected var maxDragFactorSpark:Number;
		protected var maxNumSparksAtNewFirework:Number;
		protected var displayHolder:Sprite;
		protected var displayWidth:Number;
		protected var displayHeight:Number;
		protected var starLayer:Sprite;
		
		protected var particle:Particle3D;
		protected var nextParticle:Particle3D;
		protected var spark:Particle3D;
		protected var nextSpark:Particle3D;
		protected var phi:Number;
		protected var theta:Number;
		protected var mag:Number;
		protected var dragFactor:Number;
		protected var flareOriginX:Number;
		protected var flareOriginY:Number;
		protected var numFlares:Number;
		protected var numSparks:Number;
		protected var sparkAlpha:Number;
		protected var sparkColor:uint;
		protected var randDist:Number;
		protected var presentAlpha:Number;
		protected var colorParam:Number;
		protected var fireworkColor:uint;
		protected var grayAmt:Number;
		protected var gravity:Number;
		protected var maxNumFlares:Number;
		protected var maxNumSparksPerFlare:int;
		protected var topMargin:Number;
		protected var mCounter:int = 0;
		protected var mMaxWorks:int = 5;
		
		public function FireWorks()
		{
			super();
			init();
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		
		
		protected function init():void {
			displayWidth = 1000;
			displayHeight = 700;
			
			waitCount = 20;
			minWait = 10;
			maxWait = 50;
			count = waitCount - 1;
			
			/*
			The particles in this code are not display objects, but rather abstract particles which
			simply keep track of their position, velocity, color, etc.
			We will have two types of particles. "Flares" will not be seen - these explode away from a central
			position when a new firework is created. On each frame, "sparks" will be emitted from the positions
			of each flare. The sparks will be drawn to a bitmap.
			In order to produce realistic motion, the particles are 3D particles with x, y, and z coordinates
			(and 3D velocity vectors). However, for simplicity we will not bother with proper perspective projection
			of the particles. Instead we will simply project to the plane by ignoring z-coordinates while drawing.
			*/
			flareList = new Particle3DList();
			sparkList = new Particle3DList();
			
			maxDragFactorFlare = 0.6;
			maxDragFactorSpark = 0.6;
			
			//To control the number of particles being animated, when the current number of sparks exceeds the number below, a new firework will not be initiated.
			maxNumSparksAtNewFirework = 6000;
			
			gravity = 0.03;
			
			//max number of flares in a single firework:
			maxNumFlares = 50; 
			
			//on each frame, sparks are added at each flare position. This is the max to add:
			maxNumSparksPerFlare = 2; 
			
			//the flares will remain active even if they go higher than the visible area, because they may drop down
			//again due to gravity. We will let them go this high over the visible area before being deactivated.
			topMargin = 6;
			
			displayHolder = new Sprite;
			displayHolder.x = -displayWidth/2;
			displayHolder.y = -displayHeight/2;
			sparkBitmapData = new BitmapData(displayWidth, displayHeight, true, 0x00000000);
			sparkBitmap = new Bitmap(sparkBitmapData);	
			
			/*
			The ColorMatrixFilter below will make the colors whiten a little where they are more concentrated.
			It will be applied to the Bitmap overall rather than applied to the BitmapData on each frame.
			*/
			var alphaToWhite:Number = 0.5;
			var alphaMult:Number = 1.6;
			var cmf:ColorMatrixFilter = new ColorMatrixFilter([1,0,0,alphaToWhite,0,
				0,1,0,alphaToWhite,0,
				0,0,1,alphaToWhite,0,
				0,0,0,alphaMult,0]);
			sparkBitmap.filters = [cmf];
			
			var frame:Shape = new Shape();
			frame.graphics.lineStyle(1,0x111111);
			frame.graphics.drawRect(0,0,displayWidth,displayHeight);
			frame.x = displayHolder.x;
			frame.y = displayHolder.y;
			//addChild(frame);
			
			
			//Drawing stars. Stars get dimmer the lower they are in the sky.;
			this.addChild(displayHolder);
			displayHolder.addChild(sparkBitmap);
			
			darken = new ColorTransform(1,1,1,0.87);
			blur = new BlurFilter(4,4,1);
			origin = new Point(0,0); //used in filters
			
			//firework colors will be chosen randomly from this list:
			colorList = new <uint>[0x68ff04, 0xefe26d, 0xfc4e50, 0xfffae7, 0xffc100,
				0xe02222, 0xffa200, 0xff0000, 0x3473ff, 0xc157ff,
				0x9b3c8a, 0xf9dc98, 0xdc9c45, 0xee9338];
			
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		protected function onEnter(evt:Event):void {		
			count++;
			//add another firework if the time count is right and there are not too many particles on the stage.
			if ((count >= waitCount)&&(sparkList.numOnStage < maxNumSparksAtNewFirework)) {
				mCounter++;
				if(mCounter <= mMaxWorks){
					//the time before another firework will be randomized:
					waitCount = minWait+Math.random()*(maxWait - minWait);
					fireworkColor = randomColor();
					count = 0;
					flareOriginX = displayWidth *0.75 - Math.random()*displayWidth/2;
					flareOriginY = displayHeight *0.75 - Math.random()*displayHeight/2;
					var i:int;
					var sizeFactor:Number = 0.1 + Math.random()*0.9;
					
					numFlares = (0.25+0.75*Math.random()*sizeFactor)*maxNumFlares;
					for (i = 0; i < numFlares; i++) {
						var thisParticle:Particle3D = flareList.addParticle(flareOriginX, flareOriginY,0);
						//Flares will explode out with spherically (with randomization).
						theta = 2*Math.random()*Math.PI;
						phi = Math.acos(2*Math.random()-1);
						mag = 20 + sizeFactor*sizeFactor*50;//sizeFactor*(60 + 3*Math.random());
						thisParticle.vel.x = mag*Math.sin(phi)*Math.cos(theta);
						thisParticle.vel.y = mag*Math.sin(phi)*Math.sin(theta);
						thisParticle.vel.z = mag*Math.cos(phi);
						thisParticle.airResistanceFactor = 0.015;
						//envelope - this determines how long a flare will live.
						thisParticle.envelopeTime1 = 45 + 60*Math.random();
						
						thisParticle.color = fireworkColor;
					}
				}
			}
			
			//update particles
			particle  = flareList.first;
			while (particle != null) {
				nextParticle = particle.next;
				dragFactor = particle.airResistanceFactor*Math.sqrt(particle.vel.x*particle.vel.x + particle.vel.y*particle.vel.y + particle.vel.z*particle.vel.z);
				//clamp:
				if (dragFactor > maxDragFactorFlare) {
					dragFactor = maxDragFactorFlare;
				}
				var aSpeed:Number =  0.05
				particle.vel.x += aSpeed*(Math.random()*2 - 1);
				particle.vel.y += aSpeed*(Math.random()*2 - 1) + gravity;
				particle.vel.z += aSpeed*(Math.random()*2 - 1);
				particle.vel.x -= dragFactor*particle.vel.x;
				particle.vel.y -= dragFactor*particle.vel.y;
				particle.vel.z -= dragFactor*particle.vel.z;
				particle.pos.x += particle.vel.x;
				particle.pos.y += particle.vel.y;
				particle.pos.z += particle.vel.z;
				
				particle.age += 1;
				if (particle.age > particle.envelopeTime1) {
					particle.dead = true;
				}
				if ((particle.dead)||(particle.pos.x > displayWidth) || (particle.pos.x < 0) || (particle.pos.y > displayHeight) || (particle.pos.y < -topMargin)) {
					flareList.recycleParticle(particle);
				}
					
				else {
					//add sparks - a large number of sparks is more likely for a young flare.
					numSparks = Math.floor(Math.random()*(maxNumSparksPerFlare+1)*(1 - particle.age/particle.envelopeTime1));
					for (i = 0; i < maxNumSparksPerFlare; i++) {
						randDist = Math.random();
						var thisSpark:Particle3D = sparkList.addParticle(particle.pos.x - randDist*particle.vel.x, particle.pos.y - randDist*particle.vel.y, 0, 0);
						thisSpark.vel.x = 0.2*(Math.random()*2 - 1);
						thisSpark.vel.y = 0.2*(Math.random()*2 - 1);
						thisSpark.envelopeTime1 = 10+Math.random()*40;
						thisSpark.envelopeTime2 = thisSpark.envelopeTime1 + 6 + Math.random()*6;
						thisSpark.airResistanceFactor = 0.2;
						thisSpark.color = particle.color;
					}
				}
				
				particle = nextParticle;
			}
			
			//update sparks
			sparkBitmapData.lock();
			//old particles will not be erased. Instead we will apply filters which more gradually fade out the particles.
			sparkBitmapData.colorTransform(sparkBitmapData.rect, darken);
			sparkBitmapData.applyFilter(sparkBitmapData, sparkBitmapData.rect, origin, blur);
			spark  = sparkList.first;
			while (spark != null) {
				nextSpark = spark.next;
				dragFactor = spark.airResistanceFactor*Math.sqrt(spark.vel.x*spark.vel.x + spark.vel.y*spark.vel.y);
				//clamp:
				if (dragFactor > maxDragFactorSpark) {
					dragFactor = maxDragFactorSpark;
				}
				spark.vel.x += 0.07*(Math.random()*2 - 1);
				spark.vel.y += 0.07*(Math.random()*2 - 1) + gravity;
				spark.vel.x -= dragFactor*spark.vel.x;
				spark.vel.y -= dragFactor*spark.vel.y;
				spark.pos.x += spark.vel.x;
				spark.pos.y += spark.vel.y;
				
				spark.age += 1;
				
				if (spark.age < spark.envelopeTime1) {
					sparkAlpha = 255;
				}
				else if (spark.age < spark.envelopeTime2) {
					sparkAlpha = -255/spark.envelopeTime2*(spark.age - spark.envelopeTime2);
				}
				else {
					spark.dead = true;
				}
				
				if ((spark.dead)||(spark.pos.x > displayWidth) || (spark.pos.x < 0) || (spark.pos.y > displayHeight) || (spark.pos.y < -topMargin)) {
					sparkList.recycleParticle(spark);
				}
				
				sparkColor = (sparkAlpha << 24) | spark.color;
				
				presentAlpha = (sparkBitmapData.getPixel32(spark.pos.x, spark.pos.y) >> 24) & 0xFF;
				
				if (sparkAlpha > presentAlpha) {
					sparkBitmapData.setPixel32(spark.pos.x, spark.pos.y, sparkColor);
				}
				
				spark = nextSpark;
				
			}
			sparkBitmapData.unlock();
			
			//txtOnStage.text = sparkList.numOnStage.toString();
			//txtRecycle.text = sparkList.numInRecycleBin.toString();
			
			//sky:
			grayAmt = 4 + 26*sparkList.numOnStage/5000;
			if (grayAmt > 30) {
				grayAmt = 30;
			}
		}
		
		protected function randomColor():uint {
			var index:int = Math.floor(Math.random()*colorList.length);
			return colorList[index];
		}
		
		override public function destruct():void
		{
			if(sparkBitmapData != null){
				sparkBitmapData.dispose();
			}
			sparkBitmapData = null;
			this.removeEventListener(Event.ENTER_FRAME, onEnter);
			super.destruct();
		}
		
		
	}
}