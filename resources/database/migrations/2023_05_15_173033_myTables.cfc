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
