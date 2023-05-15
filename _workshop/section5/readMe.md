# Documentation

When documenting your API, you just need to annotate the handler functions to describe what you are doing. We use Swagger to generate a JSON file that can be viewed with Swagger UI, or any other service that can parse the Swagger file.

To start, confirm that you are able to generate a Swagger by going to

> https://127.0.0.1:8001/cbswagger

or whatever the port is for your site. You should see a JSON file.

Next, view Swagger UI by going to

To start, confirm that you are able to generate a Swagger by going to

> https://127.0.0.1:8001/cbswaggerUI

or whatever the port is for your site. You should see the Swagger view and your APIs.

## Updating the API Documentation

By default, we did not include any information description the API responses. Let's add that now.

First, we will add the response section to the handler functions. When done, your handler annotations should look like:

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
function first( event, rc, prc ) {
	var test = [ "a", "b", "c" ];
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
	event.getResponse().setData( test );
}
```
> Note: We added the @response lines to each function

By convention, the `reponse.json` files are stored in the `./resources/apidocs` path in the site.

If you reinit the site and try pulling up /cbswagger, you will get an error since those reference files don't exist. We are now going to add them.

Create new directories for `first` and `second` in `./resources/apidocs/api/v1/echo` and add the supporting files.

**First**

`responses.json`

```bash
{
    "200": {
        "description": "My First API",
        "content": {
            "application/json": {
                "schema": {
                    "type": "object",
                    "properties": {
                        "error": {
                            "description": "Flag to indicate an error.",
                            "type": "boolean"
                        },
                        "messages": {
                            "description": "An array of messages related to the request.",
                            "type": "array",
                            "items": {
                                "type": "string"
                            }
						},
						"pagination" : {
							"description": "Pagination information.",
                            "type": "object",
                            "properties": {}
						},
                        "data": {
                            "description": "The data",
                            "type": "struct"
                        }
                    }
				},
				"example": {
					"$ref": "example.200.json"
				}
            }
        }
    }
}
```

`example.200.json`

```bash
{
	"data": ["a", "b", "c"],
	"error": false,
	"pagination": {
		"totalPages": 1,
		"maxRows": 0,
		"offset": 0,
		"page": 1,
		"totalRecords": 0
	},
	"messages": []
}
```

**Second**

`responses.json`

```bash
{
    "200": {
        "description": "Returns the logged in user information",
        "content": {
            "application/json": {
                "example": {
					"$ref": "example.200.json"
				},
                "schema": {
                    "type": "object",
                    "properties": {
                        "error": {
                            "description": "Flag to indicate an error.",
                            "type": "boolean"
                        },
                        "messages": {
                            "description": "An array of messages related to the request.",
                            "type": "array",
                            "items": {
                                "type": "string"
                            }
						},
						"pagination" : {
							"description": "Pagination information.",
                            "type": "object",
                            "properties": {}
						},
                        "data": {
							"$ref" : "../../_schemas/app-user.json"
						}
                    }
                }
            }
        }
	},

	"401": {
        "description": "Invalid or Missing Authentication Credentials",
        "content": {
            "application/json": {
                "example": {
					"$ref": "example.401.json"
				},
                "schema": {
                    "type": "object",
                    "properties": {
                        "error": {
                            "description": "Flag to indicate an error.",
                            "type": "boolean"
                        },
                        "messages": {
                            "description": "An array of messages related to the request.",
                            "type": "array",
                            "items": {
                                "type": "string"
                            }
						},
						"pagination" : {
							"description": "Pagination information.",
                            "type": "object",
                            "properties": {}
						},
                        "data": {
                            "description": "The data packet",
                            "type": "object",
                            "properties": {}
                        }

                    }
                }
            }
        }
    }
}
```

`example.200.json`

```bash
{
	"data": ["d", "e", "f"],
	"error": false,
	"pagination": {
		"totalPages": 1,
		"maxRows": 0,
		"offset": 0,
		"page": 1,
		"totalRecords": 0
	},
	"messages": []
}
```

`example.401.json`

```bash
{
    "data": {},
    "error": true,
    "pagination": {},
    "messages": [
        "Invalid or Missing Authentication Credentials"
    ]
}
```

Reinitialize the framework and view Swagger UI again. You will now see the response data appear in the documentation. This is useful when sharing APIs with others as it will not only tell them how to call the API, but also give an example of what to expect.


[Back](../readMe.md)
