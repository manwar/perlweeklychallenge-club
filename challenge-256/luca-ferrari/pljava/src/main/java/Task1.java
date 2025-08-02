package PWC256;

/**
 * PL/Java implementation for PWC 256
 * Task 1
 * See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
 *
 *
 * To compile on the local machine:

 $ export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/  # if not already set
 $ mvn clean build
 $ scp target/PWC256.jar  luca@venkman:/tmp


 * To install into PostgreSQL execute:

 select sqlj.install_jar( 'file:///tmp/PWC256.jar', 'PWC256', true );

 select 256.task1_pljava();

 and then to redeploy:

 select sqlj.replace_jar( 'file:///tmp/PWC256.jar', 'PWC256', true );

*/

import org.postgresql.pljava.*;
import org.postgresql.pljava.annotation.Function;
import static org.postgresql.pljava.annotation.Function.Effects.IMMUTABLE;
import static org.postgresql.pljava.annotation.Function.OnNullInput.RETURNS_NULL;

import java.util.*;
import java.sql.SQLException;
import java.util.logging.*;

public class Task1 {

    private final static Logger logger = Logger.getAnonymousLogger();

    @Function( schema = "256",
	      onNullInput = RETURNS_NULL,
	       effects = IMMUTABLE )
    public static final int task1_pljava( String[] words ) throws SQLException {
	logger.log( Level.INFO, "Entering task1_pljava" );

	int max = 0;
	for ( String current : words ) {
	    int count = count( current, words );
	    if ( count > max )
		max = count;
	}

	return max;

    }

    private static final int count( String word, String[] words ) {
	int count = 0;
	StringBuilder builder = new StringBuilder();
	builder.append( word );
	word = builder.reverse().toString();

	for ( String w : words )
	    if ( w.equals( word ) )
		count++;

	return count;
    }
}
