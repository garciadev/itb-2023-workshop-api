# Testing

By default, tests are generated for the initial APIs. You can run them at:

> https://127.0.0.1:8001/tests

or whatever the port is for your site.

There are Integration and Unit tests. Integration tests will test the functionality of the handlers (the API called) while Unit tests will test the functionality of the model.

Review the test results and compare them to the test files.

## Create New Integration Tests

In the prior section, you created two new APIs in `Echo.cfc`. Let's now add tests for them.

### /api/v1/first

Open `EchoTests.cfc` and add a new test section. It can look similar to this:

```bash
story( "I want to view the results of my first API", function(){
	given( "a valid call", function(){
		then( "I will view the results", function(){
			var event = this.get( route = "/api/v1/first", params = {} );
			var response = event.getPrivateValue( "Response" );
			expect( response.getData() ).toBeArray();
			expect( response.getData().len() ).toBeGT( 0 );
		} );
	} );
} );
```
Here we are calling the API and confirming the return data is an array and has a length.

### /api/v1/second

Add another test section for the second API. It can look similar to this:

```bash
story( "I want to view the results of my second API", function(){
	given( "a valid email and password", function(){
		then( "I will be authenticated and view the results", function(){
			var jwtService = getInstance( "provider:JwtService@cbsecurity" );
			var credentials = { "email" : "admin@coldbox.org", "password" : "admin" };
			var token = jwtService.attempt( credentials.email, credentials.password );
			var event = this.get( route = "/api/v1/second", params = { "x-auth-token" : token } );

			var response = event.getPrivateValue( "Response" );
			expect( response.getData() ).toBeArray();
			expect( response.getData().len() ).toBeGT( 0 );
			jwtService.logout();
		} );
	} );
	given( "invalid email and password", function(){
		then( "I will receive a 401 exception ", function(){
			getInstance( "provider:JwtService@cbsecurity" ).logout();
			var event = this.get( route = "/api/v1/second", params = {} );
			var response = event.getPrivateValue( "Response" );
			expect( response.getError() ).toBeTrue();
			expect( response.getStatusCode() ).toBe( 401 );
		} );
	} );
} );
```

Here we are calling the second API after logging in and confirming the return data is an array and has a length as well. We have a second test that also checks that we get an error if not logged in when attempting to make the call.

Run the new tests and view results in the browser.

[Back](../readMe.md)
