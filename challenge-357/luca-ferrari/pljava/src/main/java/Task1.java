


package PWC357;

/**
 * PL/Java implementation for PWC 357
 * Task 1
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
import java.util.Arrays;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc357",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( int value ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc357.task1_pljava" );

	final int k = 6174;
	int iterations = 0;

	while ( value != k ) {
	    List<Integer> asc  = new LinkedList<Integer>();
	    List<Integer> desc = new LinkedList<Integer>();
	    String current = "" + value;

	    for ( String c : current.split( "" ) ) {
		asc.add( Integer.parseInt( c ) );
		desc.add( Integer.parseInt( c ) );
	    }

	    Collections.sort( asc );
	    Collections.sort( desc, Collections.reverseOrder() );

	    StringBuffer b1 = new StringBuffer();
	    StringBuffer b2 = new StringBuffer();
	    for ( int x : asc )
		b1.append( x );

	    for ( int x : desc )
		b2.append( x );

	    value = Integer.parseInt( b2.toString() ) - Integer.parseInt( b1.toString() );


	    iterations++;
	}

	return iterations;

    }
}
