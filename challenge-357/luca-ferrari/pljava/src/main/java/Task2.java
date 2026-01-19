


package PWC357;

/**
 * PL/Java implementation for PWC 357
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-357>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC357-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC357-1.jar', 'PWC357', true );
 select sqlj.set_classpath( 'public', 'PWC357' );

 select pwc357.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC357-1.jar', 'PWC357', true );

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

    @Function( schema = "pwc357",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String[] task2_pljava( int value ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc357.task2_pljava" );

	List<Integer[]> perms = new LinkedList<Integer[]>();

	for ( int i = 1; i <= value; i++ ) {
	    for ( int j = 1; j <= value; j++ ) {
		perms.add( new Integer[]{ i, j } );
	    }
	}

	Map<Double, Integer[]> fractions = new HashMap<Double, Integer[]>();

	for ( Integer[] current : perms ) {
	    int n = current[ 0 ];
	    int d = current[ 1 ];
	    double v = n / (double) d;

	    if ( fractions.containsKey( v ) ) {
		if ( fractions.get( v )[ 0 ] > n )
		    fractions.put( v, new Integer[]{ n, d } );
	    }
	    else
		fractions.put( v, new Integer[]{ n, d } );
	}


	List<Double> keys = new LinkedList<Double>(  fractions.keySet() );
	Collections.sort( keys );

	String[] results = new String[ keys.size() ];

	for ( int i = 0; i < results.length; i++ ) {
	    Integer[] f = fractions.get( keys.get( i ) );
	    results[ i ] = f[ 0 ] + "/" + f[ 1 ];
	}

	return results;

    }
}
