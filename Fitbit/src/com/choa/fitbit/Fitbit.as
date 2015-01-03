package com.choa.fitbit 
{
	import com.choa.fitbit.events.FitbitOAuthEvent;
	import com.choa.fitbit.events.FitbitUiEvent;
	import com.choa.fitbit.helper.HttpUtility;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.utils.Dictionary;
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;

	/**
	 * ...
	 * @author Michael Choa
	 */
	public class Fitbit extends EventDispatcher implements IFitbit
	{
		public static const REQUEST_TOKEN:String = "https://api.fitbit.com/oauth/request_token";
		public static const ACCESS_TOKEN:String = "https://api.fitbit.com/oauth/access_token";
		public static const AUTHORIZE:String = "https://www.fitbit.com/oauth/authorize";
		
		protected var signature:OAuthSignatureMethod_HMAC_SHA1 = new OAuthSignatureMethod_HMAC_SHA1();
		
		private var _consumerKey:String;
		private var _consumerSecret:String;
		
		private var _consumer:OAuthConsumer;
		
		private var _tempAccessToken:String;
		private var _tempAccessTokenSecret:String;
		private var _permanentAccessToken:String;
		private var _permanentAccessTokenSecret:String;
		
		public function set consumerKey( key : String ) : void {
			_consumerKey = key;
		}
		
		public function set consumerSecret( secret : String ) : void {
			_consumerSecret = secret;
		}
		
		public function get consumer():OAuthConsumer {
			if ( _consumer == null && _consumerKey != null && _consumerSecret != null ) {
				_consumer = new OAuthConsumer( _consumerKey, _consumerSecret );
			}
			return _consumer;
		}
		
		public function get tempAccessToken():String {
			return _tempAccessToken;
		}
		
		public function Fitbit(consumerKey:String, consumerSecret:String) {
			_consumerKey = consumerKey;
			_consumerSecret = consumerSecret;
		}
		
		public function authenticate():void {
			var oauthRequest:OAuthRequest = new OAuthRequest( "POST", REQUEST_TOKEN, null, consumer, null );
			var request:URLRequest = new URLRequest(REQUEST_TOKEN);
			var requestHeader:URLRequestHeader = oauthRequest.buildRequest( signature, OAuthRequest.RESULT_TYPE_HEADER );
			var headers:Array = [];
			headers.push(requestHeader);
			request.requestHeaders = headers;
			request.method = "POST";
			var loader:URLLoader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, requestTokenHandler );
			loader.addEventListener( IOErrorEvent.IO_ERROR, tokenErrorHandler );
			loader.load(request);
		}
			
		private function requestTokenHandler(e:Event):void {
			var tempOAuthTokens:Dictionary = HttpUtility.parseQueryString( (e.currentTarget as URLLoader).data as String);
			_tempAccessToken = tempOAuthTokens["oauth_token"];
			_tempAccessTokenSecret = tempOAuthTokens["oauth_token_secret"];
			dispatchEvent(new FitbitOAuthEvent(FitbitOAuthEvent.REQUEST_TOKEN));
		}
		
		public function obtainAccessToken(pin:String):void 	{
			if (pin == null || pin == "") {
				dispatchEvent(new FitbitOAuthEvent(FitbitOAuthEvent.PIN_ERROR));
				return;
			}
			var oauthRequest:OAuthRequest = new OAuthRequest( "POST", ACCESS_TOKEN, { "oauth_verifier" : pin }, consumer, new OAuthToken( _tempAccessToken, _tempAccessTokenSecret ) );
			var request:URLRequest = new URLRequest(ACCESS_TOKEN);
			var requestHeader:URLRequestHeader = oauthRequest.buildRequest( signature, OAuthRequest.RESULT_TYPE_HEADER );
			var headers:Array = [];
			headers.push(requestHeader);
			request.requestHeaders = headers;
			request.method = "POST";
			var loader:URLLoader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, accessTokenHandler );
			loader.addEventListener( IOErrorEvent.IO_ERROR, tokenErrorHandler );
			loader.load(request);
		}
		
		private function accessTokenHandler(e:Event):void 
		{
			var permanentAccessTokens:Dictionary = HttpUtility.parseQueryString( (e.currentTarget as URLLoader).data as String );
			_permanentAccessToken = permanentAccessTokens["oauth_token"];
			_permanentAccessTokenSecret = permanentAccessTokens["oauth_token_secret"];
		}
		
		private function tokenErrorHandler(e:IOErrorEvent):void 
		{
			
		}
		
		public function verifyAccessToken(token:OAuthToken):void {
			
		}
		
		public function setStatus(accessToken:OAuthToken, status:String):void {
			
		}
		
	}

}