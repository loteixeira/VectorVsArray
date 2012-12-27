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
		private var vector:Vector.<Number>;

		private var iterations:uint;
		private var arrayRounds:uint;
		private var vectorRounds:uint;
		private var fighting:Boolean;

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

			fight();
		}

		//
		// util
		//
		private function setIterations(iterations:uint):void
		{
			this.iterations = iterations;
			cpln("Number of iterations: " + iterations);
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
			if (e.text == "fight")
			{
				if (fighting)
					cpln("HEY! YOU'RE DISTURBING THE FIGHT!");
				else
					fight();
			}
		}

		//
		// fight!
		//
		private function fight():void
		{
			fighting = true;
			array = [];
			vector = new Vector.<Number>();
			arrayRounds = 0;
			vectorRounds = 0;

			cpln("Ladies and gentlemen!");
			cpln("In the blue corner, available since Flash Player 9.");
			cpln("Also Actionscript/Actionscript2 and even JavaScript: ARRAY!");
			cpln("His challenger, in the red corner, available since Flash Player 10: VECTOR!");
			cpln("Let's get ready to rumble!");
			cpln("(applause)");
			cpln("");
			cpln("Ding ding");
			cpln("");

			setTimeout(testPush, 10);
		}

		private function testPush():void
		{
			setIterations(10000000);

			var i:uint;
			cpln("PUSH TEST");

			var arrayTime:uint;
			var vectorTime:uint;

			// array
			var start:uint = getTimer();
			for (i = 0; i < iterations; i++)
				array.push(1);

			arrayTime = getTimer() - start;
			cpln("array.push in " + arrayTime + " ms");

			// vector
			start = getTimer();
			for (i = 0; i < iterations; i++)
				vector.push(1);

			vectorTime = getTimer() - start;
			cpln("vector.push in " + vectorTime + " ms");
			cpln("");

			if (vectorTime > arrayTime)
				arrayRounds++;
			else
				vectorRounds++;

			setTimeout(testAccess, 10);
		}

		private function testAccess():void
		{
			var i:uint;
			cpln("ACCESS TEST");

			var arrayTime:uint;
			var vectorTime:uint;

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

			if (vectorTime > arrayTime)
				arrayRounds++;
			else
				vectorRounds++;

			setTimeout(testPop, 10);
		}

		private function testPop():void
		{
			var i:uint;
			cpln("POP TEST");

			var arrayTime:uint;
			var vectorTime:uint;

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

			if (vectorTime > arrayTime)
				arrayRounds++;
			else
				vectorRounds++;

			setTimeout(testUnshift, 10);
		}

		private function testUnshift():void
		{
			setIterations(50000);

			var i:uint;
			cpln("UNSHIFT TEST");

			var arrayTime:uint;
			var vectorTime:uint;

			// array
			var start:uint = getTimer();
			for (i = 0; i < iterations; i++)
				array.unshift(1);

			arrayTime = getTimer() - start;
			cpln("array.unshift in " + arrayTime + " ms");

			// vector
			start = getTimer();
			for (i = 0; i < iterations; i++)
				vector.unshift(1);

			vectorTime = getTimer() - start;
			cpln("vector.unshift in " + vectorTime + " ms");
			cpln("");

			if (vectorTime > arrayTime)
				arrayRounds++;
			else
				vectorRounds++;

			setTimeout(testShift, 10);
		}

		private function testShift():void
		{
			var i:uint;
			cpln("SHIFT TEST");

			var arrayTime:uint;
			var vectorTime:uint;

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

			if (vectorTime > arrayTime)
				arrayRounds++;
			else
				vectorRounds++;

			setTimeout(complete, 10);
		}

		private function complete():void
		{
			cpln("Ding ding");
			cpln("");
			cpln("With " + Math.max(arrayRounds, vectorRounds) + "/" + Math.min(arrayRounds, vectorRounds) + " points.");
			cpln("The winner is...");
			cpln("");
			setTimeout(makeDrama, 1000);
		}

		private function makeDrama():void
		{
			cpln(vectorRounds > arrayRounds ? "VECTOR!" : "ARRAY!");
			cpln("(applause)");
			cpln("");
			cpln("-----");
			cpln("Type 'fight' to restart...");
			cpln("");

			fighting = false;
		}
	}
}