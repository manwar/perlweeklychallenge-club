


package PWC322;

/**
 * PL/Java implementation for PWC 322
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-322>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC322-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC322-1.jar', 'PWC322', true );
 select sqlj.set_classpath( 'public', 'PWC322' );

 select pwc322.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC322-1.jar', 'PWC322', true );

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

    @Function( schema = "pwc322",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static int[] task2_pljava( int[] numbers ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc322.task2_pljava" );

	List<Integer> sorted = new LinkedList<Integer>();

	for ( int i : numbers )
	    sorted.add( i );

	Collections.sort( sorted );

	int index = 1;
	int c = 0;
	int[] result = new int[ numbers.length ];

	for ( int current : numbers ) {
	    index = 1;

	    for ( int seeking : sorted ) {
		if ( seeking == current )
		    break;
		else
		    index++;
	    }

	    result[ c ] = index;
	    c++;
	}

	return result;
    }
}
