package 
{
	import bryantchoa.Fitbit;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Michael Choa
	 */
	public class Main extends Sprite 
	{
		private static var CONSUMER_KEY:String = "844d51057b9744c3aa58f948b57ee86f";
		private static var CONSUMER_SECRET:String = "3123d1f736784a40b73e3f577b658133";
		
		private var _fitbit:Fitbit;
		
		public function Main():void 
		{
			if (stage)
				initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			_fitbit = new Fitbit(CONSUMER_KEY, CONSUMER_SECRET);
			_fitbit.authenticate();
		}
	}
}