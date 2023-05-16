/**
 * My RESTFul Event Handler
 */
component extends="coldbox.system.RestHandler" {

	//property name="myService" inject="MyService";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	 * Say Hello
	 *
	 * @x        -route (GET) /api/v1/echo
	 * @response -default ~api/v1/echo/index/responses.json##200
	 */
	function index( event, rc, prc ){
		event.getResponse().setData( "Welcome to my ColdBox RESTFul Service" );
	}

	/**
	 * A secured route that shows you your information
	 *
	 * @x-route          (GET) /api/v1/whoami
	 * @operationId      /api/v1/echo/whoami
	 * @tags             api/v1
	 * @security         bearerAuth,ApiKeyAuth
	 * @response-default ~api/v1/echo/whoami/responses.json##200
	 * @response-401     ~api/v1/echo/whoami/responses.json##401
	 */
	function whoami( event, rc, prc ) secured{
		event.getResponse().setData( jwtAuth().getUser().getMemento() );
	}

	/**
	 * A unsecured route that shows you your information
	 *
	 * @x-route          (GET) /api/v1/first
	 * @operationId      /api/v1/echo/first
	 * @tags             api/v1
	 * @security         ApiKeyAuth
	 * @response-default ~api/v1/echo/first/responses.json##200
	 */
	function first( event, rc, prc ){
		var test = [ "a", "b", "c" ];
		// var test = myService.getFirstData();
		event.getResponse().setData( test );
	}

	/**
	 * My secured route
	 *
	 * @x-route          (GET) /api/v1/second
	 * @operationId      /api/v1/echo/second
	 * @tags             api/v1
	 * @security         bearerAuth,ApiKeyAuth
	 * @response-default ~api/v1/echo/second/responses.json##200
	 * @response-401     ~api/v1/echo/second/responses.json##401
	 */
	function second( event, rc, prc ) secured{
		var test = [ "d", "e", "f" ];
		// var test = myService.getSecondData();
		event.getResponse().setData( test );
	}

}
