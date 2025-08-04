


package PWC333;

/**
 * PL/Java implementation for PWC 333
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC333-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC333-1.jar', 'PWC333', true );
 select sqlj.set_classpath( 'public', 'PWC333' );

 select pwc333.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC333-1.jar', 'PWC333', true );

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

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc333",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( int[] numbers ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc333.task2_pljava" );

	List<Integer> result = new LinkedList<Integer>();
	int limit = numbers.length;

	for ( int i = 0; i < numbers.length && limit > 0; i++ ) {
	    result.add( numbers[ i ] );
	    limit--;
	    if ( limit == 0 )
		break;

	    if ( numbers[ i ] == 0 ) {
		result.add( numbers[ i ] );
		limit--;
	    }
	}

	int[] tmp = new int[ result.size() ];
	for ( int i = 0; i < tmp.length; i++ )
	    tmp[ i ] = result.get( i );

	return tmp;

    }
}
