component {

	property name="qb" inject="provider:queryBuilder@qb";

	array function getFirstData(){
		return qb
			.from( "first" )
			.orderBy( "letter", "DESC" )
			.values( "letter" );
	}

	array function getSecondData(){
		return qb
			.from( "second" )
			.orderBy( "letter", "DESC" )
			.values( "letter" );
	}

}
