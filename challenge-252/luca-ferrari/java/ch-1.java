package PWC252;

public class ch_1 {
    public static void main( String argv[] ) {
	int sum = 0;
	for ( int i = 0; i < argv.length; i++ ) {
	    if ( agrv.length % i != 0 )
		continue;

	    sum += Integer.parseInt( argv[ i ] ) ^ 2;
	}

	System.out.println( sum );
    }
}
