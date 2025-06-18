


package PWC326;

/**
 * PL/Java implementation for PWC 326
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC326-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC326-1.jar', 'PWC326', true );
 select sqlj.set_classpath( 'public', 'PWC326' );

 select pwc326.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC326-1.jar', 'PWC326', true );

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

    @Function( schema = "pwc326",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int[] task2_pljava( int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc326.task2_pljava" );

	List<Integer> result = new LinkedList<Integer>();
	for( int i = 0; i < nums.length - 1; i++ ) {
	    if( i % 2 != 0 )
		continue;

	    int base  = nums[ i ];
	    int times = nums[ i + 1 ];

	    for ( int j = 0; j < times; j++ )
		result.add( base );
	}

	int r[] = new int[ result.size() ];
	for ( int i = 0; i < result.size(); i++ )
	    r[ i ] = result.get( i );

	return r;
    }
}
