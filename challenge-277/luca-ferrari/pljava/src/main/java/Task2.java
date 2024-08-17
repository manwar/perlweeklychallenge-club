public static final int task2_pljava( int[] numbers ) throws SQLException {
    logger.log( Level.INFO, "Entering pwc277.task2_pljava" );

    final int[] c = new int[]{ 0 };
    IntStream.range( 0, numbers.length - 1 )
        .forEach( i -> {
    	    c[ 0 ] += IntStream.range( i + 1, numbers.length )
    		.filter( j -> {
    			return numbers[ i ] != numbers[ j ]
    			    && Math.abs( numbers[ i ] - numbers[ j ] ) < Math.min( numbers[ i ], numbers[ j ] );
    		    } ).count();
    	} );

    return c[ 0 ];
}
