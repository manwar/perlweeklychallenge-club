


package PWC349;

/**
 * PL/Java implementation for PWC 349
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC349-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC349-1.jar', 'PWC349', true );
 select sqlj.set_classpath( 'public', 'PWC349' );

 select pwc349.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC349-1.jar', 'PWC349', true );

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

    @Function( schema = "pwc349",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( String string ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc349.task1_pljava" );

	int result = 0;
	String previous = null;
	int max = 0;

	for ( String current : string.split( "" ) ) {
	    if ( previous == null || ! previous.equals( current ) ) {
		previous = current;

		if ( result > max )
		    max = result;

		result = 0;
	    }


	    result++;
	}

	if ( result > max )
	    max = result;


	return max;
    }
}
