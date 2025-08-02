


package PWC275;

/**
 * PL/Java implementation for PWC 275
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-275>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC275-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC275-1.jar', 'PWC275', true );
 select sqlj.set_classpath( 'public', 'PWC275' );

 select pwc275.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC275-1.jar', 'PWC275', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.util.regex.*;
import java.util.stream.*;
import java.sql.SQLException;
import java.util.logging.*;
import java.sql.ResultSet;
import java.sql.Date;

public class Task2 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "pwc275",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final String task2_pljava( String text ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc275.task2_pljava" );

	Pattern digit = Pattern.compile( "\\d", Pattern.CASE_INSENSITIVE );
	final String[] previous = new String[ 1 ];

	return Stream.of( text.split( "" ) )
	    .map( current -> {
		    if ( digit.matcher( current ).find() ) {
			// a digit

		        current = String.format( "%c", ( (int) previous[ 0 ].charAt( 0 ) + Integer.parseInt( current ) ) );

		    }
		    else {
			previous[ 0 ] = current;
		    }

		    return current;
		} )
	    .collect( Collectors.joining("") );
    }
}
