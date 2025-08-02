


package PWC262;

/**
 * PL/Java implementation for PWC 262
 * Task 2
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-262>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC262-1.jar  luca@rachel:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC262-1.jar', 'PWC262', true );
 select sqlj.set_classpath( 'public', 'PWC262' );

 select pwc262.task2_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC262-1.jar', 'PWC262', true );

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

    @Function( schema = "pwc262",
	       onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task2_pljava( int k, int[] nums ) throws SQLException {
	logger.log( Level.INFO, "Entering pwc262.task2_pljava" );

	int pairs = 0;
	for ( int i = 0; i < nums.length; i++ )
	    for ( int j = i + 1; j < nums.length; j++ )
		if ( nums[ i ] != nums[ j ]
		     || ( i * j ) % k != 0 )
		    continue;
		else
		    pairs++;

	return pairs;

    }
}
