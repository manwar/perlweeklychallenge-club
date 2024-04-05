


package PWC263;

/**
 * PL/Java implementation for PWC 263
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC263-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC263-1.jar', 'PWC263', true );
 select sqlj.set_classpath( 'public', 'PWC263' );

 select pwc263.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC263-1.jar', 'PWC263', true );

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

    @Function( schema = "pwc263",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task1_pljava( int k, int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc263.task1_pljava" );

	List<Integer> source = new LinkedList<Integer>();
	for ( int v : nums )
	    source.add( v );

	Collections.sort( source );

	final List<Integer> result = new LinkedList<Integer>();
	IntStream.range( 0, source.size() )
	    .forEach( index -> {
		    if ( source.get( index ) == k )
			result.add( index );
		} );

	int res[] = new int[ result.size() ];
	for ( int i = 0; i < res.length; i++ )
	    res[ i ] = result.get( i );

	return res;

    }
}
