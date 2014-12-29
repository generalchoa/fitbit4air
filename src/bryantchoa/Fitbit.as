package bryantchoa 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
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
			loader.addEventListener( IOErrorEvent.IO_ERROR, requestTokenErrorHandler );
			loader.load(request);
		}
			
		private function requestTokenHandler(e:Event):void {
			trace("Success!");
			trace("Data:\t" + (e.currentTarget as URLLoader).data)
		}
		
		private function requestTokenErrorHandler(e:IOErrorEvent):void 	{
			trace("Failure!");
		}
		
		public function obtainAccessToken(pin:uint):void 	{
			
		}
		
		public function verifyAccessToken(token:OAuthToken):void {
			
		}
		
		public function setStatus(accessToken:OAuthToken, status:String):void {
			
		}
		
	}

}