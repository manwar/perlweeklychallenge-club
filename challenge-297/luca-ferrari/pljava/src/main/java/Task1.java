


package PWC297;

/**
 * PL/Java implementation for PWC 297
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC297-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC297-1.jar', 'PWC297', true );
 select sqlj.set_classpath( 'public', 'PWC297' );

 select pwc297.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC297-1.jar', 'PWC297', true );

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

    @Function( schema = "pwc297",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( int[] bits ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc297.task1_pljava" );

	int max_length = 0;
	int current_length;

	for ( int start = 0; start < bits.length - 2; start++ ) {
	    for ( int end = start + 1; end < bits.length - 1; end++ ) {
		long ones  = Arrays.stream( bits, start, end + 1 ).filter( b -> b == 1 ).count();
		long zeros = Arrays.stream( bits, start, end + 1 ).filter( b -> b == 0 ).count();
		current_length = end - start + 1;

		if ( zeros == ones && current_length > max_length )
		    max_length = current_length;
	    }
	}

	return max_length;
    }
}
