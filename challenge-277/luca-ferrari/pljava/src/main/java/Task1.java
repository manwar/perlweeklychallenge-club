public static int task1_pljava( String[] words1, String[] words2 ) throws SQLException {
    logger.log( Level.INFO, "Entering pwc277.task1_pljava" );

    final Map<String, Integer[]> counting = new HashMap<String, Integer[]>();

    Stream.of( words1 ).forEach( current -> {
    	Integer[] count = { 0, 0 };
    	counting.putIfAbsent( current, count );
    	count = counting.get( current );
    	count[ 0 ]++;
    	counting.put( current, count );
    } );


    Stream.of( words2 ).forEach( current -> {
    	Integer[] count = { 0, 0 };
    	counting.putIfAbsent( current, count );
    	count = counting.get( current );
    	count[ 1 ]++;
    	counting.put( current, count );
    } );

    return (int) counting.entrySet().stream().filter( current -> {
    	Integer[] count = current.getValue();
    	return count[ 0 ] == count[ 1 ] && count[ 0 ] == 1;
    } ).count();
}
