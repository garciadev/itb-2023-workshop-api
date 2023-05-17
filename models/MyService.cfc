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

	struct function third(){
		return arguments;
	}

}
