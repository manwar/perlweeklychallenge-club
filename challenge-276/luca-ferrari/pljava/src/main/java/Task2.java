


package PWC276;

/**
 * PL/Java implementation for PWC 276
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-276>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC276-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC276-1.jar', 'PWC276', true );
 select sqlj.set_classpath( 'public', 'PWC276' );

 select pwc276.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC276-1.jar', 'PWC276', true );

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

    @Function( schema = "pwc276",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc276.task2_pljava" );

	final Map<Integer, List<Integer>> frequency = new HashMap<Integer, List<Integer>>();

	Arrays.stream( nums )
	    .forEach( v -> {
		    int freq = (int) Arrays.stream( nums ).filter( k -> k == v ).count();
		    frequency.putIfAbsent( freq, new LinkedList<Integer>() );
		    if ( ! frequency.get( freq ).contains( v ) )
			 frequency.get( freq ).add( v );
		} );

	final int[] max = new int[]{ 0, 0 };
	// find out the max frequency
	frequency.keySet().stream().forEach( k -> {
		if ( k > max[ 0 ] ) {
		    max[ 0 ] = k;
		    max[ 1 ] = frequency.get( k ).size();
		}
	    } );

	return max[ 1 ];
    }
}
