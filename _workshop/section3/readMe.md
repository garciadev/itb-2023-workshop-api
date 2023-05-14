# Routes and Handlers

The API has been created under the `modules_app\api\v1` directory.

By default, this directory contains a config directory with `Router.cfc`, which will contain the API routes, and `Scheduler.cfc`, which can be used to create Scheduled Tasks for the module. We will not be using Scheduled Tasks with this workshop.

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

Create a new handler and 

[Back](../readMe.md)
