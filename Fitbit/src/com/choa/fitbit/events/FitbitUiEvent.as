package com.choa.fitbit.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Michael-Bryant Choa
	 */
	public class FitbitUiEvent extends Event 
	{
		public static const FITBIT_UI_SUBMIT_PIN_EVENT:String = "submitPin";
		
		public function FitbitUiEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);	
		} 
		
		public override function clone():Event 
		{ 
			return new FitbitUiEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FitbitUiEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}