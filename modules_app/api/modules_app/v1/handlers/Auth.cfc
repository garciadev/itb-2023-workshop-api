/**
 * Authentication Handler
 */
component extends="coldbox.system.RestHandler" {

	// Injection
	property name="userService" inject="UserService";

	/**
	 * Login a user into the application
	 *
	 * @x           -route (POST) /api/v1/login
	 * @requestBody ~api/v1/auth/login/requestBody.json
	 * @response    -default ~api/v1/auth/login/responses.json##200
	 * @response    -401 ~api/v1/auth/login/responses.json##401
	 */
	function login( event, rc, prc ){
		param rc.email    = "";
		param rc.password = "";

		var token = jwtAuth().attempt( rc.email, rc.password );

		event
			.getResponse()
			.setData( token )
			.addMessage(
				"Bearer token created and it expires in #jwtAuth().getSettings().jwt.expiration# minutes"
			);
	}

	/**
	 * Register a new user in the system
	 *
	 * @x           -route (POST) /api/v1/register
	 * @requestBody ~api/v1/auth/register/requestBody.json
	 * @response    -default ~api/v1/auth/register/responses.json##200
	 * @response    -400 ~api/v1/auth/register/responses.json##400
	 */
	function register( event, rc, prc ){
		param rc.fname    = "";
		param rc.lname    = "";
		param rc.email    = "";
		param rc.password = "";

		// Populate, Validate, Create a new user
		prc.oUser = userService.create( validateOrFail( populateModel( "User" ) ) );

		// Log them in if it was created!
		event
			.getResponse()
			.setData( {
				"token" : jwtAuth().fromuser( prc.oUser ),
				"user"  : prc.oUser.getMemento()
			} )
			.addMessage(
				"User registered correctly and Bearer token created and it expires in #jwtAuth().getSettings().jwt.expiration# minutes"
			);
	}

	/**
	 * Logout a user
	 *
	 * @x        -route (POST) /api/v1/logout
	 * @security bearerAuth,ApiKeyAuth
	 * @response -default ~api/v1/auth/logout/responses.json##200
	 * @response -500 ~api/v1/auth/logout/responses.json##500
	 */
	function logout( event, rc, prc ) secured{
		jwtAuth().logout();
		event.getResponse().addMessage( "Successfully logged out" )
	}

}
