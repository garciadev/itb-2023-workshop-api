# Routes and Handlers

The API has been created under the `./modules_app/api/v1` directory.

By default, this directory contains a config directory with `Router.cfc`, which will contain the API routes, and `Scheduler.cfc`, which can be used to create Scheduled Tasks for the module. We will not be using Scheduled Tasks at the moment.

## Routes

The routes are defined in `Router.cfc`. You can specify them individually using the HTTP verb and specifying the path, then the handler CFC and function to call.

Here are the default routes created by the app wizard:

```bash
// API Echo
get( "/", "Echo.index" );

// API Authentication Routes
post( "/login", "Auth.login" );
post( "/logout", "Auth.logout" );
post( "/register", "Auth.register" );

// API Secured Routes
get( "/whoami", "Echo.whoami" );
```

## Postman

Postman is a handy tool for testing API calls. Import the Postman collection in the `./_workshop` directory and try testing the APIs.

After importing the collection, create a Local environment with the following two variables

* API_Server
* API_Token

For API_Server, set the initial and current value to the URL of your API. For example, `https://127.0.0.1:8001`

The API_Token value will get populated when we authenticate.

> Make sure you save the environment

Go to the collection and select your new Local environment in the top right corner.

Click through the API calls and confirm the results.


## Creating Routes

Add two new routes and functions to test.

Edit `Echo.cfc` and add

```bash
	/**
	 * A unsecured route that shows you your information
	 *
	 * @x-route          (GET) /api/v1/first
	 * @operationId      /api/v1/echo/first
	 * @tags             api/v1
	 * @security         ApiKeyAuth
	 */
	function first( event, rc, prc ) {
		var result = [ "a", "b", "c" ];
		event.getResponse().setData( result );
	}

	/**
	 * My secured route
	 *
	 * @x-route          (GET) /api/v1/second
	 * @operationId      /api/v1/echo/second
	 * @tags             api/v1
	 * @security         bearerAuth,ApiKeyAuth
	 */
	function second( event, rc, prc ) secured{
		var result = [ "d", "e", "f" ];
		event.getResponse().setData( result );
	}
```

Next, add the new routes to `Router.cfc`:

```bash
// My routes
get( "/first", "Echo.first" );
get( "/second", "Echo.second" );
```

Reinitialize or restart the site since the routes were changed.

`fwreinit` or `restart`

You can try accessing the new routes in a browser:

* https://127.0.0.1:8001/api/v1/first
* https://127.0.0.1:8001/api/v1/second

Or use Postman to test them.

[Back](../readMe.md)
