


package PWC298;

/**
 * PL/Java implementation for PWC 298
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC298-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC298-1.jar', 'PWC298', true );
 select sqlj.set_classpath( 'public', 'PWC298' );

 select pwc298.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC298-1.jar', 'PWC298', true );

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

    @Function( schema = "pwc298",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( int[] plain_intervals ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc298.task2_pljava" );

	int index = 0;
	int intervals[][] = new int[ plain_intervals.length / 2 ][ 2 ];

	for ( int i = 0; i < plain_intervals.length; i++ ) {
	    intervals[ index ][ 0 ]   = plain_intervals[ i ];
	    intervals[ index++ ][ 1 ] = plain_intervals[ ++i ];
	}


	int return_values[] = new int[ intervals.length ];
	index = 0;


	for ( int current = 0; current < intervals.length; current++ ) {

	    int current_min_value = Integer.MAX_VALUE;
	    int current_min_index = -1;


	    for ( int other = 0; other < intervals.length; other++ ) {
		if ( other == current )
		    continue;

		if ( intervals[ other ][ 0 ] >= intervals[ current ][ 1 ] ) {

		    if ( current_min_value > intervals[ other ][ 0 ] ) {
			current_min_value = intervals[ other ][ 0 ];
			current_min_index = other;
		    }
		}

	    }

	    return_values[ index++ ] = current_min_index;
	}

	return return_values;
    }
}
