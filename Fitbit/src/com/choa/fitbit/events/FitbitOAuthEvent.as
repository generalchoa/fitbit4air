package com.choa.fitbit.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Michael-Bryant Choa
	 */
	public class FitbitOAuthEvent extends Event 
	{
		public static const CONSUMER_ERROR:String = "consumerError";
		public static const PIN_ERROR:String = "pinError";
		public static const REQUEST_TOKEN:String = "requestToken";
		public static const ACCESS_TOKEN:String = "accessToken";
		
		public function FitbitOAuthEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new FitbitOAuthEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FitbitOAuthEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}