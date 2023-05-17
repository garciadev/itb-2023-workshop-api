# Models

Now that we have used CFMigrations to create and populate our tables, we will create a model to query that data.

In the `models` directory, create a new file called `MyService.cfc` with the following

```bash
component {

	property name="qb" inject="provider:queryBuilder@qb";

	array function first(){
		return qb
			.from( "first" )
			.orderBy( "letter", "DESC" )
			.values( "letter" );
	}

	array function second(){
		return qb
			.from( "second" )
			.orderBy( "letter", "DESC" )
			.values( "letter" );
	}

}
```

After injecting qb at the top, we now have two simple functions that will query the database and return the data.

> Note: we are sorting by letter descending to differentiate the hardcoded values currently in the handler.

Next, open the `Echo.cfc` handler and add the following property injection at the top

```bash
property name="myService" inject="MyService";
```

This will inject the MyService model into the handler.

Finally, update the two new API functions to call the new model.

```bash
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
		//var result = [ "a", "b", "c" ];
		var result = myService.first();
		event.getResponse().setData( result );
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
		//var result = [ "d", "e", "f" ];
		var result = myService.second();
		event.getResponse().setData( result );
	}
```

> Note: Be sure to reinitialize the framework when done.

Call the two APIs in Postman and confirm that you are now seeing the data in descending order.

Next, run your tests to make sure they still pass. Since the output of the API is similar, an array of letters, the tests should still pass.

[Back](../readMe.md)
