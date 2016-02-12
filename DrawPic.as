package {
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.Sprite;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.display.Shape;
	import flash.display.MovieClip;

	public class DrawPic extends Sprite {


		public var obj: Object;
		public var startPoint: Point;
		public var endPoint: Point;
		var midPoint: Point;
		var slopeNorm: Number;
		var bNorm: Number;
		var anchorX: Number;
		var anchorY: Number;
		var anchorPoint: Point;
		var currentPercent: Number;
		var percentMovedPerFrame: Number;
		var stageH: Number
		var speed: Number;
		var timeFade: Number;
		public var finished: Boolean;
		public var finishFade: Boolean;
		public var finishedStraight: Boolean;
		public var finishFadeOut: Boolean;
		var type: Number;
		var moveS: int;
		var end: int;






		public function DrawPic(o: Object, from: Point, to: Point, speed: Number, stageHeight: Number) {

			obj = o;
			MovieClip(o).addChild(this);
			//addChild(obj);
			startPoint = from;
			endPoint = to;
			currentPercent = 0;
			percentMovedPerFrame = 1;
			stageH = stageHeight;
			this.speed = speed * 24;
			finished = false;
			finishFade = false;
			finishedStraight = false;
			finishFadeOut = false;
			if (!(from == null))
				setupMovement();


		}

		public function getPos(): Point {
			return new Point(obj.x, obj.y);
		}

		public function pause() {

			if (this.hasEventListener(Event.ENTER_FRAME)){
				if (type == 1)
					this.removeEventListener(Event.ENTER_FRAME, move);

			if (type == 2)
				this.removeEventListener(Event.ENTER_FRAME, moveAndBounce);

			if (type == 3)
				this.removeEventListener(Event.ENTER_FRAME, fadeIn);

			if (type == 4)
				this.removeEventListener(Event.ENTER_FRAME, fadeOut);

			if (type == 5)
				this.removeEventListener(Event.ENTER_FRAME, moveStraight);
		}
		}

		public function resume() {
			if (!this.hasEventListener(Event.ENTER_FRAME)){

			if (type == 1)
					this.addEventListener(Event.ENTER_FRAME, move);

			if (type == 2)
				this.addEventListener(Event.ENTER_FRAME, moveAndBounce);

			if (type == 3)
				this.addEventListener(Event.ENTER_FRAME, fadeIn);

			if (type == 4)
				this.addEventListener(Event.ENTER_FRAME, fadeOut);
			
			if (type == 5)
				this.addEventListener(Event.ENTER_FRAME, moveStraight);
		}

		}

		public function hasListener() {
			return this.hasEventListener(Event.ENTER_FRAME);
		}



		public function setUpEndPoint(to: Point) {
			endPoint = to;
			setupMovement();

		}

		private function bezier(t: Number, p0: Point, p1: Point, p2: Point): Point {

			var u: Number = 1 - t;
			var tt: Number = t * t;
			var uu: Number = u * u

			var p: Point = new Point(0, 0);
			p.x = uu * p0.x + 2 * u * t * p1.x + tt * p2.x;
			p.y = uu * p0.y + 2 * u * t * p1.y + tt * p2.y;
			return p;
		}


		function getSlopeNorm(p1: Point, p2: Point): Number {

			return (-1) / ((p2.y - p1.y) / (p2.x - p1.x));

		}

		function getMidPoint(p1: Point, p2: Point): Point {

			return new Point((p2.x + p1.x) / 2, (p2.y + p1.y) / 2);
		}

		function getBNorm(m: Number, p: Point): Number {

			return p.y - m * p.x;

		}

		function setupMovement() {


			midPoint = getMidPoint(startPoint, endPoint);
			slopeNorm = getSlopeNorm(startPoint, endPoint);
			bNorm = getBNorm(slopeNorm, midPoint);

			anchorX = midPoint.x
			//trace(midPoint.y);
			//if (midPoint.y > stageH / 2)



			var d = Point.distance(startPoint, endPoint) / 2;
			///200,200
			//utre
			//trace(d);
			if (endPoint.y >= startPoint.y){
				
				anchorX -= Math.sqrt(d * d / (1 + slopeNorm * slopeNorm));
				anchorY = slopeNorm * anchorX + bNorm;
				
				//this
				if(anchorY>stageH){
					anchorX = midPoint.x
					anchorX += Math.sqrt(d * d / (1 + slopeNorm * slopeNorm));
					anchorY = slopeNorm * anchorX + bNorm;
				}
			}
			else{
				anchorX += Math.sqrt(d * d / (1 + slopeNorm * slopeNorm));
				anchorY = slopeNorm * anchorX + bNorm;
				//this
				if(anchorY>stageH){
					anchorX = midPoint.x
					anchorX -= Math.sqrt(d * d / (1 + slopeNorm * slopeNorm));
					anchorY = slopeNorm * anchorX + bNorm;
				}
				
			}


			anchorY = slopeNorm * anchorX + bNorm;
			//var b = anchorY;
			//anchorY -= 2*b;
			
			
			
			anchorPoint = new Point(anchorX, anchorY);



		}


		public function startMove() {
			type = 1;
			startPoint = new Point(obj.x, obj.y);
			finished = false;
			setupMovement();

			this.addEventListener(Event.ENTER_FRAME, move);

		}

		public function startMoveAndBounce() {
			type = 2;
			this.addEventListener(Event.ENTER_FRAME, moveAndBounce);

		}

		public function moveAndBounce(e: Event) {


			var a;
			//var direction = true;

			if (currentPercent <= speed / 2) {

				a = bezier(currentPercent / speed, startPoint, anchorPoint, endPoint);

				currentPercent += percentMovedPerFrame;

				obj.x = a.x;
				obj.y = a.y;

			} else if (currentPercent < speed) {

				a = bezier((speed - currentPercent) / speed, startPoint, anchorPoint, endPoint);

				currentPercent += percentMovedPerFrame;

				obj.x = a.x;
				obj.y = a.y;


			} else {

				obj.x = startPoint.x;
				obj.y = startPoint.y;
				finished = true;
				this.removeEventListener(Event.ENTER_FRAME, moveAndBounce);
				currentPercent = 0;
			}

		}

		public function move(e: Event) {


			var a;

			if (currentPercent <= speed) {

				a = bezier(currentPercent / speed, startPoint, anchorPoint, endPoint);

				currentPercent += percentMovedPerFrame;


				obj.x = a.x;
				obj.y = a.y;

			} else {


				obj.x = endPoint.x;
				obj.y = endPoint.y;
				finished = true;
				this.removeEventListener(Event.ENTER_FRAME, move);

				currentPercent = 0;

			}


		}
		public function startFadeIn(time: Number = 1) {
			type = 3;
			timeFade = 24 * time;
			obj.alpha = 0;
			this.addEventListener(Event.ENTER_FRAME, fadeIn);

		}

		public function startFadeOut(time: Number = 1) {
			type = 4;
			timeFade = 24 * time;
			this.addEventListener(Event.ENTER_FRAME, fadeOut);

		}

		public function fadeOut(e: Event) {
			obj.alpha -= 1 / timeFade;

			if (obj.alpha <= 0) {
				this.removeEventListener(Event.ENTER_FRAME, fadeOut);
				obj.parent.removeChild(obj);
				finishFadeOut = true;
			}


		}

		public function fadeIn(e: Event) {
			obj.alpha += 1 / timeFade;

			if (obj.alpha >= 1) {
				this.removeEventListener(Event.ENTER_FRAME, fadeIn);
				finishFade = true;
			}


		}

		public function startMoveStraight(sp: Number) {
			speed=sp*24;
			type = 5;
			end = 705.20;
			moveS = (end - obj.x);
			addEventListener(Event.ENTER_FRAME, moveStraight);

		}

		function moveStraight(e: Event) {

			obj.x += moveS / speed;

			if (obj.x >= end) {
				obj.x = end;
				this.removeEventListener(Event.ENTER_FRAME, moveStraight);
				finishedStraight = true;
			}


		}



	}





}