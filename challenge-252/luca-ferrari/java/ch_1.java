public class ch_1 {
    public static void main( String argv[] ) {
	int sum = 0;
	for ( int i = 0; i < argv.length; i++ ) {
	    if ( argv.length % ( i + 1 ) != 0 )
		continue;

	    sum += Math.pow( Integer.parseInt( argv[ i ] ), 2 );
	}

	System.out.println( sum );
    }
}
