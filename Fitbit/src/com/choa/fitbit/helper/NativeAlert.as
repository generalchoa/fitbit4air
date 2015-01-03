package com.choa.fitbit.helper 
{
	import flash.html.HTMLLoader;
    
    /**
     * ...
     * @author Ben Foster
     *      -web: www.nemenvisual.com
     *      -blog: www.purplesquirrels.com.au
     */
    public class NativeAlert
    {
        private var _alertDispatcher:HTMLLoader;
        private var _html:String ="<!DOCTYPE html><html lang='en'><head><meta charset='utf-8'>" +
                    "<title></title><script></script></head><body></body></html>";
            
        public function NativeAlert() 
        {
            _alertDispatcher = new HTMLLoader();
            _alertDispatcher.loadString(_html);
        }
        
        // invokes an alert box
        public function alert(message:String):void
        {
            _alertDispatcher.window.alert(message);
        }

        // invokes a confirm box        
        public function confirm(message:String):Boolean
        {
            return _alertDispatcher.window.confirm(message);
        }

        // invokes a prompt box     
        public function prompt(message:String,defaultVal:String=""):String
        {
            return _alertDispatcher.window.prompt(message, defaultVal);
        }
        
    }


}