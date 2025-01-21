


package PWC306;

/**
 * PL/Java implementation for PWC 306
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-306>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC306-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC306-1.jar', 'PWC306', true );
 select sqlj.set_classpath( 'public', 'PWC306' );

 select pwc306.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC306-1.jar', 'PWC306', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.util.stream.*;
import java.sql.SQLException;
import java.util.logging.*;
import java.sql.ResultSet;
import java.sql.Date;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc306",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final Boolean[] task1_pljava( String[] bits ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc306.task1_pljava" );

	List<Boolean> primes = new LinkedList<Boolean>();

	for ( int i = 1; i <= bits.length; i++ ) {
	    int value = Integer.parseInt( String.join( "", Arrays.copyOfRange( bits, 0, i ) ), 2 );
	    primes.add( is_prime( value ) );
	}

	Boolean result[] = new Boolean[ primes.size() ];
	for ( int i = 0; i < result.length; i++ )
	    result[ i ] = primes.get( i );


	return result;

    }


    private final static boolean is_prime( int n ) {
	if ( n <= 1 )
	    return false;

	for ( int i = 2; i < n; i++ )
	    if ( n % i == 0 )
		return false;

	return true;
    }
}
