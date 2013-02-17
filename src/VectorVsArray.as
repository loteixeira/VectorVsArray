package
{
	import br.dcoder.console.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;

	[SWF(width="800", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class VectorVsArray extends Sprite
	{
		private var array:Array;
		private var vector:Vector.<int>;

		private var iterations:uint;
		private var i:uint;
		private var arrayTime:uint;
		private var vectorTime:uint;
		private var running:Boolean;

		//
		// constructor
		//
		public function VectorVsArray()
		{
			Console.create(this);
			Console.instance.caption = "Vector Vs Array";
			Console.instance.draggable = false;
			Console.instance.resizable = false;
			Console.instance.getEventDispatcher().addEventListener(ConsoleEvent.INPUT, consoleInput);

			addEventListener(Event.ADDED_TO_STAGE, resizeConsole);
			addEventListener(Event.RESIZE, resizeConsole);

			start();
		}

		//
		// util
		//
		private function setIterations(iterations:uint):void
		{
			this.iterations = iterations;
			cpln("Number of iterations: " + formatNumber(iterations.toString()));
		}

		private function formatNumber(number:String):String
		{
			var r:String = "";

			for (var i:int = number.length - 1; i >= 0; i--)
			{
				if (i < number.length - 1 && (number.length - 1 - i) % 3 == 0)
					r = "." + r;

				r = number.charAt(i) + r;
			}

			return r;
		}

		//
		// resize console
		//
		private function resizeConsole(e:Event):void
		{
			Console.instance.area = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		}

		//
		// console input
		//
		private function consoleInput(e:ConsoleEvent):void
		{
			if (e.text == "start")
			{
				if (running)
					cpln("TESTING ALREADY RUNNING");
				else
					start();
			}
		}

		//
		// start!
		//
		private function start():void
		{
			running = true;
			array = [];
			vector = new Vector.<int>();

			cpln("STARTING SPEED TEST: VECTOR VS ARRAY")
			cpln("");

			setTimeout(testPush, 10);
		}

		private function testPush():void
		{
			setIterations(10000000);
			cpln("PUSH TEST");

			// array
			var start:uint = getTimer();
			for (i = 0; i < iterations; i++)
				array.push(9999);

			arrayTime = getTimer() - start;
			cpln("array.push in " + arrayTime + " ms");

			// vector
			start = getTimer();
			for (i = 0; i < iterations; i++)
				vector.push(9999);

			vectorTime = getTimer() - start;
			cpln("vector.push in " + vectorTime + " ms");
			cpln("");

			setTimeout(testAccess, 10);
		}

		private function testAccess():void
		{
			cpln("ACCESS TEST");

			// array
			var start:uint = getTimer();
			for (i = 0; i < iterations; i++)
				array[i];

			arrayTime = getTimer() - start;
			cpln("array[i] in " + arrayTime + " ms");

			// vector
			start = getTimer();
			for (i = 0; i < iterations; i++)
				vector[i];

			vectorTime = getTimer() - start;
			cpln("vector[i] in " + vectorTime + " ms");
			cpln("");

			setTimeout(testPop, 10);
		}

		private function testPop():void
		{
			cpln("POP TEST");

			// array
			var start:uint = getTimer();
			for (i = 0; i < iterations; i++)
				array.pop();

			arrayTime = getTimer() - start;
			cpln("array.pop in " + arrayTime + " ms");

			// vector
			start = getTimer();
			for (i = 0; i < iterations; i++)
				vector.pop();

			vectorTime = getTimer() - start;
			cpln("vector.pop in " + vectorTime + " ms");
			cpln("");

			setTimeout(testUnshift, 10);
		}

		private function testUnshift():void
		{
			setIterations(50000);
			cpln("UNSHIFT TEST");

			// array
			var start:uint = getTimer();
			for (i = 0; i < iterations; i++)
				array.unshift(9999);

			arrayTime = getTimer() - start;
			cpln("array.unshift in " + arrayTime + " ms");

			// vector
			start = getTimer();
			for (i = 0; i < iterations; i++)
				vector.unshift(9999);

			vectorTime = getTimer() - start;
			cpln("vector.unshift in " + vectorTime + " ms");
			cpln("");

			setTimeout(testShift, 10);
		}

		private function testShift():void
		{
			cpln("SHIFT TEST");

			// array
			var start:uint = getTimer();
			for (i = 0; i < iterations; i++)
				array.shift();

			arrayTime = getTimer() - start;
			cpln("array.shift in " + arrayTime + " ms");

			// vector
			start = getTimer();
			for (i = 0; i < iterations; i++)
				vector.shift();

			vectorTime = getTimer() - start;
			cpln("vector.shift in " + vectorTime + " ms");
			cpln("");

			setTimeout(complete, 10);
		}

		private function complete():void
		{
			cpln("TEST COMPLETE");
			cpln("");
			cpln("-----");
			cpln("Type 'start' to restart...");
			cpln("");

			running = false;
		}
	}
}