


package PWC268;

/**
 * PL/Java implementation for PWC 268
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-268>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC268-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC268-1.jar', 'PWC268', true );
 select sqlj.set_classpath( 'public', 'PWC268' );

 select pwc268.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC268-1.jar', 'PWC268', true );

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

    @Function( schema = "pwc268",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final Integer task1_pljava( int[] left, int[] right ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc268.task1_pljava" );

	List<Integer> l = new LinkedList<Integer>();
	List<Integer> r = new LinkedList<Integer>();

	for ( int i : left )
	    l.add( i );
	for ( int i : right )
	    r.add( i );

	Collections.sort( l );
	Collections.sort( r );
	List<Integer> diffs = new LinkedList<Integer>();

	for ( int i = 0; i < l.size(); i++ ) {
	    int current = l.get( i ) - r.get( i );
	    if ( ! diffs.contains( current ) )
		diffs.add( current );
	}

	if ( diffs.size() == 1 )
	    return diffs.get( 0 );
	else
	    return null;

	
    }
}
