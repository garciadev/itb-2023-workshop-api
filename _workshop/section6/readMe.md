# Database

When building APIs, it is easy to wire up a database to get data. When using CFMigrations, you can also build the table definitions and have them created with CommandBox.

For this section, we are going to use CFMigrations to create our tables.

First, lets make sure your `.env` file has a valid config for the database. If using MySQL, it should look similar to this, but with your own database info and credentials.

```bash
# Database Information
# MYSQL VERSION
DB_SCHEMA=coldbox
DB_DATABASE=coldbox
DB_CLASS=com.mysql.cj.jdbc.Driver
DB_CONNECTIONSTRING=jdbc:mysql://localhost:3306/coldbox?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true
DB_USER=username
DB_PASSWORD=password
```
Reload CommandBox.

Next, create a `.cfmigrations.json` in the root of the website.

```bash
{
    "default": {
        "manager": "cfmigrations.models.QBMigrationManager",
        "migrationsDirectory": "resources/database/migrations/",
        "seedsDirectory": "resources/database/seeds/",
        "properties": {
            "defaultGrammar": "AutoDiscover@qb",
            "schema": "${DB_SCHEMA}",
            "migrationsTable": "cfmigrations",
            "connectionInfo": {
                "password": "${DB_PASSWORD}",
                "connectionString": "${DB_CONNECTIONSTRING}",
                "class": "${DB_CLASS}",
                "username": "${DB_USER}",
                "bundleName": "${DB_BUNDLENAME}",
                "bundleVersion": "${DB_BUNDLEVERSION}"
            }
        }
    }
}
```

The environment variables referenced should match what we just updated in the `.env` file. If you are using MS SQL Server, you can find alternate configuration <a href="https://github.com/commandbox-modules/commandbox-migrations" target="_blank">here</a>.

Within the root of your site, run this from CommandBox from: `migrate install`

If successful, you should now have a new `cfmigrations` table in your database. This will be used to track the migrations created.

## Creating Migration Files

We are going to create a migration file to create and populate two tables.

Run this from CommandBox:  `migrate create myTables`

The new migration file can be found under `./resources/database/migrations`

We will now use QB to create the tables and populate them.

Update the new migration file to look like

```bash
component {

    function up( schema, qb ) {
        schema.create( "first", function( table ) {
			table.string( "letter", 1 );
		} );

        schema.create( "second", function( table ) {
			table.string( "letter", 1 );
		} );

        // Populate tables
        qb.newQuery().from( "first" ).insert( [
            { "letter" = "a" },
            { "letter" = "b" },
            { "letter" = "c" }
        ] );

        qb.newQuery().from( "second" ).insert( [
            { "letter" = "d" },
            { "letter" = "e" },
            { "letter" = "f" }
        ] );

    }

    function down( schema, qb ) {
        schema.dropIfExists( "first" );
        schema.dropIfExists( "second" );
    }

}
```

When running `migrate up`, the two tables will be created and populated. 

To remove them, run `migrate down`.

Check your database to see the results.

[Back](../readMe.md)
