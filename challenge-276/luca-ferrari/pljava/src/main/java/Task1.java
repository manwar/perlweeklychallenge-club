


package PWC276;

/**
 * PL/Java implementation for PWC 276
 * Task 1
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

 public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc276",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String[] task1_pljava( int[] hours ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc276.task1_pljava" );

	List<String> result = new LinkedList<String>();
	for ( int i = 0; i < hours.length - 1; i++ )
	    for ( int j = i + 1; j < hours.length; j++ )
		if ( ( hours[ i ] + hours[ j ] ) % 24 == 0 )
		    result.add( String.format( "%02d + %02d", hours[ i ], hours[ j ] ) );

	return result.toArray( new String[ 0 ] );
    }
}
