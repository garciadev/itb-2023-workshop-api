component {

	function configure(){
		// API Echo
		get( "/", "Echo.index" );

		// API Authentication Routes
		post( "/login", "Auth.login" );
		post( "/logout", "Auth.logout" );
		post( "/register", "Auth.register" );

		// API Secured Routes
		get( "/whoami", "Echo.whoami" );

		// My routes
		get( "/first", "Echo.first" );
		get( "/second", "Echo.second" );

		route( "/:handler/:action" ).end();
	}

}
