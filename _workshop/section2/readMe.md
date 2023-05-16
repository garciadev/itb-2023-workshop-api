# Creating the REST API

We will use the app wizard in CommandBox to create a new API site using the Modular (API/REST) template.

```bash
coldbox create app-wizard
```

1. Enter the name: MyAPI
2. Are you currently inside the folder: y
3. Are you creating an API: y
4. Which template to use: Modular (API/REST)

This will generate an HMVC API, install dependencies, and stub out the files.

We will also install additional modules to use later:

```bash
install cbDebugger,cbSwagger,cbSwaggerUI,sqlformatter,cfmigrations,qb
```

## Environment Variables

If you want to specify server settings, you can either edit the server.json file or set environment variables for CommandBox to use. Add this to the `.env` file to specify the CF Engine, IP, and ports.

```bash
# Server Settings
BOX_SERVER_APP_CFENGINE=lucee@5.3.10
BOX_SERVER_WEB_HOST=127.0.0.1
BOX_SERVER_WEB_HTTP_PORT=8000
BOX_SERVER_WEB_SSL_ENABLE=true
BOX_SERVER_WEB_SSL_PORT=8001
BOX_SERVER_WEB_ACCESSLOGENABLE=true
```

> If you want others to use similar settings, you can add that to the `.env.example` file so they can use it as a guide for their environments.

You should also specify a JWT Secret to use when generating tokens. Specifying a value here will allow tokens to be validated after server restarts if using external storage like a database.

An easy token generator to use is CommandBox to generate a UUID.

Run this from CommandBox and copy the value into the `.env` file: `repl createUUID()`

```bash
# JWT Information
JWT_SECRET=442D3682-BA4C-42BC-864839C453B4F64E
```

If you did not want to use environment variables, you could also set these values in the server.json file similar to:

```bash
{
    "name":"api",
    "app":{
        "cfengine":"lucee@5.3.10"
    },
    "web":{
        "host":"127.0.0.1",
        "rewrites":{
            "enable":true
        },
        "http":{
            "port":"8000"
        },
        "SSL":{
            "enable":true,
            "port":"8001"
        },
        "accessLogEnable":true
    }
}
```

Environment variables are easier to use and then you are not hard-coding server values into source control.

> **Note:** After editing the environment variables, it is a good idea to reload the shell so that it knows about the changes. From CommandBox, type: `reload` or just `r`

## Server

To start the new server, type `start`

You can stop the server by typing `stop`

You can perform a restart by typing `restart`

For this site, starting the server should open up a browser with the API endpoint.

[Back](../readMe.md)
