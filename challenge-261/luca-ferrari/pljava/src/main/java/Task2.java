


package PWC261;

/**
 * PL/Java implementation for PWC 261
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-261>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC261-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC261-1.jar', 'PWC261', true );
 select sqlj.set_classpath( 'public', 'PWC261' );

 select pwc261.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC261-1.jar', 'PWC261', true );

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

    @Function( schema = "pwc261",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( int start, int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc261.task2_pljava" );

	while ( grep( start, nums ) )
	    start *= 2;

	return start;
    }

    private static boolean grep( int needle, int[] nums ) {
	for ( int current : nums )
	    if ( current == needle )
		return true;

	return false;
    }
}
