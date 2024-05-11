


package PWC268;

/**
 * PL/Java implementation for PWC 268
 * Task 2
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

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc268",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc268.task2_pljava" );

	List<Integer> sorted = new LinkedList<Integer>();
	for ( int i : nums )
	    sorted.add( i );
	Collections.sort( nums );

	int[] result = new int[ nums.length ];
	int index = 0;

	for ( int i = 0; i < sorted.size(); i++ ) {
	    int left = sorted.get( i );
	    int right = sorted.get( ++i );

	    result[ index++ ]   = ( left > right ? left : right );
	    result[ index++ ] = ( left > right ? right : left );
	}

	return result;
    }
}
