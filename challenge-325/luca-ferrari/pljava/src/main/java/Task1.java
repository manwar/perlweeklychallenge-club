


package PWC325;

/**
 * PL/Java implementation for PWC 325
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-325>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC325-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC325-1.jar', 'PWC325', true );
 select sqlj.set_classpath( 'public', 'PWC325' );

 select pwc325.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC325-1.jar', 'PWC325', true );

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

    @Function( schema = "pwc325",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( String bits ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc325.task1_pljava" );

	int max_ones    = 0;
	int current_max = 0;

	for ( String d : bits.split( "" ) ) {
	    if ( d.equals( "1" ) )
		current_max++;
	    else {
		if ( current_max > max_ones )
		    max_ones = current_max;

		current_max = 0;

	    }
	}

	return max_ones;
    }
}
