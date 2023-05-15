/*******************************************************************************
 *	Integration Test as BDD (CF10+ or Railo 4.1 Plus)
 *
 *	Extends the integration class: coldbox.system.testing.BaseTestCase
 *
 *	so you can test your ColdBox application headlessly. The 'appMapping' points by default to
 *	the '/root' mapping created in the test folder Application.cfc.  Please note that this
 *	Application.cfc must mimic the real one in your root, including ORM settings if needed.
 *
 *	The 'execute()' method is used to execute a ColdBox event, with the following arguments
 *	* event : the name of the event
 *	* private : if the event is private or not
 *	* prePostExempt : if the event needs to be exempt of pre post interceptors
 *	* eventArguments : The struct of args to pass to the event
 *	* renderResults : Render back the results of the event
 *******************************************************************************/
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		// do your own stuff here
	}

	function afterAll(){
		// do your own stuff here
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		describe( "My RESTFUl Service", function(){
			beforeEach( function( currentSpec ){
				// Setup as a new ColdBox request, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			} );

			it( "can handle global exceptions", function(){
				var event = execute(
					event          = "v1:echo.onError",
					renderResults  = true,
					eventArguments = {
						exception : {
							message    : "unit test",
							detail     : "unit test",
							stacktrace : ""
						}
					}
				);

				var response = event.getPrivateValue( "response" );
				expect( response.getError() ).toBeTrue();
				expect( response.getStatusCode() ).toBe( 500 );
			} );

			it( "can handle an echo", function(){
				var event    = this.request( "/api/v1/echo/index" );
				var response = event.getPrivateValue( "response" );
				expect( response.getError() ).toBeFalse();
				expect( response.getData() ).toBe( "Welcome to my ColdBox RESTFul Service" );
			} );

			xit( "can handle missing actions", function(){
				var event    = this.request( "/api/v1/echo/bogus" );
				var response = event.getPrivateValue( "response" );
				expect( response.getError() ).tobeTrue();
				expect( response.getStatusCode() ).toBe( 404 );
			} );
		} );

		story( "I want to view the logged in user", function(){
			given( "a valid email and password", function(){
				then( "I will be authenticated and view who is logged in", function(){
					var jwtService  = getInstance( "provider:JwtService@cbsecurity" );
					var credentials = { "email" : "admin@coldbox.org", "password" : "admin" };
					var token       = jwtService.attempt( credentials.email, credentials.password );
					var event       = this.get( route = "/api/v1/whoami", params = { "x-auth-token" : token } );

					var response = event.getPrivateValue( "Response" );
					expect( response.getError() ).toBeFalse( response.getMessages().toString() );
					expect( response.getData().email ).toBe( credentials.email );

					jwtService.logout();
				} );
			} );
			given( "invalid email and password", function(){
				then( "I will receive a 401 exception ", function(){
					getInstance( "provider:JwtService@cbsecurity" ).logout();
					var event    = this.get( route = "/api/v1/whoami", params = {} );
					var response = event.getPrivateValue( "Response" );
					expect( response.getError() ).toBeTrue();
					expect( response.getStatusCode() ).toBe( 401 );
				} );
			} );
		} );

		story( "I want to view the results of my first API", function(){
			given( "a valid call", function(){
				then( "I will view the results", function(){
					var event    = this.get( route = "/api/v1/first", params = {} );
					var response = event.getPrivateValue( "Response" );
					expect( response.getData() ).toBeArray();
					expect( response.getData().len() ).toBeGT( 0 );
					// expect( response.getStatusCode() ).toBe( 200 );
				} );
			} );
		} );

		story( "I want to view the results of my second API", function(){
			given( "a valid email and password", function(){
				then( "I will be authenticated and view the results", function(){
					var jwtService  = getInstance( "provider:JwtService@cbsecurity" );
					var credentials = { "email" : "admin@coldbox.org", "password" : "admin" };
					var token       = jwtService.attempt( credentials.email, credentials.password );
					var event       = this.get( route = "/api/v1/second", params = { "x-auth-token" : token } );

					var response = event.getPrivateValue( "Response" );
					expect( response.getData() ).toBeArray();
					expect( response.getData().len() ).toBeGT( 0 );
					// expect( response.getStatusCode() ).toBe( 200 );
					jwtService.logout();
				} );
			} );
			given( "invalid email and password", function(){
				then( "I will receive a 401 exception ", function(){
					getInstance( "provider:JwtService@cbsecurity" ).logout();
					var event    = this.get( route = "/api/v1/second", params = {} );
					var response = event.getPrivateValue( "Response" );
					expect( response.getError() ).toBeTrue();
					expect( response.getStatusCode() ).toBe( 401 );
				} );
			} );
		} );
	}

}
